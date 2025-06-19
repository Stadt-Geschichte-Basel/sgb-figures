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

data77089 <- read_excel(here("data", "raw", "Band8", "77089", "77089_Data_raw.xlsx"),
                        sheet = 1,
                        range = "A3:D106")

colnames(data77089)[3] <- "Motorräder inkl. Mofas"

save_clean_csv(data77089, vol = 8)

# Create Metadata -------

meta77089 <- annotate(data = data77089,
                      mediaID = 77089,
                      vol = 8,
                      title = "Der Fahrzeugbestand in Basel-Stadt, 1920–2020",
                      column_description = c("Jahreszahl im 20. Jahrhundert nach unserer Zeitrechnung", "Anzahl der Personenwagen (Automobile) im Fahrzeugbestand im Kanton Basel-Stadt im entsprechenden Jahr. Ab dem Jahr 2019 werden in dieser Kategorie auch E-Autos mitgezählt", "Anzahl an Motorrädern (inklusive Mofas) im Fahrzeugbestand im Kanton Basel-Stadt im entsprechenden Jahr", "Anzahl an Fahrrädern im Fahrzeugbestand im Kanton Basel-Stadt im entsprechenden Jahr"),
                      object_description = "Die Motorisierung der Gesellschaft machte sich in den 1960er-Jahren eindrücklich bemerkbar: Der Bestand an Autos nahm in Basel massiv zu, während immer weniger Fahrräder im Einsatz waren. Mitte der 1970er-Jahre wuchs der Bestand an Fahrrädern wieder, ab 1990 wurde er nicht mehr erhoben. Anhaltende Popularität hatte das Auto: Der vermeintliche Einbruch um 1980 geht auf eine neue Zählweise zurück. Hinweis: Die Zahlen entsprechen dem Bestand der Motorfahrzeugkontrolle des Kantons Basel-Stadt. Daten aus dem Statistischen Jahrbuch der Schweiz unterscheiden sich jeweils leicht von den Daten im StAJB BS (vermutlich weil jeweils Bestand 'Ende September 19xx)'",
                      creator = list(list(name = "Tobias Ehrenbold"),
                                     list(name = "Silas Gusset"),
                                     list(name = "Anina Zahn")),
                      contributor = list(list(name = "Nico Görlich",
                                          orcid = "0000-0003-3860-1488"),
                                     list(name = "Moritz Twente",
                                          email = "moritz.twente@unibas.ch",
                                          orcid = "0009-0005-7187-9774")),
                      date = "1920/2022",
                      temporal = "Zeitgeschichte",
                      source = "https://statistik.bs.ch/apps/jahrbuch; https://statistik.bs.ch/files/webtabellen/t11-1-01.xlsx. Bearbeitung: Nico Görlich / Moritz Twente",
                      rights = "CC BY-SA. Daten: Kanton Basel-Stadt. Bearbeitung: Nico Görlich / Moritz Twente",
                      relation = list("m77089_1", "m77089_2")
                      )