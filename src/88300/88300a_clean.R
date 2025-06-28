# Packages -------------------

library(here)
library(readxl)
library(csvwr)
library(magrittr)
library(jsonlite)

# Functions ------------------

source(here("src", "Funktionen", "Metadata_JSON.R"))
source(here("src", "Funktionen", "Export_CSV.R"))

# Process Data ---------------

## originally, plot88300a was a separate plot. Therefore, the raw data file has a diverging name.
## To refer to this plot, only the ID 88300 or 88300a should be used.

data88300a <- read_excel(here("data", "raw", "Band8", "88300", "91294_Data_raw.xlsx"),
                        sheet = 1,
                        range = "A5:B7",
                        col_names = c("Kanton", "Kultursubventionen pro Kopf in Franken (2021)"))

save_clean_csv(data88300a, vol = 8)

# Create Metadata ------------

meta88300a <- annotate(data = data88300a,
                      mediaID = "88300a",
                      vol = 8,
                      title = "Kulturausgaben in Basel-Stadt, 2021",
                      column_description = c("Name des Kantons, für den Angaben zur Kulturförderung gemacht werden",
                                             "Summe der Kulturförderung in Schweizer Franken im Jahr 2021"),
                      object_description = "Basels Selbstverständnis als Kulturstadt wird im kantonalen Vergleich der Kultursubventionen deutlich. 2021 betrugen diese in Basel-Stadt 408 Franken pro Kopf, im zweitplatzierten Kanton Genf waren es 117 Franken, im Kanton Zürich 81 Franken.",
                      creator = list(list(name = "Tobias Ehrenbold"),
                                     list(name = "Silas Gusset"),
                                     list(name = "Anina Zahn")),
                      contributor = list(list(name = "Nico Görlich",
                                              orcid = "0000-0003-3860-1488"),
                                         list(name = "Moritz Twente",
                                              email = "moritz.twente@unibas.ch",
                                              orcid = "0009-0005-7187-9774")),
                      date = "2014",
                      temporal = "Zeitgeschichte",
                      source = "Quelle: Bundesamt für Statistik, gd-d-16.02.05.01-2024. Bearbeitung: Nico Görlich / Moritz Twente",
                      rights = "Public Domain Mark",
                      relation = list("m88300_1", "m88300_2")
)