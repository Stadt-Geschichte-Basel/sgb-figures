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

data26896 <- read_excel(here("data", "raw", "Band7", "26896", "26896_Data_raw.xlsx"),
                        sheet = 1,
                        range = "A5:C40",
                        col_names = c("Jahr",
                                      "aus Deutschland",
                                      "aus Frankreich"))

save_clean_csv(data26896, vol = 7)

# Create Metadata ------------

meta26896 <- annotate(data = data26896,
                      mediaID = 26896,
                      vol = 7,
                      title = "Ausgestellte Arbeitsbewilligungen an Grenzgängerinnen und Grenzgänger im Kanton Basel-Stadt, 1927–1962",
                      column_description = c("Jahreszahl im 20. Jahrhundert nach unserer Zeitrechnung",
                                             "Anzahl der ausgestellten Arbeitsbewilligungen an Grenzgängerinnen und Grenzgänger aus Deutschland im angegebenen Jahr",
                                             "Anzahl der ausgestellten Arbeitsbewilligungen an Grenzgängerinnen und Grenzgänger aus Frankreich im angegebenen Jahr"),
                      object_description = "Die Zahl der ausgestellten Bewilligungen folgt den jeweiligen Konjunkturen: Ab 1932 nahm sie stetig ab. Während des Zweiten Weltkriegs arbeiteten nur noch einzelne Grenzgängerinnen und Grenzgänger in Basel. Auffällig ist insbesondere die starke Zunahme nach 1953.",
                      creator = list(list(name = "Isabel Koellreuter")),
                      contributor = list(list(name = "Nico Görlich",
                                              orcid = "0000-0003-3860-1488"),
                                    list(name = "Moritz Twente",
                                         email = "moritz.twente@unibas.ch",
                                         orcid = "0009-0005-7187-9774")),
                      date = "1927/1962",
                      coverage = "Zeitgeschichte",
                      source = "Quelle: Banz, Marcel: Die deutschen und französischen Grenzgänger auf dem baselstädtischen Arbeitsmarkt, Basel 1964. Bearbeitung: Nico Görlich / Moritz Twente",
                      rights = "Public Domain Mark",
                      relation = list("m26896_1", "m26896_2")
                      )