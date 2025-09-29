# Packages ---------

library(here)
library(jsonlite)
library(fs)
library(glue)
library(stringr)

# Function to Write Meta Page for Quarto ---------

write_info_page <- function(plot_obj, plot_id, volume, csv_suffix, plot_suffix = NULL, has_legend = TRUE) {
  
  # Convert csv_suffix to vector if it's a single value (for backward compatibility)
  if (length(csv_suffix) == 1) {
    csv_suffixes <- csv_suffix
  } else {
    csv_suffixes <- csv_suffix
  }
  
  # Function to process a single metadata file
  process_metadata <- function(suffix) {
    # --- Construct Dataset and Metadata File Paths ----
    
    dataset_file <- here("data", "clean",
                      glue("Band{volume}"),
                      glue("{plot_id}"),
                      glue("{plot_id}_{suffix}_Data.csv"))
    
    metadata_file <- glue("{dataset_file}-metadata.json")
    
    ## --- Create Markdown Link for Path to Dataset ---
    data_rel_path <- fs::path_rel(dataset_file, start = here())
    data_rel_path <- gsub("^docs/", "", data_rel_path)
    data_link <- glue("[{data_rel_path}](/", data_rel_path, ")")
    
    ## --- Create Markdown Link for Path to JSON ---
    meta_rel_path <- fs::path_rel(metadata_file, start = here())
    meta_rel_path <- gsub("^docs/", "", meta_rel_path)
    meta_link <- glue("[{meta_rel_path}](/", meta_rel_path, ")")
    
    # --- Extract Metadata from File ----
    meta <- fromJSON(metadata_file)
    schema <- meta$tables$tableSchema
    
    fig_id <- schema$isPartOf$ObjectID[[1]]
    fig_link <- glue("{fig_id} ([Research Data Platform](https://forschung.stadtgeschichtebasel.ch/items/{fig_id}.html))")
    
    publisher <- schema$publisher[[1]]
    publisher_link <- glue("[{publisher}](https://www.wikidata.org/wiki/Q122442230)")
    
    # not parsed at the moment, listing SGB instead
    #creators <- unlist(schema$creator[[1]])
    #creators_str <- paste(creators, collapse = ", ")
    creators_str <- publisher_link
    
    contributors <- unlist(schema$contributor[[1]])
    contributors_str <- paste(contributors, collapse = ", ")
    
    license <- schema$license[[1]]
    license_link <- glue("[{license}]({license})")
    
    ## --- Map Volume Numbers to Open Access DOIs ---
    vol_text <- schema$isPartOf$volume[[1]]
    vol_short <- str_extract(vol_text, "Stadt\\.Geschichte\\.Basel\\s*\\d+")
    vol_num <- as.integer(str_extract(vol_short, "\\d+"))
    
    doi_suffixes <- c(
      "01-406352", "02-404936", "03-345800",
      "04-283636", "05-155353", "06-810743",
      "07-663402", "08-796384", "09-486500"
    )
    
    if (!is.na(vol_num) && vol_num >= 1 && vol_num <= length(doi_suffixes)) {
      vol_link <- glue("[Stadt.Geschichte.Basel {vol_num}](https://doi.org/10.21255/sgb-{doi_suffixes[vol_num]})")
      vol_text <- sub(vol_short, vol_link, vol_text, fixed = TRUE)
    }
    
    # --- Create Table with Metadata Fields ---
    fields <- list(
      Figure        = fig_link,
      Title         = schema$title[[1]],
      Description   = schema$description[[1]],
      Creator       = creators_str,
      Contributors  = contributors_str,
      Publisher     = publisher_link,
      Date          = schema$date[[1]],
      Coverage      = schema$coverage[[1]],
      "is Part of"  = vol_text,
      Dataset       = data_link,
      "Source (Dataset)"       = schema$source[[1]],
      "Metadata (Dataset)"     = meta_link,
      "Citation (Dataset)"     = schema$bibliographicCitation[[1]],
      Rights        = schema$rights[[1]],
      License       = license_link,
      Modified      = schema$modified[[1]]
    )
    
    return(list(fields = fields, schema = schema, vol_short = vol_short))
  }
  
  # Process all metadata files
  metadata_list <- lapply(csv_suffixes, process_metadata)
  
  # Use the first metadata for main document properties (title, date, etc.)
  main_metadata <- metadata_list[[1]]
  
  # --- infer plot object name (string) and subplot script name ----
  plot_name <- deparse(substitute(plot_obj))   # e.g. "plot80238a" or "plot88300"
  base_name  <- sub("^plot", "", plot_name)    # e.g. "80238a" or "88300"
  
  ## Prefer the explicit subplot script <base_name>_plot.R if it exists in src/<plot_id>/
  candidate_script <- here("src", plot_id, paste0(base_name, "_plot.R"))
  
  if (fs::file_exists(candidate_script)) {
    plot_script <- candidate_script
  } else {
    # fallback: try the generic <plot_id>_plot.R (single-script case), otherwise search for any *_plot.R
    generic_script <- here("src", plot_id, paste0(plot_id, "_plot.R"))
    if (fs::file_exists(generic_script)) {
      plot_script <- generic_script
    } else {
      # look for any *_plot.R in the directory and try to choose the best match
      candidates <- dir_ls(here("src", plot_id), regexp = "_plot\\.R$", type = "file")
      if (length(candidates) == 0) {
        stop("No plot script found in ", here("src", plot_id))
      }
      # prefer a candidate whose basename contains the base_name
      names_cand <- fs::path_file(candidates)
      idx <- which(str_detect(names_cand, fixed(base_name)))
      if (length(idx) == 1) {
        plot_script <- candidates[idx]
      } else {
        # fallback to first candidate
        plot_script <- candidates[1]
      }
    }
  }
  
  # --- Create ggplot ----
  ## --- read ggplot call up to '# Write Info Page' in the resolved script ----
  script_lines <- readLines(plot_script, warn = FALSE)
  cutoff <- grep("^# Write Info Page", script_lines)
  if (length(cutoff) == 0) {
    stop("No '# Write Info Page' marker found in ", plot_script, 
         "\nIf this is a wrapper script, call write_info_page() from the subplot script (e.g. 80238a_plot.R), or add the marker.")
  }
  first_section <- script_lines[seq_len(cutoff - 1)]
  
  ## --- write plot chunk with or without legend ---
  if (isTRUE(has_legend)) {
    plot_chunk <- c(
      "```{r plot_object}",
      "#| echo: false",
      "#| message: false",
      "#| warning: false",
      "#| column: page-right",
      "#| fig-cap: \"Preview only. Refer to the Research Data Platform for full metadata and production-ready files.\"",
      glue("{plot_name} + theme(legend.position = \"right\")"),
      "```"
    )
  } else {
    plot_chunk <- c(
      "```{r plot_object}",
      "#| echo: false",
      "#| message: false",
      "#| warning: false",
      "#| fig-cap: \"Preview only. Refer to the Research Data Platform for full metadata and production-ready files.\"",
      glue("{plot_name}"),
      "```"
    )
  }
  
  # --- Build metadata tables for each dataset ---
  table_chunks <- c()
  for (i in seq_along(metadata_list)) {
    fields <- metadata_list[[i]]$fields
    
    table_title <- if (length(metadata_list) > 1) {
      glue("Dataset Overview ({i}/{length(metadata_list)}, Subset {plot_id}_{csv_suffixes[i]})")
    } else {
      glue("Dataset Overview ({plot_id}_{csv_suffixes[i]})")
    }
    
    chunk_name <- if (length(metadata_list) > 1) {
      glue("table{i}")
    } else {
      "table"
    }
    
    table_chunk <- c(
      glue("```{{r {chunk_name}, results=\"asis\"}}"),
      "#| echo: false",
      "#| message: false",
      "",
      "library(knitr)",
      "",
      "df <- data.frame(",
      "  Key = c(",
      paste0("    \"", names(fields), "\"", collapse = ",\n"),
      "  ),",
      "  Value = c(",
      paste0("    \"", unlist(fields), "\"", collapse = ",\n"),
      "  ),",
      "  stringsAsFactors = FALSE",
      ")",
      "",
      glue("knitr::kable(df, format = \"markdown\", caption = \"{table_title}\")"),
      "```"
    )
    
    table_chunks <- c(table_chunks, table_chunk)
  }
  
  # --- Build .qmd file ----
  plotid_meta <- if (is.null(plot_suffix)) {
    glue("abb{plot_id}")
  } else {
    glue("abb{plot_id}_{plot_suffix}")
  }
  
  qmd_text <- c(
    "---",
    glue("title: \"{main_metadata$schema$title[[1]]}\""),
    "subtitle: Plot and Data Preview",
    glue("date-modified: {as.Date(main_metadata$schema$modified[[1]])}"),
    glue("volume: \"{main_metadata$schema$isPartOf$volume[[1]]}\""),
    glue("vol_short: \"{main_metadata$vol_short}\""),
    glue("plotid: \"{plotid_meta}\""),
    "format:",
    "  html:",
    "    fig-width: 8",
    "    title-block-categories: false",
    "fig-cap-location: top",
    "---",
    "",
    "```{r setup, include=FALSE}",
    "#| echo: false",
    "#| message: false",
    "# only source the first_section of the plot script that actually generates the plot",
    paste(first_section, collapse = "\n"),
    "```",
    "",
    plot_chunk,
    "",
    table_chunks
  )
  
  outdir <- here("docs", "plots")
  dir_create(outdir)
  
  outfile <- if (is.null(plot_suffix)) {
    path(outdir, glue("{plot_id}.qmd"))
  } else {
    path(outdir, glue("{plot_id}_{plot_suffix}.qmd"))
  }
  
  writeLines(qmd_text, outfile)
}