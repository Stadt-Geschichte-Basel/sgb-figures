# Packages -------------------

library(here)
library(readxl)
library(csvwr)
library(magrittr)
library(jsonlite)
library(tidyr)

# Functions ------------------

source(here("src", "Funktionen", "Metadata_JSON.R"))
source(here("src", "Funktionen", "Export_CSV.R"))

# Process Data --------

data82338 <- read_excel(here("data", "raw", "Band8", "82338", "82338_Data_raw.xlsx"),
                        range = "A3:AE9")

colnames(data82338)[1] <- "Kanton"

data82338 <- data82338 %>%
  pivot_longer(-Kanton, names_to = "Jahr", values_to = "Wert") %>%
  pivot_wider(names_from = Kanton, values_from = Wert)

data82338 <- data82338[, -c(5, 6)] # Plot ohne Waadt und Neuenburg

save_clean_csv(data82338, vol = 8)

# Create Metadata -------

meta82338 <- annotate(data = data82338,
                      mediaID = 82338,
                      vol = 8,
                      title = "Arbeitslosenquote der Kantone Basel-Stadt, Genf und Zürich sowie der gesamten Schweiz, 1973–2002",
                      column_description = c("Jahreszahl nach unserer Zeitrechnung", "Anteil der Arbeitslosen an der Gesamtbevölkerung der Schweiz in Prozent im entsprechenden Jahr", "Anteil der Arbeitslosen an der Bevölkerung des Kantons Basel-Stadt in Prozent im entsprechenden Jahr", "Anteil der Arbeitslosen an der Gesamtbevölkerung des Kantons Genf in Prozent im entsprechenden Jahr", "Anteil der Arbeitslosen an der Gesamtbevölkerung des Kantons Zürich in Prozent im entsprechenden Jahr"),
                      object_description = "Die Erfassung der Arbeitslosigkeit ist voller Tücken. In der Statistik werden nur Menschen erfasst, die Anspruch auf Arbeitslosenentschädigungen haben. Der Anteil an Erwerbslosen war während der Rezession Mitte der 1970er-Jahre jedoch wesentlich höher, als es die erhobene Arbeitslosenquote von 0.5 bis 1.5 Prozent vermuten lässt. Die Zahlen blieben niedrig, weil viele ausländische Arbeitnehmerinnen und Arbeitnehmer mit ihrem Stellenverlust auch ihr Aufenthaltsrecht verloren. Im Vergleich zum Landesdurchschnitt verzeichnete der Kanton Basel-Stadt Mitte der 1980er-Jahre eine hohe Arbeitslosenquote von knapp drei Prozent. In der Krise der 1990er-Jahre stieg sie auf fast sechs Prozent, im Kanton Zürich lag sie tiefer, in Westschweizer Kantonen wie Genf noch höher.",
                      creator = list(list(name = "Tobias Ehrenbold"),
                                     list(name = "Silas Gusset"),
                                     list(name = "Anina Zahn")),
                      contributor = list(list(name = "Nico Görlich",
                                              orcid = "0000-0003-3860-1488"),
                                         list(name = "Moritz Twente",
                                              email = "moritz.twente@unibas.ch",
                                              orcid = "0009-0005-7187-9774")),
                      date = "1973/2002",
                      temporal = "Zeitgeschichte",
                      source = "Statistisches Amt Kanton Basel-Stadt. Bearbeitung: Nico Görlich / Moritz Twente",
                      rights = "Public Domain Mark. Bearbeitung: Nico Görlich / Moritz Twente",
                      relation = list("m82338_1", "m82338_2")
)