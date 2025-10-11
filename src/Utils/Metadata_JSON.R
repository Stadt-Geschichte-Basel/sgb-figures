library(jsonlite)
library(here)
library(lubridate)

annotate <- function(data, media_id, csv_suffix, vol, title, column_description,
                     object_description, creator, contributor, date, coverage,
                     source, relation, rights, lang = "de") {
  
  # Derive folder ID ----
  folder_id <- sub("^(\\d{5}).*$", "\\1", media_id)
  suffix_part <- if (!is.null(csv_suffix)) paste0("_", csv_suffix) else ""
  
  # Prepare output paths ----
  csv_filename <- paste0(folder_id, suffix_part, "_Data.csv")
  json_folder <- here("data", "clean", paste0("Band", vol), folder_id)
  if (!dir.exists(json_folder)) dir.create(json_folder, recursive = TRUE)
  json_file <- file.path(json_folder, paste0(csv_filename, "-metadata.json"))
  
  # Build Identifier ----
  identifier <- paste0("m", media_id, "_", csv_suffix)
  
  # Set abb and vol for isPartOf ----
  isPartOf <- list(
    object_id = paste0("abb", folder_id),
    volume = switch(vol,
                    "Lassau, Guido; Schwarz, Peter-Andrew (Hg.): Auf dem langen Weg zur Stadt. 50 000 v. Chr.–800 n. Chr. Basel 2024 (Stadt.Geschichte.Basel 1).",
                    "Sieber-Lehmann, Claudius; Schwarz, Peter-Andrew (Hg.): Eine Bischofsstadt zwischen Oberrhein und Jura. 800–1273. Basel 2024 (Stadt.Geschichte.Basel 2).",
                    "Burkart, Lucas (Hg.): Stadt in Verhandlung. 1250–1530. Basel 2024 (Stadt.Geschichte.Basel 3).",
                    "Burghartz, Susanna (Hg.): Aufbrüche, Krisen, Transformationen. 1510–1790. Basel 2024 (Stadt.Geschichte.Basel 4).",
                    "Fehlmann, Marc; Sieber, Dominik; Salvisberg, André (Hg.): Hinter der Mauer, vor der Moderne. 1760–1859. Basel 2024 (Stadt.Geschichte.Basel 5).",
                    "Kury, Patrick (Hg.): Die beschleunigte Stadt. 1856–1914. Basel 2024 (Stadt.Geschichte.Basel 6).",
                    "Arni, Caroline (Hg.): Stadt an der Grenze in einer Zeit der Gefährdung. 1912–1966. Basel 2024 (Stadt.Geschichte.Basel 7).",
                    "Lengwiler, Martin (Hg.): Auf dem Weg ins Jetzt. Seit 1960. Basel 2025 (Stadt.Geschichte.Basel 8).",
                    "Baur, Esther; Gafner, Lina (Hg.): Stadträume. Offen und begrenzt, gestaltet und umkämpft. Basel 2025 (Stadt.Geschichte.Basel 9)."
                    )
    )
  
  # Build publisher info ----
  publisher <- list(
    `schema:name` = "Stadt.Geschichte.Basel",
    `schema:url` = list(`@id` = "https://www.wikidata.org/wiki/Q122442230")
  )
  
  # Normalize creator and contributor ----
  normalize_person <- function(person) {
    out <- list(`schema:name` = person$name)
    if (!is.null(person$orcid))
      out$`schema:identifier` <- list(`@id` = paste0("https://orcid.org/", person$orcid))
    if (!is.null(person$email))
      out$`schema:email` <- person$email
    out
  }
  
  # Normalize creators and contributors
  creators_list <- lapply(creator, normalize_person)
  contributors_list <- lapply(contributor, normalize_person)
  
  # If only one person, unbox to object instead of array
  creators <- if (length(creators_list) == 1) creators_list[[1]] else creators_list
  contributors <- if (length(contributors_list) == 1) contributors_list[[1]] else contributors_list
  
  # Determine license URL ----
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
  
  # Compose full metadata structure ----
  metadata <- list(
    `@context` = list("http://www.w3.org/ns/csvw", list(`@language` = lang)),
    url = csv_filename,
    `dc:identifier` = identifier,
    `dc:title` = title,
    `dc:isPartOf` = isPartOf,
    #`dc:subject` = subjects, # not yet implemented
    `dc:description` = setNames(list(object_description), lang),
    `dc:creator` = creators,
    `dc:publisher` = publisher,
    `dc:contributor` = contributors,
    `dc:date` = date,
    `dc:coverage` = coverage,
    `dc:type` = "Dataset",
    `dc:format` = "text/csv",
    `dc:source` = source,
    `dc:language` = lang,
    `dc:relation` = relation,
    `dc:rights` = rights,
    `dc:license` = list(`@id` = license_url),
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