# Updated write_info_page() for new CSVW-compliant metadata -------------------

write_info_page <- function(plot_obj, plot_id, volume, csv_suffix, plot_suffix = NULL, has_legend = TRUE) {
  library(here)
  library(jsonlite)
  library(fs)
  library(glue)
  library(stringr)
  
  if (length(csv_suffix) == 1) {
    csv_suffixes <- csv_suffix
  } else {
    csv_suffixes <- csv_suffix
  }
  
  # Helper to extract language-tagged field (e.g. dc:title$de)
  extract_lang <- function(field, lang = "de") {
    if (is.list(field)) {
      if (!is.null(field[[lang]])) return(field[[lang]])
      else return(unlist(field)[1])
    }
    return(field)
  }
  
  # Process one metadata JSON ------------------------
  process_metadata <- function(suffix) {
    dataset_file <- here(
      "data", "clean",
      glue("Band{volume}"),
      glue("{plot_id}"),
      glue("{plot_id}_{suffix}_Data.csv")
    )
    
    metadata_file <- glue("{dataset_file}-metadata.json")
    meta <- fromJSON(metadata_file)
    
    # --- Extract top-level fields ----
    title <- extract_lang(meta$`dc:title`)
    description <- extract_lang(meta$`dc:description`)
    coverage <- extract_lang(meta$`dc:coverage`)
    source <- extract_lang(meta$`dc:source`)
    publisher <- meta$`dc:publisher`$`schema:name`
    license <- meta$`dc:license`$`@id`
    rights <- meta$`dc:rights`
    date <- meta$`dc:date`
    modified <- if (!is.null(meta$`dc:modified`$`@value`)) meta$`dc:modified`$`@value` else NA
    relation <- meta$`dcat:distribution`
    creators <- sapply(meta$`dc:creator`, function(c) c$`schema:name`)
    contributors <- sapply(meta$`dc:contributor`, function(c) c$`schema:name`)
    
    # --- Build links ----
    data_rel_path <- fs::path_rel(dataset_file, start = here("docs", "plots"))
    data_link <- glue("[{fs::path_rel(dataset_file, start = here())}]({data_rel_path})")
    
    meta_rel_path <- fs::path_rel(metadata_file, start = here("docs", "plots"))
    meta_link <- glue("[{fs::path_rel(metadata_file, start = here())}]({meta_rel_path})")
    
    # --- DOI Volume mapping ----
    doi_suffixes <- c(
      "01-406352", "02-404936", "03-345800",
      "04-283636", "05-155353", "06-810743",
      "07-663402", "08-796384", "09-486500"
    )
    if (!is.na(volume) && volume >= 1 && volume <= length(doi_suffixes)) {
      vol_link <- glue("[Stadt.Geschichte.Basel {volume}](https://doi.org/10.21255/sgb-{doi_suffixes[volume]})")
      vol_text <- glue("Stadt.Geschichte.Basel Band {volume} ({vol_link})")
    } else {
      vol_text <- glue("Stadt.Geschichte.Basel Band {volume}")
    }
    
    # --- Extract column info ----
    columns <- meta$tableSchema$columns
    columns_info <- data.frame(
      name = sapply(columns, function(c) c$name),
      description = sapply(columns, function(c) extract_lang(c$`dc:description`)),
      stringsAsFactors = FALSE
    )
    columns_str <- paste(apply(columns_info, 1, function(row) {
      paste0("- **", row["name"], ":** ", row["description"])
    }), collapse = "\n")
    
    # --- Compose metadata fields for table ----
    fields <- list(
      Title = title,
      Description = description,
      Creator = paste(creators, collapse = ", "),
      Contributors = paste(contributors, collapse = ", "),
      Publisher = publisher,
      Date = date,
      Coverage = coverage,
      "is Part of" = vol_text,
      Dataset = data_link,
      "Source (Dataset)" = source,
      "Metadata (Dataset)" = meta_link,
      Rights = rights,
      License = glue("[{license}]({license})"),
      Modified = modified
    )
    
    list(fields = fields, columns_str = columns_str)
  }
  
  # --- Process all metadata files ----
  metadata_list <- lapply(csv_suffixes, process_metadata)
  main_meta <- metadata_list[[1]]
  
  # --- Extract code before "# Write Info Page" marker ----
  plot_name <- deparse(substitute(plot_obj))
  base_name <- sub("^plot", "", plot_name)
  candidate_script <- here("src", plot_id, paste0(base_name, "_plot.R"))
  if (fs::file_exists(candidate_script)) {
    plot_script <- candidate_script
  } else {
    generic_script <- here("src", plot_id, paste0(plot_id, "_plot.R"))
    if (fs::file_exists(generic_script)) {
      plot_script <- generic_script
    } else {
      candidates <- dir_ls(here("src", plot_id), regexp = "_plot\\.R$", type = "file")
      if (length(candidates) == 0) stop("No plot script found in ", here("src", plot_id))
      plot_script <- candidates[1]
    }
  }
  script_lines <- readLines(plot_script, warn = FALSE)
  cutoff <- grep("^# Write Info Page", script_lines)
  first_section <- if (length(cutoff) > 0) script_lines[seq_len(cutoff - 1)] else script_lines
  
  # --- Build Quarto Chunks ----
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
  
  # --- Build data + metadata table chunks ----
  table_chunks <- c()
  for (i in seq_along(metadata_list)) {
    fields <- metadata_list[[i]]$fields
    col_description <- metadata_list[[i]]$columns_str
    current_suffix <- csv_suffixes[i]
    data_var <- glue("data{plot_id}_{current_suffix}")
    
    datatable_chunk <- c(
      glue("```{{r datatable{i}}}"),
      "#| echo: false",
      "#| message: false",
      "#| warning: false",
      "",
      "library(readr)",
      "library(DT)",
      glue("dataset_file_{i} <- here(\"data\", \"clean\", \"Band{volume}\", \"{plot_id}\", \"{plot_id}_{current_suffix}_Data.csv\")"),
      glue("{data_var} <- read_csv(dataset_file_{i})"),
      "htmltools::div(",
      "  class = 'datatable-frame',",
      "  DT::datatable(",
      glue("    {data_var},"),
      "    rownames = FALSE,",
      "    options = list(scrollX = TRUE, scrollCollapse = TRUE, scrollY = '400px', paging = FALSE, dom = 't'),",
      glue("    caption = htmltools::tags$caption(style = 'caption-side: top; text-align: left;', 'Dataset {plot_id}_{current_suffix}')"),
      "  )",
      ")",
      "```",
      "",
      "::: {#callout-col-description .callout-tip title=\"Column Descriptions\" icon=\"false\" collapse=\"true\"}",
      col_description,
      ":::"
    )
    
    metatable_chunk <- c(
      glue("```{{r metatable{i}, results=\"asis\"}}"),
      "#| echo: false",
      "#| message: false",
      "",
      "library(knitr)",
      "df <- data.frame(",
      "  Key = c(", paste0("\"", names(fields), "\"", collapse = ", "), "),",
      "  Value = c(", paste0("\"", unlist(fields), "\"", collapse = ", "), "),",
      "  stringsAsFactors = FALSE",
      ")",
      glue("knitr::kable(df, format = \"markdown\", escape = FALSE, caption = 'Selected Metadata for Dataset {plot_id}_{current_suffix}')"),
      "```"
    )
    
    table_chunks <- c(table_chunks, datatable_chunk, metatable_chunk)
    if (i < length(metadata_list)) table_chunks <- c(table_chunks, "", "---", "")
  }
  
  # --- Build full QMD text ----
  plotid_meta <- if (is.null(plot_suffix)) glue("abb{plot_id}") else glue("abb{plot_id}_{plot_suffix}")
  qmd_text <- c(
    "---",
    glue("title: \"{main_meta$fields$Title}\""),
    "subtitle: Plot and Data Preview",
    glue("date-modified: {main_meta$fields$Modified}"),
    glue("volume: \"Band {volume}\""),
    glue("plotid: \"{plotid_meta}\""),
    "format:",
    "  html:",
    "    fig-width: 8",
    "    title-block-categories: false",
    "fig-cap-location: top",
    "code-links:",
    glue("  - href: 'https://github.com/Stadt-Geschichte-Basel/sgb-figures/tree/main/src/{plot_id}'"),
    glue("    text: abb{plot_id} Source Code"),
    "    icon: github",
    "---",
    "",
    "```{r setup, include=FALSE}",
    paste(first_section, collapse = "\n"),
    "```",
    "",
    plot_chunk,
    "",
    glue("Plot {plotid_meta} was built using the following data:"),
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
  message("✅ Quarto info page generated: ", outfile)
}
