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

data86088 <- read_excel(here("data", "raw", "Band8", "86088", "86088_Data_raw.xlsx"),
                        range = "A3:I11")

save_clean_csv(data86088, vol = 8)

# Create Metadata -------

meta86088 <- annotate(data = data86088,
                      mediaID = 86088,
                      vol = 8,
                      title = "Religionszugehörigkeiten in Basel-Stadt, 1950–2020",
                      column_description = c("Angabe des Jahres nach unserer Zeitrechnung",
                                             "Anzahl der Angehörigen evangelisch-reformierter Glaubensgemeinschaften im Kanton Basel-Stadt im angegebenen Jahr",
                                             "Anzahl der Angehörigen römisch-katholischer Glaubensgemeinschaften im Kanton Basel-Stadt im angegebenen Jahr",
                                             "Anzahl der Angehörigen anderer christlicher Glaubensgemeinschaften (weder evangelisch-reformiert, noch römisch-katholisch) im Kanton Basel-Stadt im angegebenen Jahr",
                                             "Anzahl der Angehörigen jüdischer Glaubensgemeinschaften im Kanton Basel-Stadt im angegebenen Jahr",
                                             "Anzahl der Angehörigen islamischer Glaubensgemeinschaften im Kanton Basel-Stadt im angegebenen Jahr",
                                             "Anzahl der Angehörigen anderer Glaubensgemeinschaften im Kanton Basel-Stadt im angegebenen Jahr",
                                             "Anzahl der konfessionslosen Menschen im Kanton Basel-Stadt im angegebenen Jahr",
                                             "Anzahl der Menschen ohne Angabe zur Religionszugehörigkeit im Kanton Basel-Stadt im angegebenen Jahr"),
                      object_description = "In den 1950er-Jahren waren fast alle Bewohnerinnen und Bewohner von Basel reformiert oder katholisch, kaum jemand konfessionslos und nur wenige Angehörige einer anderen Glaubensgemeinschaft. Das hat sich seither grundlegend verändert. Basel entwickelte sich zu einer multireligiösen Gesellschaft. Der muslimische Glaube etablierte sich, das Christentum verlor derweil an Bedeutung im Alltag. Keine andere Stadt in der Schweiz hatte um 2020 so viele Konfessionslose wie Basel.",
                      creator = list(list(name = "Tobias Ehrenbold"),
                                     list(name = "Silas Gusset"),
                                     list(name = "Anina Zahn")),
                      contributor = list(list(name = "Nico Görlich",
                                              orcid = "0000-0003-3860-1488"),
                                         list(name = "Moritz Twente",
                                              email = "moritz.twente@unibas.ch",
                                              orcid = "0009-0005-7187-9774")),
                      date = "1950/2020",
                      temporal = "Zeitgeschichte",
                      source = "Quelle: Statistisches Amt des Kantons Basel-Stadt. Bearbeitung: Nico Görlich / Moritz Twente",
                      rights = "Public Domain Mark",
                      relation = list("m86088_1", "m86088_2")
)