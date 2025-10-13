# Packages -------------------

library(here)
library(readxl)

# Functions ------------------

source(here("src", "Utils", "Metadata_JSON.R"))
source(here("src", "Utils", "Export_CSV.R"))

# Process Data ---------------

data76999 <- read_excel(here("data", "raw", "Band9", "76999", "76999_Data_raw.xlsx"),
  range = "A2:B26",
  col_names = c("Eigentümer", "Anzahl Wohnungen")
)

data76999$Eigentümer[3] <- c("Pensionskasse Basel-Stadt")
data76999$Eigentümer[23] <- c("GAM Investment Management")

save_clean_csv(data76999, csv_suffix = 3, vol = 9)

# Create Metadata ------------

meta76999 <- annotate(
  data = data76999,
  media_id = 76999,
  csv_suffix = 3,
  vol = 9,
  title = "Privatbesitz an Boden und Wohnraum in Basel, 2021",
  column_description = c("Namen der auf dem Wohnungsmarkt aktiven Akteure in Basel-Stadt (ausgewählte)", "Anzahl der vom jeweiligen Akteur besessenen Wohnungen im Kanton Basel-Stadt. Angaben der Pensionskasse Basel-Stadt nach Eigendeklaration, im Datensatz sind einige der Grundstücke im Finanzvermögen der Einwohnergemeinde."),
  column_datatype = c("string", "integer"),
  object_description = "Wem gehört Basel heute? Die Darstellung zeigt die grössten Privatplayer auf dem baselstädtischen Boden- und Wohnungsmarkt. Nach einer Recherche von reflect.ch und Bajour aus dem Jahr 2021 gehört rund ein Drittel aller Wohnungen in Basel-Stadt mittlerweile institutionellen, renditeorientierten Unternehmen. Dem Staat gehörten 2016 etwa 24 Prozent der bebau-baren Kantonsfläche (Berechnung der Initiant:innen der kantonalen ‹Neuen Bodeninitiative› von 2016).",
  creator = list(
    list(name = "Tobias Ehrenbold"),
    list(name = "Silas Gusset"),
    list(name = "Anina Zahn")
  ),
  contributor = list(
    list(
      name = "Nico Görlich",
      orcid = "0000-0003-3860-1488"
    ),
    list(
      name = "Moritz Twente",
      email = "mtwente@protonmail.com",
      orcid = "0009-0005-7187-9774"
    )
  ),
  date = "2021",
  coverage = "21. Jahrhundert",
  source = "https://reflekt.ch/recherchen/wem-gehoert-basel. Bearbeitung: Nico Görlich / Moritz Twente",
  rights = "CC BY-SA 4.0",
  relation = c("m76999_1", "m76999_2")
)
