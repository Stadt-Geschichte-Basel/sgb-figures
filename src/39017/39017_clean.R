# Packages -------------------

library(here)
library(readxl)
library(magrittr)
library(csvwr)
library(jsonlite)

# Functions ------------------

source(here("src", "Funktionen", "Metadata_JSON.R"))
source(here("src", "Funktionen", "Export_CSV.R"))

# Process Data --------

data39017 <- read_excel(here("data", "raw", "Band3", "39017", "39017_Data_raw.xlsx"),
                        col_names = TRUE)

colnames(data39017) = c("Jahr", "Summe Ablösungen", "Summe Neueinträge", "Investierte Summe netto")

save_clean_csv(data39017, vol = 3)

# Create Metadata -------

meta39017 <- annotate(data = data39017,
                      mediaID = 39017,
                      vol = 3,
                      title = "Rentengeschäft von Ludwig Kilchmann",
                      column_description = c("Jahreszahl, Angabe in Jahren unserer Zeitrechnung", "Summe der Ablösungen im jeweiligen Jahr in Gulden", "Summe der Neueinträge im jeweiligen Jahr in Gulden", "Investierte Summe (netto) im jeweiligen Jahr in Gulden"),
                      object_description = "Die Grafik zeigt die Gesamtsumme (in Gulden) des in Renten angelegten Vermögens von Ludwig Kilchmann, dazu die Summen der jährlich erfolgten Ablösungen und Neukäufe. Dank regelmässiger Zinszahlungen fuhr Kilchmann gut mit seiner Anlagestrategie, er konnte in den Jahren des Wachstums die investierte Summe um über vier Prozent pro Jahr steigern (erstellt auf der Basis von Signori 2014; Umrechnung nach Harms 1907).",
                      creator = list(name = "Benjamin Hitz"),
                      contributor = list(list(name = "Nico Görlich",
                                              orcid = "0000-0003-3860-1488"),
                                         list(name = "Moritz Twente",
                                              email = "moritz.twente@unibas.ch",
                                              orcid = "0009-0005-7187-9774")),
                      date = "1484/1521",
                      temporal = "Neuzeit",
                      source = "Signori, Gabriela: Das Schuldbuch des Basler Kaufmanns Ludwig Kilchmann (gest. 1518), Stuttgart 2014. Bearbeitung: Nico Görlich / Moritz Twente",
                      rights = "CC BY-SA 4.0, Daten Gabriela Signori. Bearbeitung: Moritz Twente / Nico Görlich",
                      relation = list("m39017_1", "m39017_2")
)