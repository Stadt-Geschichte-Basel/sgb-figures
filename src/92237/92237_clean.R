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

data92237 <- read_excel(here("data", "raw", "Band6", "92237", "92237_Data_raw.xlsx"))

save_clean_csv(data92237, vol = 6)

# Create Metadata ------------

meta92237 <- annotate(data = data92237,
                      mediaID = 92237,
                      vol = 6,
                      title = "Bevölkerungsentwicklung in den Kantonen Basel-Stadt und Glarus, 1850 und 1910",
                      column_description = c("Angabe des Jahres, für das die jeweiligen Daten gelten. Jahreszahl in unserer Zeitrechnung",
                                             "Anzahl der Einwohnerinnen und Einwohner des Kantons Basel-Stadt im angegebenen Jahr",
                                             "Anzahl der Einwohnerinnen und Einwohner des Kantons Glarus im angegebenen Jahr"),
                      object_description = "Der Vergleich zwischen Basel-Stadt und Glarus veranschaulicht den sozialen Strukturwandel innerhalb der Schweiz. Um 1850 hatten beide Kantone rund 30 000 Einwohnerinnen und Einwohner. Bis 1910 wuchs die Bevölkerung von Glarus auf etwas über 33 000 Menschen an, während sich die Bevölkerung des Kantons Basel-Stadt auf über 135 000 vervielfachte",
                      creator = list(list(name = "Benedikt Pfister")),
                      contributor = list(list(name = "Nico Görlich",
                                              orcid = "0000-0003-3860-1488"),
                                         list(name = "Moritz Twente",
                                              email = "moritz.twente@unibas.ch",
                                              orcid = "0009-0005-7187-9774")),
                      date = "[1850, 1910]",
                      coverage = list("19. Jahrhundert", "20. Jahrhundert"),
                      source = "Quelle: Bickel, Wilhelm: Bevölkerungsgeschichte und Bevölkerungspolitik der Schweiz seit dem Ausgang des Mittelalters, Zürich 1947, S. 135. Bearbeitung: Nico Görlich / Moritz Twente",
                      rights = "Public Domain Mark",
                      relation = list("m92237_1", "m92237_2")
)