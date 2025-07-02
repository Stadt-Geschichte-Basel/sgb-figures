annotate <- function(data, mediaID, vol, title, column_description, object_description, creator,
                            contributor, date, coverage, source, relation, rights) {
  
  # derive folder ID from mediaID
  folderID <- sub("^(\\d{5}).*$", "\\1", mediaID)
  
  # derive license URL based on rights string
  license_url <- if (grepl("CC BY-SA", rights, ignore.case = TRUE)) {
    "https://creativecommons.org/licenses/by-sa/4.0/"
  } else if (grepl("Public Domain Mark", rights, ignore.case = TRUE)) {
    "https://creativecommons.org/public-domain/pdm/"
    "https://creativecommons.org/licenses/by-sa/4.0/"
  } else if (grepl("CC BY", rights, ignore.case = TRUE)) {
  } else if (grepl("In Copyright", rights, ignore.case = TRUE)) {
    "https://rightsstatements.org/vocab/InC-RUU/1.0/"
  } else {
    NA  # fallback if no match
  }
  
  # derive basic schema using csvwr::derive_table_schema()
  metadata <- derive_table_schema(data)
  
  # add Stadt.Geschichte.Basel Data Model
  metadata$mediaID <- paste0("m", mediaID, "_3")
  metadata$isPartOf <- list(
    ObjectID = paste0("abb", folderID),
    volume = switch(vol,
                    "Lassau, Guido; Schwarz, Peter-Andrew (Hg.): Auf dem langen Weg zur Stadt. 50 000 v. Chr.–800 n. Chr. Basel 2024 (Stadt.Geschichte.Basel 1).",
                    "Sieber-Lehmann, Claudius; Schwarz, Peter-Andrew (Hg.): Eine Bischofsstadt zwischen Oberrhein und Jura. 800–1273. Basel 2024 (Stadt.Geschichte.Basel 2).",
                    "Burkart, Lucas (Hg.): Stadt in Verhandlung. 1250–1530. Basel 2024 (Stadt.Geschichte.Basel 3).",
                    "Burghartz, Susanna (Hg.): Aufbrüche, Krisen, Transformationen. 1510–1790. Basel 2024 (Stadt.Geschichte.Basel 4).",
                    "Fehlmann, Marc; Sieber, Dominik; Salvisberg, André (Hg.): Hinter der Mauer, vor der Moderne. 1760–1859. Basel 2024 (Stadt.Geschichte.Basel 5).",
                    "Kury, Patrick (Hg.): Die beschleunigte Stadt. 1856–1914. Basel 2024 (Stadt.Geschichte.Basel 6).",
                    "Arni, Caroline (Hg.): Stadt an der Grenze in einer Zeit der Gefährdung. 1912–1966. Basel 2024 (Stadt.Geschichte.Basel 7).",
                    "Lengwiler, Martin (Hg.): Auf dem Weg ins Jetzt. Seit 1960. Basel 2025 (Stadt.Geschichte.Basel 8).",
                    "Baur, Esther; Gafner, Lina (Hg.): Stadträume. Offen und begrenzt, gestaltet und umkämpft. Basel 2025 (Stadt.Geschichte.Basel 9).")
    )
  metadata$columns[["description"]] <- column_description
  metadata$title <- title
  metadata$description <- object_description
  metadata$creator <- creator
  metadata$contributor <- contributor
  metadata$publisher <- "Stadt.Geschichte.Basel"
  metadata$date <- date
  metadata$coverage <- coverage
  metadata$type <- "Dataset"
  metadata$format <- "text/csv"
  metadata$source <- source
  metadata$language <- "de"
  metadata$relation <- relation
  metadata$rights <- rights
  metadata$license <- license_url
  metadata$modified <- Sys.time()
  metadata$bibliographicCitation <- paste0(
    "Stadt.Geschichte.Basel: ", title, ". Forschungsdatenplattform Stadt.Geschichte.Basel, <https://forschung.stadtgeschichtebasel.ch/items/abb", folderID, ".html#m" , mediaID, "_3>, letzte Aktualisierung: ", format(Sys.Date(), format = "%d.%m.%Y"), "."
    )
  
  # Build folder path
  json_folder <- here("data", "clean", paste0("Band", vol), folderID)
  
  # Create folder if needed
  if (!dir.exists(json_folder)) {
    dir.create(json_folder, recursive = TRUE)
  }
  
  # File name uses full mediaID
  json_file <- file.path(json_folder, paste0(mediaID, "_Data.csv-metadata.json"))
  

  # write JSON
  list(url = paste0(mediaID, "_Data.csv"),
       tableSchema = metadata) %>%
    create_metadata() %>%
    toJSON() %>%
    prettify() %>%
    write(json_file)
  
  return(metadata)
}