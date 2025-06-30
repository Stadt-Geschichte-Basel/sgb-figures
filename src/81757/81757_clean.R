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

data81757 <- read_excel(here("data", "raw", "Band8", "81757", "81757_Data_raw.xlsx"),
                        sheet = 1,
                        range = "A2:H63")

colnames(data81757)[1] <- "Jahr"

save_clean_csv(data81757, vol = 8)

# Create Metadata ------------

meta81757 <- annotate(data = data81757,
                      mediaID = 81757,
                      vol = 8,
                      title = "Anteil an Ausländerinnen und Ausländern im Kanton und in ausgewählten Quartieren, 1960–2020",
                      column_description = c("Jahreszahl nach unserer Zeitrechnung", "Prozentualer Anteil der Ausländerinnen und Ausländer an der Gesamtbevölkerung im Kanton Basel-Stadt im entsprechenden Jahr", "Prozentualer Anteil der Ausländerinnen und Ausländer an der Gesamtbevölkerung im Wohnviertel Matthäus im entsprechenden Jahr", "Prozentualer Anteil der Ausländerinnen und Ausländer an der Gesamtbevölkerung im Wohnviertel St. Johann im entsprechenden Jahr", "Prozentualer Anteil der Ausländerinnen und Ausländer an der Gesamtbevölkerung im Wohnviertel Breite im entsprechenden Jahr", "Prozentualer Anteil der Ausländerinnen und Ausländer an der Gesamtbevölkerung im Wohnviertel Gundeldingen im entsprechenden Jahr", "Prozentualer Anteil der Ausländerinnen und Ausländer an der Gesamtbevölkerung im Wohnviertel Bruderholz im entsprechenden Jahr", "Prozentualer Anteil der Ausländerinnen und Ausländer an der Gesamtbevölkerung in der Gemeinde Riehen im entsprechenden Jahr"),
                      object_description = "Zwischen 1960 und 2020 vervierfachte sich der Anteil an Ausländerinnen und Ausländern an der Basler Bevölkerung nahezu. Den höchsten Anteil wies das Kleinbasler Quartier Matthäus auf, von 1960 bis 2020 stieg er dort von 12,7 auf 50,7 Prozent. Ebenfalls überdurchschnittlich war der Anteil in Gundeldingen und St. Johann, beides dichtbebaute Quartiere. Das Quartier Breite war ein traditionelles Arbeiterquartier mit vielen Genossenschaften, die Ausländerinnen und Ausländer zurückhaltend aufnahmen. Den geringsten Anteil hatten das wohlhabende Bruderholz und die Landgemeinde Riehen, in beiden betrug er 2000 etwa dreizehn Prozent. Insbesondere Riehen verzeichnete in den folgenden Jahren einen markanten Anstieg, der mit der gestiegenen Wirtschaftskraft vieler Einwanderer zusammenhing: Zunehmend gut ausgebildete Fachkräfte aus dem Ausland, sogenannte Expats, zogen in Gegenden mit einem höheren Anteil an Einfamilienhäusern.",
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
                      source = "Statistisches Amt Kanton Basel-Stadt. Bearbeitung: Nico Görlich / Moritz Twente",
                      rights = "Public Domain Mark",
                      relation = list("m81757_1", "m81757_2")
)