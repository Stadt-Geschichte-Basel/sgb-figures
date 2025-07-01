# Packages -------------------

library(here)
library(readxl)
library(csvwr)
library(jsonlite)
library(magrittr)

# Functions ------------------

source(here("src", "Funktionen", "Metadata_JSON.R"))
source(here("src", "Funktionen", "Export_CSV.R"))

# Process Data ---------------

data11589 <- read_excel(here("data", "raw", "Band7", "11589", "11589_Data_raw.xlsx"),
                        sheet = 1,
                        range = "A2:D57")

# Umrechnung von 'pro 1000 EW' auf 'pro 100 EW'
data11589$Personenwagen <- data11589$Personenwagen / 10
data11589$Motorräder <- data11589$Motorräder / 10
data11589$Fahrräder <- data11589$Fahrräder / 10

save_clean_csv(data11589, vol = 7)

# Create Metadata ------------

meta11589 <- annotate(data = data11589,
                      mediaID = 11589,
                      vol = 7,
                      title = "Anzahl Verkehrsträger pro 100 Einwohner und Einwohnerinnen im Kanton Basel-Stadt, 1916–1970",
                      column_description = c("Jahreszahl im 20. Jahrhundert nach unserer Zeitrechnung",
                                             "Anzahl der Personenwagen pro 100 Einwohner*innen im Kanton Basel-Stadt im angegebenen Jahr",
                                             "Anzahl der Motorräder pro 100 Einwohner*innen im Kanton Basel-Stadt im angegebenen Jahr",
                                             "Anzahl der Fahrräder pro 100 Einwohner*innen im Kanton Basel-Stadt im angegebenen Jahr"),
                      object_description = "Die Mobilität der Basler und Baslerinnen nahm zu. Die Zahl der Fahrräder überstieg lange alle anderen individuellen Verkehrsmittel. Nach dem Zweiten Weltkrieg schnellte die Zahl der motorisierten Gefährte in die Höhe.",
                      creator = list(list(name = "Céline Angehrn")),
                      contributor = list(list(name = "Nico Görlich",
                                              orcid = "0000-0003-3860-1488"),
                                    list(name = "Moritz Twente",
                                         email = "moritz.twente@unibas.ch",
                                         orcid = "0009-0005-7187-9774")),
                      date = "1916/1970",
                      coverage = "Zeitgeschichte",
                      source = "Quelle: Statistisches Jahrbuch des Kantons Basel-Stadt, diverse Jahrgänge. Bearbeitung: Nico Görlich / Moritz Twente",
                      rights = "Public Domain Mark",
                      relation = list("m11589_1", "m11589_2")
                      )