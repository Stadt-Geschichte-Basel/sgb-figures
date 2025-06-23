# Packages -------------------

library(here)
library(readxl)
library(csvwr)
library(magrittr)
library(jsonlite)

# Functions ------------------

source(here("src", "Funktionen", "Metadata_JSON.R"))
source(here("src", "Funktionen", "Export_CSV.R"))

# Process Data --------

data84380 <- read_excel(here("data", "raw", "Band8", "84380", "84380_Data_raw.xlsx"),
                        range = "A5:C66")

save_clean_csv(data84380, vol = 8)

# Create Metadata -------

meta84380 <- annotate(data = data84380,
                      mediaID = 84380,
                      vol = 8,
                      title = "Eheschliessungen und Ehescheidungen in Basel-Stadt, 1960–2020",
                      column_description = c("Angabe des Jahres nach unserer Zeitrechnung",
                                             "Anzahl der Eheschliessungen im Kanton Basel-Stadt im angegebenen Jahr",
                                             "Anzahl der Ehescheidungen im Kanton Basel-Stadt im angegebenen Jahr"),
                      object_description = "Zwischen 1965 und 1975 sank die Zahl der Eheschliessungen in Basel-Stadt um die Hälfte, von über 2000 auf rund 1000 pro Jahr. Gleichzeitig erhöhte sich die Scheidungsrate, die über dem nationalen Schnitt lag: 1960 siebzehn Prozent (Schweiz: elf Prozent), 1980 38 (Schweiz 31). Mit der Abschaffung des Konkubinatsverbots 1978 war die Ehe nicht mehr Voraussetzung für ein gemeinsames Zusammenleben, zudem waren Trennungen weniger stigmatisierend als früher.",
                      creator = list(list(name = "Tobias Ehrenbold"),
                                     list(name = "Silas Gusset"),
                                     list(name = "Anina Zahn")),
                      contributor = list(list(name = "Nico Görlich",
                                              orcid = "0000-0003-3860-1488"),
                                         list(name = "Moritz Twente",
                                              email = "moritz.twente@unibas.ch",
                                              orcid = "0009-0005-7187-9774")),
                      date = "1960/2020",
                      temporal = "Zeitgeschichte",
                      source = "Quelle: Statistisches Jahrbuch des Kantons Basel-Stadt 1960–2020. Bearbeitung: Nico Görlich / Moritz Twente",
                      rights = "Public Domain Mark. Daten: Kanton Basel-Stadt. Bearbeitung: Nico Görlich / Moritz Twente",
                      relation = list("m84380_1", "m84380_2")
)