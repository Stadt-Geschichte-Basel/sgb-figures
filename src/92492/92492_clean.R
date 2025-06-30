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

data92492 <- read_excel(here("data", "raw", "Band6", "92492", "92492_Data_raw.xlsx"))

colnames(data92492)[6] <- "Andere/Keine/Unbekannt"

save_clean_csv(data92492, vol = 6)

# Create Metadata ------------

meta92492 <- annotate(data = data92492,
                      mediaID = 92492,
                      vol = 6,
                      title = "Anteil der Konfessionen und Religionen an der Bevölkerung, 1860–1910",
                      column_description = c("Angabe des Jahres, für das die jeweiligen Daten gelten. Jahreszahl in unserer Zeitrechnung",
                                             "Anteil der Protestantinnen und Protestanten an der Gesamtbevölkerung in Prozent",
                                             "Anteil der Katholikinnen und Katholiken an der Gesamtbevölkerung in Prozent",
                                             "Anteil der Christkatholikinnen und Christkatholiken an der Gesamtbevölkerung in Prozent",
                                             "Anteil der Jüdinnen und Juden an der Gesamtbevölkerung in Prozent",
                                             "Anteil Angehöriger anderer, keiner oder unbekannter Religionen bzw. Konfessionen an der Gesamtbevölkerung in Prozent"),
                      object_description = "Der Anteil der Protestantinnen und Protestanten an der Bevölkerung verringerte sich von 75 Prozent 1860 auf 63,4 Prozent 1910. Im gleichen Zeitraum stieg der Anteil der Katholikinnen und Katholiken von einem Viertel auf einen Drittel und die jüdische Bevölkerung vergrösserte sich beinahe um den Faktor fünf",
                      creator = list(list(name = "Benedikt Pfister")),
                      contributor = list(list(name = "Nico Görlich",
                                              orcid = "0000-0003-3860-1488"),
                                         list(name = "Moritz Twente",
                                              email = "moritz.twente@unibas.ch",
                                              orcid = "0009-0005-7187-9774")),
                      date = "1860/1910",
                      temporal = list("19. Jahrhundert", "20. Jahrhundert"),
                      source = "Quelle: Mitteilungen des Statistischen Amtes Basel-Stadt, Nr. 28, Basel 1924. Bearbeitung: Nico Görlich / Moritz Twente",
                      rights = "Public Domain Mark",
                      relation = list("m92492_1", "m92492_2")
)