# Packages -------------------

library(here)
library(readxl)
library(csvwr)
library(magrittr)
library(jsonlite)
library(tidyr)
library(dplyr)

# Functions ------------------

source(here("src", "Funktionen", "Metadata_JSON.R"))
source(here("src", "Funktionen", "Export_CSV.R"))

# Process Data ---------------

data92209 <- read_excel(here("data", "raw", "Band6", "92209", "92209_Data_raw.xlsx"))

save_clean_csv(data92209, vol = 6)

# Create Metadata ------------

meta92209 <- annotate(data = data92209,
                      mediaID = 92209,
                      vol = 6,
                      title = "Bevölkerungsentwicklung des Kantons Basel-Stadt, 1870–1910",
                      column_description = c("Angabe des Jahres nach unserer Zeitrechnung, für das die entsprechenden Zahlen gelten.",
                                             "Zahl der Einwohner:innen von Basel-Stadt mit Basler Bürgerrecht im entsprechenden Jahr",
                                             "Zahl der Einwohner:innen von Basel-Stadt mit Bürgerrecht eines anderen Schweizer Kantons im entsprechenden Jahr",
                                             "Zahl der Einwohner:innen von Basel-Stadt mit ausländischer Staatsbürgerschaft im entsprechenden Jahr",
                                             "Gesamtsumme der Zahl der Einwohner:innen von Basel-Stadt im entsprechenden Jahr"),
                      object_description = "Dank der liberalen Einbürgerungspraxis stieg der Anteil der Menschen mit Basler Bürgerrecht von 1900 bis 1910 von rund 17 000 auf 45 000 Personen an. Der Anteil von Einwohner:innen mit ausländischer Staatsbürgerschaft lag um 1910 bei rund 38 Prozent",
                      creator = list(list(name = "Benedikt Pfister")),
                      contributor = list(list(name = "Nico Görlich",
                                              orcid = "0000-0003-3860-1488"),
                                         list(name = "Moritz Twente",
                                              email = "moritz.twente@unibas.ch",
                                              orcid = "0009-0005-7187-9774")),
                      date = "1870/1910",
                      temporal = list("19 Jahrhundert", "20. Jahrhundert"),
                      source = "Quelle: Mitteilungen des Statistischen Amtes Basel-Stadt, Nr. 28, Basel 1924. Bearbeitung: Nico Görlich / Moritz Twente",
                      rights = "Public Domain Mark",
                      relation = list("m92209_1", "m92209_2")
)