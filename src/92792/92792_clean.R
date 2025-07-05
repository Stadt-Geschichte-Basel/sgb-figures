# Packages -------------------

library(here)
library(readxl)
library(csvwr)
library(magrittr)
library(jsonlite)
library(tidyr)

# Functions ------------------

source(here("src", "Funktionen", "Metadata_JSON.R"))
source(here("src", "Funktionen", "Export_CSV.R"))

# Process Data ---------------

data92792 <- read_excel(here("data", "raw", "Band9", "92792", "92792_Data_raw.xlsx"),
                        range = "A2:B26",
                        col_names = c("Eigentümer", "Anzahl Wohnungen"))

data92792$Eigentümer[3] <- c("Pensionskasse Basel-Stadt")
data92792$Eigentümer[23] <- c("GAM Investment Management")

save_clean_csv(data92792, vol = 9)

# Create Metadata ------------

meta92792 <- annotate(data = data92792,
                      mediaID = 92792,
                      vol = 9,
                      title = "Privatbesitz an Boden und Wohnraum in Basel, 2021",
                      column_description = c("Namen der auf dem Wohnungsmarkt aktiven Akteure in Basel-Stadt (ausgewählte)", "Anzahl der vom jeweiligen Akteur besessenen Wohnungen im Kanton Basel-Stadt. Angaben der Pensionskasse Basel-Stadt nach Eigendeklaration, im Datensatz sind einige der Grundstücke im Finanzvermögen der Einwohnergemeinde."),
                      object_description = "Wem gehört Basel heute? Die Darstellung zeigt die grössten Privatplayer auf dem baselstädtischen Boden- und Wohnungsmarkt. Nach einer Recherche von reflect.ch und Bajour aus dem Jahr 2021 gehört rund ein Drittel aller Wohnungen in Basel-Stadt mittlerweile institutionellen, renditeorientierten Unternehmen. Dem Staat gehörten 2016 etwa 24 Prozent der bebau-baren Kantonsfläche (Berechnung der Initiant:innen der kantonalen ‹Neuen Bodeninitiative› von 2016).",
                      creator = list(list(name = "Tobias Ehrenbold"),
                                     list(name = "Silas Gusset"),
                                     list(name = "Anina Zahn")),
                      contributor = list(list(name = "Nico Görlich",
                                              orcid = "0000-0003-3860-1488"),
                                         list(name = "Moritz Twente",
                                              email = "moritz.twente@unibas.ch",
                                              orcid = "0009-0005-7187-9774")),
                      date = "2021",
                      coverage = "Zeitgeschichte",
                      source = "https://reflekt.ch/recherchen/wem-gehoert-basel. Bearbeitung: Nico Görlich / Moritz Twente",
                      rights = "CC BY-SA 4.0",
                      relation = list("m92792_1", "m92792_2")
)