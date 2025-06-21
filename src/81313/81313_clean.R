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

data81313 <- read_excel(here("data", "raw", "Band8", "81313", "81313_Data_raw.xlsx"),
                        sheet = 1,
                        range = "A3:H11")

colnames(data81313)[1] <- c("Nationalität")

save_clean_csv(data81313, vol = 8)

# Create Metadata -------

meta81313 <- annotate(data = data81313,
                      mediaID = 81313,
                      vol = 8,
                      title = "Nationalitäten von in Basel-Stadt wohnhaften Ausländerinnen und Ausländern, 1960–2020",
                      column_description = c("Nationalitäten von Personengruppen in Basel-Stadt wohnhaften Ausländerinnen und Ausländern",
                                             "Anzahl der wohnhaften Ausländer*innen der angegebenen Nationalitäten im entsprechenden Jahr",
                                             "Anzahl der wohnhaften Ausländer*innen der angegebenen Nationalitäten im entsprechenden Jahr",
                                             "Anzahl der wohnhaften Ausländer*innen der angegebenen Nationalitäten im entsprechenden Jahr",
                                             "Anzahl der wohnhaften Ausländer*innen der angegebenen Nationalitäten im entsprechenden Jahr",
                                             "Anzahl der wohnhaften Ausländer*innen der angegebenen Nationalitäten im entsprechenden Jahr",
                                             "Anzahl der wohnhaften Ausländer*innen der angegebenen Nationalitäten im entsprechenden Jahr",
                                             "Anzahl der wohnhaften Ausländer*innen der angegebenen Nationalitäten im entsprechenden Jahr"),
                      object_description = "Zwischen 1960 und 1970 verdoppelte sich die Zahl der Einwohnerinnen und Einwohner mit ausländischer Staatsangehörigkeit nahezu. Besonders häufig waren Saisonniers aus Südeuropa. Italienerinnen und Italiener machten 1970 45 Prozent der ausländischen Bevölkerung und acht Prozent der Gesamteinwohnerzahl von Basel aus. Fortan sank ihr Anteil, während der Rezession mussten viele die Schweiz verlassen, später liessen sich auch einige einbürgern. Am Ende des 20. Jahrhunderts kam ein grosser Teil der Einwanderinnen und Einwanderer aus Osteuropa, 1990 stammten vierzen Prozent aller in Basel lebenden Ausländerinnen und Ausländer aus Jugoslawien und dreizehn Prozent aus der Türkei. 2002 führte die Schweiz die Personenfreizügigkeit ein und mit der Globalisierung kamen mehr Menschen aus fernen Ländern; die Bevölkerung wurde diverser. 2020 machte die Gruppe 'Übrigeds Ausland' mit 34 Prozent den grössten Anteil der ausländischen Einwohnerinnen und Einwohner aus, gefolgt von deutschen (22,5 Prozent) und italienischen (zwölf Prozent) Staatsangehörigen.",
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
                      source = "Quelle: https://statistik.bs.ch/apps/jahrbuch. Bearbeitung: Nico Görlich / Moritz Twente",
                      rights = "CC BY-SA. Daten: Kanton Basel-Stadt. Bearbeitung: Nico Görlich / Moritz Twente",
                      relation = list("m81313_1", "m81313_2")
)