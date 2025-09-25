# Packages ---------

library(here)
library(jsonlite)
library(fs)
library(glue)

# Function to Write Meta Page for Quarto ---------

write_info_page <- function(plot_obj, plot_id, volume, metadata_file, has_legend = TRUE) {
  
  # --- metadata ----
  meta <- fromJSON(metadata_file)
  schema <- meta$tables$tableSchema
  
  fig_id <- schema$isPartOf$ObjectID[[1]]
  fig_link <- glue("[{fig_id}](https://forschung.stadtgeschichtebasel.ch/items/{fig_id}.html)")
  
  rel_path <- fs::path_rel(metadata_file, start = here())
  rel_path <- gsub("^docs/", "", rel_path)
  filename <- fs::path_file(metadata_file)
  meta_link <- glue("[{filename}](/", rel_path, ")")
  
  fields <- list(
    Figure        = fig_link,
    Title         = schema$title[[1]],
    Description   = schema$description[[1]],
    Date          = schema$date[[1]],
    Coverage      = schema$coverage[[1]],
    Volume        = schema$isPartOf$volume[[1]],
    "Source (Dataset)"       = schema$source[[1]],
    "Metadata (Dataset)"      = meta_link,
    "Citation (Dataset)" = schema$bibliographicCitation[[1]]
  )
  
  # --- extract script preamble up to "# Write Info Page" ----
  plot_script <- here("src", plot_id, glue("{plot_id}_plot.R"))
  script_lines <- readLines(plot_script, warn = FALSE)
  cutoff <- grep("^# Write Info Page", script_lines)
  if (length(cutoff) == 0) {
    stop("No '# Write Info Page' marker found in ", plot_script)
  }
  preamble <- script_lines[seq_len(cutoff - 1)]
  
  # --- print plot either with or without legend ---
  plot_object <- if (isTRUE(has_legend)) {
    c(
      "```{r}",
      "#| echo: false",
      "#| message: false",
      "#| warning: false",
      glue("plot{plot_id} + theme(legend.position = \"right\")"),
      "```"
    )
  } else {
    c(
      "```{r}",
      "#| echo: false",
      "#| message: false",
      "#| warning: false",
      glue("plot{plot_id}"),
      "```"
    )
  }
  
  # --- build .qmd ----
  qmd_text <- c(
    "---",
    glue("title: \"{schema$title[[1]]}\""),
    "subtitle: Plot and Data Preview",
    "format: html",
    "---",
    "",
    "```{r setup, include=FALSE}",
    "#| echo: false",
    "#| message: false",
    "# only source the preamble of the plot script",
    paste(preamble, collapse = "\n"),
    "```",
    "",
    plot_object,
    "",
    "```{r, results=\"asis\"}",
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
