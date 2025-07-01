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

data39492 <- read_excel(here("data", "raw", "Band3", "39492", "39492_Data_raw.xlsx"),
                        sheet = 2,
                        col_names = c("Startjahr", "Endjahr", "Zeitraum", "Summe Bürgeraufnahmen", "Summe Kriegsausgaben in Pfund"),
                        range = "A2:E35")

save_clean_csv(data39492, vol = 3)

# Create Metadata ------------

meta39492 <- annotate(data = data39492,
                      mediaID = 39492,
                      vol = 3,
                      title = "Bürgeraufnahmen und Kriegsausgaben, 1360–1530",
                      column_description = c("Jahreszahl, Angabe in Jahren unserer Zeitrechnung", "Jahreszahl, Angabe in Jahren unserer Zeitrechnung", "Zeitraum, Angaben in Jahren unserer Zeitrechnung", "Summe der Bürgeraufnahmen im jeweiligen Zeitraum", "Summe der Kriegsausgaben im jeweiligen Zeitraum in Pfund"),
                      object_description = c("Der Zusammenhang zwischen Bürgeraufnahmen und Kriegszügen wird aus der Gegenüberstellung mit den städtischen Kriegsausgaben klar ersichtlich. Bis weit ins 15. Jahrhundert richtete sich die Einbürgerungspolitik nach den Bedürfnissen der Stadt im Kriegsfall und nicht nach der Migration. Entsprechend verging wohl für viele Zugezogene eine lange Zeit zwischen Zuwanderung und Einbürgerung (Daten nach: Portmann 1979, S. 96–99. Rosen 1984, S. 477–479)"),
                      creator = list(list(name = "Benjamin Hitz",
                                          orcid = "0000-0002-3208-4881")),
                      contributor = list(list(name = "Nico Görlich",
                                              orcid = "0000-0003-3860-1488"),
                                         list(name = "Moritz Twente",
                                              email = "moritz.twente@unibas.ch",
                                              orcid = "0009-0005-7187-9774")),
                      date = "1360/1525",
                      coverage = "Neuzeit",
                      source = "Portmann, Rolf Ernst: Basler Einbürgerungspolitik 1358–1798. Mit einer Berufs- und Herkunftsstatistik des Mittelalters, Basel 1979, S. 96–99. Rosen, Josef: Kriegsausgaben im Spätmittelalter. Der militärische Aufwand in Basel 1360–1535, in: Vierteljahrschrift für Sozial- und Wirtschaftsgeschichte 71, 1984, S. 477–479. Bearbeitung: Nico Görlich / Moritz Twente",
                      rights = "Public Domain Mark",
                      relation = list("m39492_1", "m39492_2")
)