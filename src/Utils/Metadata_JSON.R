library(jsonlite)
library(here)
library(lubridate)

annotate2 <- function(data, media_id, csv_suffix, vol, title, column_description,
                     object_description, creator, contributor, date, coverage,
                     source, relation, rights, lang = "de") {
  # Derive folder ID
  folder_id <- sub("^(\\d{5}).*$", "\\1", media_id)
  suffix_part <- if (!is.null(csv_suffix)) paste0("_", csv_suffix) else ""
  
  # Determine license URL
  license_url <- if (grepl("CC BY-SA", rights, ignore.case = TRUE)) {
    "https://creativecommons.org/licenses/by-sa/4.0/"
  } else if (grepl("Public Domain Mark", rights, ignore.case = TRUE)) {
    "https://creativecommons.org/public-domain/pdm/"
  } else if (grepl("CC BY", rights, ignore.case = TRUE)) {
    "https://creativecommons.org/licenses/by/4.0/"
  } else if (grepl("In Copyright", rights, ignore.case = TRUE)) {
    "https://rightsstatements.org/vocab/InC-RUU/1.0/"
  } else {
    NA
  }
  
  # Prepare output paths
  csv_filename <- paste0(folder_id, suffix_part, "_Data.csv")
  json_folder <- here("data", "clean", paste0("Band", vol), folder_id)
  if (!dir.exists(json_folder)) dir.create(json_folder, recursive = TRUE)
  json_file <- file.path(json_folder, paste0(csv_filename, "-metadata.json"))
  
  # Helper: infer datatype with optional format
  infer_datatype <- function(x) {
    if (is.numeric(x)) {
      return("number")
    } else if (is.logical(x)) {
      return("boolean")
    } else if (inherits(x, "Date")) {
      return(list(base = "date", format = "yyyy-MM-dd"))
    } else if (inherits(x, "POSIXt")) {
      return(list(base = "dateTime", format = "yyyy-MM-dd'T'HH:mm:ss"))
    } else if (is.character(x) || is.factor(x)) {
      # Try detect date-like strings
      sample_vals <- na.omit(as.character(x))[1:min(10, length(na.omit(x)))]
      if (all(!is.na(ymd(sample_vals, quiet = TRUE)))) {
        return(list(base = "date", format = "yyyy-MM-dd"))
      } else if (all(!is.na(mdy(sample_vals, quiet = TRUE)))) {
        return(list(base = "date", format = "M/d/yyyy"))
      } else if (all(!is.na(dmy(sample_vals, quiet = TRUE)))) {
        return(list(base = "date", format = "d/M/yyyy"))
      } else {
        return("string")
      }
    } else {
      return("string")
    }
  }
  
  # Build tableSchema ----
  columns <- lapply(seq_along(colnames(data)), function(i) {
    col_name <- colnames(data)[i]
    list(
      name = col_name,
      titles = col_name,
      `dc:description` = column_description[[i]],
      datatype = infer_datatype(data[[i]])
    )
  })
  
  # Build publisher info ----
  publisher <- list(
    `schema:name` = "Stadt.Geschichte.Basel",
    `schema:url` = list(`@id` = "https://forschung.stadtgeschichtebasel.ch")
  )
  
  # Normalize person objects ----
  normalize_person <- function(person) {
    out <- list(`schema:name` = person$name)
    if (!is.null(person$orcid))
      out$`schema:identifier` <- list(`@id` = paste0("https://orcid.org/", person$orcid))
    if (!is.null(person$email))
      out$`schema:email` <- person$email
    out
  }
  creators <- lapply(creator, normalize_person)
  contributors <- lapply(contributor, normalize_person)
  
  # Compose full metadata structure ----
  metadata <- list(
    `@context` = list("http://www.w3.org/ns/csvw", list(`@language` = lang)),
    url = csv_filename,
    `dc:title` = setNames(list(title), lang),
    `dc:description` = setNames(list(object_description), lang),
    `dc:publisher` = publisher,
    `dcat:keyword` = c("Basel", "Stadtgeschichte", "Forschungsdaten"),
    `dc:creator` = creators,
    `dc:contributor` = contributors,
    `dc:license` = list(`@id` = license_url),
    `dc:coverage` = setNames(list(coverage), lang),
    `dc:date` = date,
    `dc:source` = setNames(list(source), lang),
    `dc:rights` = rights,
    `dc:relation` = relation,
    `dc:modified` = list(`@value` = format(Sys.time(), "%Y-%m-%dT%H:%M:%S%z"), `@type` = "xsd:date"),
    tableSchema = list(
      columns = columns,
      primaryKey = colnames(data)[1],
      aboutUrl = paste0("#", tolower(colnames(data)[1]), "-{", colnames(data)[1], "}")
    )
  )
  
  # Write JSON ----
  toJSON(metadata, auto_unbox = TRUE) |>
    prettify() |>
    write(json_file)
  
  invisible(metadata)
}
