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

data88300b <- read_excel(here("data", "raw", "Band8", "88300", "88300_Data_raw.xlsx"),
                        sheet = 1,
                        range = "A8:B48",
                        col_names = c("Empfänger", "Ausgaben in CHF (2021)"))

data88300b <- data88300b[complete.cases(data88300b), ]

save_clean_csv(data88300b, vol = 8)

# Create Metadata ------------

meta88300b <- annotate(data = data88300b,
                      mediaID = "88300b",
                      vol = 8,
                      title = "Kulturausgaben in Basel-Stadt, 2021",
                      column_description = c("Gruppe der Institutionen, an die im Kanton Basel-Stadt Kulturförderung verteilt wurde",
                                             "Summe der Förderung in Schweizer Franken im Jahr 2021. Zahlen ohne Beträge aus dem Swisslos-Fonds Basel-Stadt"),
                      object_description = "Basels Selbstverständnis als Kulturstadt wird in der Betrachtung der Kultursubventionen deutlich. 2021 betrugen diese in Basel-Stadt 408 Franken pro Kopf. Die öffentliche Hand subventionierte verschiedene Kultureinrichtungen; mit Abstand am meisten Gelder erhielten in Basel das Theater, das Sinfonieorchester und die fünf staatlichen Museen.",
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
                      source = "Quelle: Jahresbericht Abteilung Kultur 2021. Bearbeitung: Nico Görlich / Moritz Twente",
                      rights = "Public Domain Mark",
                      relation = list("m88300_1", "m88300_2")
)