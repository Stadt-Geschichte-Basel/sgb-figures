# Packages -------------------

library(here)
library(readxl)
library(csvwr)
library(magrittr)
library(jsonlite)

# Functions ------------------

source(here("src", "Funktionen", "Metadata_JSON.R"))
source(here("src", "Funktionen", "Export_CSV.R"))

# Read Data ------------------

data91203 <- read_excel(here("data", "raw", "Band6", "91203", "91203_Data_raw.xlsx"))

# Process Data --------

data91203_Stimmberechtigte <- data91203[, c("Stimmberechtigte", "...4")]

data91203_Stimmberechtigte$...4[4] <- 1900
data91203_Stimmberechtigte$...4[5] <- 1910

data91203 <- data91203[,-3:-4]
colnames(data91203)[2] <- "Gesamtbevölkerung"

data91203 <- merge(data91203, data91203_Stimmberechtigte, by.x = "Jahr", by.y = "...4", all = TRUE)

save_clean_csv(data91203, vol = 6)

# Create Metadata -------

meta91203 <- annotate(data = data91203,
                      mediaID = 91203,
                      vol = 6,
                      title = "Stimmberechtigte und Gesamtbevölkerung, 1870–1910",
                      column_description = c("Angabe des Jahres nach unserer Zeitrechnung, für das die entsprechenden Zahlen gelten",
                                             "Angabe der Gesamtbevölkerung des Kantons Basel-Stadt im entsprechenden Jahr",
                                             "Angabe der Zahl der stimmberechtigten Einwohner des Kantons Basel-Stadt im entsprechenden Jahr"
                                             ),
                      object_description = "Auch wenn das Stimm- und Wahlrecht nach 1875 erweitert wurde, repräsentierten die Stimmberechtigten nur einen Bruchteil der Gesamtbevölkerung. Die Zahlen zur Bevölkerung stammen aus den ‹Mitteilungen des Statistischen Amtes Basel-Stadt›, Nr. 28, Basel 1924, jene zur Anzahl Stimmberechtigter aus dem ‹Kantons-Blatt Basel-Stadt›.",
                      creator = list(list(name = "Eva Gschwind"),
                                     list(name = "Benedikt Pfister")),
                      contributor = list(list(name = "Nico Görlich",
                                              orcid = "0000-0003-3860-1488"),
                                         list(name = "Moritz Twente",
                                              email = "moritz.twente@unibas.ch",
                                              orcid = "0009-0005-7187-9774")),
                      date = "1870/1910",
                      temporal = list("19 Jahrhundert", "20. Jahrhundert"),
                      source = "Quelle: Mitteilungen des Statistischen Amtes Basel-Stadt, Nr. 28, Basel 1924; Kantons-Blatt Basel-Stadt. Bearbeitung: Nico Görlich / Moritz Twente",
                      rights = "Public Domain Mark",
                      relation = list("m91203_1", "m91203_2")
)
