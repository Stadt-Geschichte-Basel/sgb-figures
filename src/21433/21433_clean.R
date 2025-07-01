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

data21433 <- read_excel(here("data", "raw", "Band7", "21433", "21433_Data_raw.xlsx"),
                        sheet = 1,
                        range = "A1:D14")

colnames(data21433)[1] <- "Jahr"

save_clean_csv(data21433, vol = 7)

# Create Metadata ------------

meta21433 <- annotate(data = data21433,
                      mediaID = 21433,
                      vol = 7,
                      title = "Die Bevölkerung von Basel-Stadt, 1912–1966",
                      column_description = c("Jahreszahl im 20. Jahrhundert nach unserer Zeitrechnung",
                                             "Zahl der Einwohner:innen von Basel-Stadt mit Basler Bürgerrecht im entsprechenden Jahr",
                                             "Zahl der Einwohner:innen von Basel-Stadt mit Bürgerrecht eines anderen Schweizer Kantons im entsprechenden Jahr",
                                             "Zahl der Einwohner:innen von Basel-Stadt mit ausländischer Staatsbürgerschaft im entsprechenden Jahr"),
                      object_description = "Obwohl die Einwohnerschaft mit ausländischer Staatsangehörigkeit in den 1960er-Jahren deutlich zunahm – 1966 lag ihr Anteil bei 15.3 Prozent – blieb sie selbst in absoluten Zahlen unter dem Wert von 1912.",
                      creator = list(list(name = "Noëmi Crain Merz")),
                      contributor = list(list(name = "Nico Görlich",
                                              orcid = "0000-0003-3860-1488"),
                                    list(name = "Moritz Twente",
                                         email = "moritz.twente@unibas.ch",
                                         orcid = "0009-0005-7187-9774")),
                      date = "1912/1966",
                      coverage = "Zeitgeschichte",
                      source = "Quelle: Statistisches Jahrbuch des Kantons Basel-Stadt 1970, S. 21. Daten für das Jahr 1912 aus dem Statistischen Jahrbuch des Kantons Basel Stadt 1921, S. 34. Bearbeitung: Nico Görlich / Moritz Twente",
                      rights = "Public Domain Mark",
                      relation = list("m21433_1", "m21433_2")
                      )