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

data77089 <- read_excel(here("data", "raw", "Band8", "77089", "77089_Data_raw.xlsx"),
                        sheet = 1,
                        range = "A3:D106")

colnames(data77089)[3] <- "Motorräder inkl. Mofas"

save_clean_csv(data77089, vol = 8)

# Create Metadata ------------

meta77089 <- annotate(data = data77089,
                      mediaID = 77089,
                      vol = 8,
                      title = "Der Fahrzeugbestand in Basel-Stadt, 1920–2020",
                      column_description = c("Jahreszahl im 20. Jahrhundert nach unserer Zeitrechnung", "Anzahl der Personenwagen (Automobile) im Fahrzeugbestand im Kanton Basel-Stadt im entsprechenden Jahr. Ab dem Jahr 2019 werden in dieser Kategorie auch E-Autos mitgezählt. Die Zahlen stellen bis inkl. 1953 'Erteilte Fahrzeugausweise auf Jahresende' dar, ab inkl. 1954 dann 'Motorfahrzeug- und Fahrrad-Höchstbestände'. Die Angabe für 1920 ist eine Schätzung auf Basis der Daten von 1921 und Angaben von https://hsso.ch/2012/n/12. Für die Jahre 1924, 1927, 1929, 1930, 1931, 1932, 1934, 1965–1953, 1960, 1961: Abweichende Angaben in früheren oder späteren Berichten.", "Anzahl an Motorrädern (inklusive Mofas) im Fahrzeugbestand im Kanton Basel-Stadt im entsprechenden Jahr. Die Zahlen stellen bis inkl. 1953 'Erteilte Fahrzeugausweise auf Jahresende' dar, ab inkl. 1954 dann 'Motorfahrzeug- und Fahrrad-Höchstbestände'. Ab 1954 weiterhin neu exkl. Dreiräder (davor jeweils max. 25). Für die Jahre 1924, 1925, 1927, 1928, 1929, 1930, 1931, 1933, 1935, 1939, 1940, 1946–1954, 1960, 1961: Abweichende Angaben in früheren oder späteren Berichten.", "Anzahl an Fahrrädern im Fahrzeugbestand im Kanton Basel-Stadt im entsprechenden Jahr. Für das Jahr 1961: Abweichende Angaben in späteren Berichten"),
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
                      coverage = "Zeitgeschichte",
                      source = "https://statistik.bs.ch/apps/jahrbuch; https://statistik.bs.ch/files/webtabellen/t11-1-01.xlsx. Bearbeitung: Nico Görlich / Moritz Twente",
                      rights = "Public Domain Mark",
                      relation = list("m77089_1", "m77089_2")
                      )