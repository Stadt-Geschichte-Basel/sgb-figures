# Packages -------------------

library(here)
library(readxl)
library(magrittr)
library(csvwr)
library(jsonlite)

# Functions ------------------

source(here("src", "Funktionen", "Metadata_JSON.R"))
source(here("src", "Funktionen", "Export_CSV.R"))

# Process Data ---------------

data21892 <- read_excel(here("data", "raw", "Band7", "21892", "21892_Data_raw.xlsx"),
                        range = "F2:G55",
                        col_names = TRUE)

colnames(data21892)[2] = "Öffentliches Personal auf 1000 Einwohner" 

save_clean_csv(data21892, vol = 7)

# Create Metadata ------------

meta21892 <- annotate(data = data21892,
                      mediaID = 21892,
                      vol = 7,
                      title = "Öffentliches Personal des Kantons auf 1000 Einwohnerinnen und Einwohner, 1912–1963",
                      column_description = c("Jahreszahl, Angabe in Jahren unserer Zeitrechnung", "Anzahl der vom Kanton Basel-Stadt angestellten Menschen gerechnet auf 1000 Einwohner:innen und Einwohner am Ende des jeweiligen Jahres"),
                      object_description = "Die Zahl der Staatsangestellten und die Staatsausgaben wuchsen zwischen 1912 und 1966 deutlich überproportional im Verhältnis zur Einwohnerschaft.",
                      creator = list(list(name = "Noëmi Crain Merz")),
                      contributor = list(list(name = "Nico Görlich",
                                              orcid = "0000-0003-3860-1488"),
                                         list(name = "Moritz Twente",
                                              email = "moritz.twente@unibas.ch",
                                              orcid = "0009-0005-7187-9774")),
                      date = "1911/1963",
                      coverage = "Zeitgeschichte",
                      source = "Quelle: Statistisches Jahrbuch des Kantons Basel-Stadt, diverse Jahrgänge: Daten 1911-1945: Ausgabe 1945, S. 203. Daten 1946-1950: Ausgabe 1950, S. 199. Daten 1951-1955: Ausgabe 1955, S. 192. Daten 1956-1960: Ausgabe 1960, S. 182. Daten 1961-1963: Ausgabe 1963, S. 180. Bearbeitung: Nico Görlich / Moritz Twente",
                      rights = "Public Domain Mark",
                      relation = list("m21892_1", "m21892_2", "m21912_1", "m21912_2", "m21912_3")
)