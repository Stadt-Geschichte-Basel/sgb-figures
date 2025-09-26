# Packages ---------

library(here)
library(jsonlite)
library(fs)
library(glue)
library(stringr)

# Function to Write Meta Page for Quarto ---------

write_info_page <- function(plot_obj, plot_id, volume, csv_suffix, has_legend = TRUE) {
  
  # --- Construct Metadata File Path ----
  metadata_file <- here(
    "data", "clean",
    glue("Band{volume}"),
    glue("{plot_id}"),
    glue("{plot_id}_{csv_suffix}_Data.csv-metadata.json")
  )
  
  # --- Extract Metadata from File ----
  meta <- fromJSON(metadata_file)
  schema <- meta$tables$tableSchema
  
  fig_id <- schema$isPartOf$ObjectID[[1]]
  fig_link <- glue("[{fig_id}](https://forschung.stadtgeschichtebasel.ch/items/{fig_id}.html)")
  
  publisher <- schema$publisher[[1]]
  publisher_link <- glue("[{publisher}](https://www.wikidata.org/wiki/Q122442230)")
  
  ## --- Construct Path to Metadata JSON file ---
  rel_path <- fs::path_rel(metadata_file, start = here())
  rel_path <- gsub("^docs/", "", rel_path)
  meta_link <- glue("[{rel_path}](/", rel_path, ")")
  
  ## --- Map Volume Numbers with Open Access DOIs ---
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
    Publisher     = publisher_link,
    Date          = schema$date[[1]],
    Coverage      = schema$coverage[[1]],
    "is Part of"  = vol_text,
    "Source (Dataset)"       = schema$source[[1]],
    "Metadata (Dataset)"     = meta_link,
    "Citation (Dataset)"     = schema$bibliographicCitation[[1]],
    Modified      = schema$modified[[1]]
  )
  
  # --- extract script for the actual plot just up to "# Write Info Page" section ----
  plot_script <- here("src", plot_id, glue("{plot_id}_plot.R"))
  script_lines <- readLines(plot_script, warn = FALSE)
  cutoff <- grep("^# Write Info Page", script_lines)
  if (length(cutoff) == 0) {
    stop("No '# Write Info Page' marker found in ", plot_script)
  }
  first_section <- script_lines[seq_len(cutoff - 1)]
  
  # --- create plot either with or without legend ---
  plot_object <- if (isTRUE(has_legend)) {
    c(
      "```{r plot_object}",
      "#| echo: false",
      "#| message: false",
      "#| warning: false",
      "#| column: page-right",
      "#| fig-cap: \"Preview only. Refer to the Research Data Platform for full metadata and production-ready files.\"",
      glue("plot{plot_id} + theme(legend.position = \"right\")"),
      "```"
    )
  } else {
    c(
      "```{r plot_object}",
      "#| echo: false",
      "#| message: false",
      "#| warning: false",
      "#| fig-cap: \"Preview only. Refer to the Research Data Platform for full metadata and production-ready files.\"",
      glue("plot{plot_id}"),
      "```"
    )
  }
  
  # --- build .qmd ----
  qmd_text <- c(
    "---",
    glue("title: \"{schema$title[[1]]}\""),
    "subtitle: Plot and Data Preview",
    glue("date-modified: {as.Date(schema$modified[[1]])}"),
    glue("volume: \"{schema$isPartOf$volume[[1]]}\""),
    glue("vol_short: \"{vol_short}\""),
    glue("plotid: \"abb{plot_id}\""),
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
    plot_object,
    "",
    "```{r table, results=\"asis\"}",
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
    "knitr::kable(df, format = \"markdown\", caption = \"Dataset Overview\")",
    "```"
  )
  
  outdir <- here("docs", "plots")
  dir_create(outdir)
  
  outfile <- path(outdir, glue("{plot_id}.qmd"))
  writeLines(qmd_text, outfile)
}
