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

data88415 <- read_excel(here("data", "raw", "Band8", "88415", "88415_Data_raw.xlsx"),
                        range = "A5:D68")

save_clean_csv(data88415, vol = 8)

# Create Metadata -------

meta88415 <- annotate(data = data88415,
                      mediaID = 88415,
                      vol = 8,
                      title = "Publikumszahlen an Konzerten und FCB-Spielen im St. Jakob-Stadion, 1960–2022",
                      column_description = c("Angabe des Jahres nach unserer Zeitrechnung",
                                             "Anzahl der Zuschauer:innen bei Heimspielen des FC Basel im angegebenen Jahr, ab 1967/1968 im St. Jakob-Station, davor im Landhof, 1999-2001 auf der Schützenmatte",
                                             "Anzahl der Zuschauer:innen bei Konzerten im angegebenen Jahr",
                                             "Anzahl der Heimspiele des FC Basel im angegebenen Jahr"),
                      object_description = "In den 1980er-Jahren rutschte der FC Basel in eine veritable Krise, die 1988 im Abstieg in die Nationalliga B mündete. Die Spiele besuchten jeweils nur noch etwa 5000 Menschen, deutlich mehr gingen inzwischen für die Grössen der Pop- und Rockmusik ins Stadion. Im 2001 eröffneten neuen St. Jakob-Park fanden Open-Air-Konzerte nur noch selten statt, während bis zu 30 000 Menschen Woche um Woche den FCB bejubelten, der wieder gross aufspielte. Der Einbruch im Jahr 2020 ist auf die Corona-Pandemie zurückzuführen.",
                      creator = list(list(name = "Tobias Ehrenbold"),
                                     list(name = "Silas Gusset"),
                                     list(name = "Anina Zahn")),
                      contributor = list(list(name = "Nico Görlich",
                                              orcid = "0000-0003-3860-1488"),
                                         list(name = "Moritz Twente",
                                              email = "moritz.twente@unibas.ch",
                                              orcid = "0009-0005-7187-9774")),
                      date = "1960/2022",
                      temporal = "Zeitgeschichte",
                      source = "Quelle: FC Basel-Archiv; Kraft der Vision. Bearbeitung: Nico Görlich / Moritz Twente",
                      rights = "Public Domain Mark",
                      relation = list("m88415_1", "m88415_2")
)