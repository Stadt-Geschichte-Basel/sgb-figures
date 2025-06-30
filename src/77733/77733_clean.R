# Packages -------------------

library(here)
library(readxl)
library(csvwr)
library(jsonlite)
library(magrittr)

# Functions ------------------

source(here("src", "Funktionen", "Metadata_JSON.R"))
source(here("src", "Funktionen", "Export_CSV.R"))

# Process Data ---------------

data77733 <- read_excel(here("data", "raw", "Band8", "77733", "77733_Data_raw.xlsx"),
                        sheet = 1,
                        range = "A3:F84")

data77733 <- data77733[,-3:-5]

save_clean_csv(data77733, vol = 8)

# Create Metadata ------------

meta77733 <- annotate(data = data77733,
                      mediaID = 77733,
                      vol = 8,
                      title = "Bevölkerungsentwicklung in den Kantonen Basel-Stadt und Basel-Landschaft, 1940–2020",
                      column_description = c("Jahreszahl im 20. Jahrhundert nach unserer Zeitrechnung", "Anzahl der die Wohnbevölkerung des Kantons Basel-Stadt bildenden Menschen im entsprechenden Jahr. Die Zahlen beruhen bis 1969 auf Volkszählungen, ab 1970 handelt es sich um Rückberechnungen auf Basis des Bestandes der Einwohnerdienste im Jahr 1990", "Anzahl der die Wohnbevölkerung des Kantons Basel-Landschaft bildenden Menschen im entsprechenden Jahr. Ab dem Jahr 1994 inklusive Laufental"),
                      object_description = "Während der Kanton Basel-Stadt nach 1970 einen markanten Rückgang verzeichnete, nahm die Bevölkerung in Basel-Landschaft kontinuierlich zu. Viele junge Familien zog es in die Agglomeration, wo der Traum vom Eigenheim noch finanzierbar war. Die Entwicklung der Wohnbevölkerung veranschaulicht den Trend der Stadtflucht, der im 21. Jahrhundert abflaute.",
                      creator = list(list(name = "Tobias Ehrenbold"),
                                     list(name = "Silas Gusset"),
                                     list(name = "Anina Zahn")),
                      contributor = list(list(name = "Nico Görlich",
                                              orcid = "0000-0003-3860-1488"),
                                    list(name = "Moritz Twente",
                                         email = "moritz.twente@unibas.ch",
                                         orcid = "0009-0005-7187-9774")),
                      date = "1940/2020",
                      temporal = "Zeitgeschichte",
                      source = "Quelle: https://statistik.bs.ch/apps/jahrbuch; Moll; Sandtner; Saner 2002, Anhang 2.1; https://www.statistik.bl.ch/web_portal/1_9; https://www.statistik.bl.ch/web_portal/1_1_3?sheet=6&Jahr=34. Bearbeitung: Nico Görlich / Moritz Twente",
                      rights = "Public Domain Mark",
                      relation = list("m77733_1", "m77733_2")
                      )