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

data80238d <- read_excel(here("data", "raw", "Band8", "80238", "80238_Data_raw.xlsx"),
                         sheet = 3,
                         range = "M4:O19",
                         col_names = TRUE)

colnames(data80238d)[1] <- "Jahr"

save_clean_csv(data80238d, vol = 8)

# Create Metadata ------------

meta80238d <- annotate(data = data80238d,
                       mediaID = "80238d",
                       vol = 8,
                       title = "Vertretung Basel-Stadt im Ständerat, 1963–2023",
                       column_description = c("Jahreszahl im 20. Jahrhundert nach unserer Zeitrechnung", "Anzahl der baselstädtischen Mitglieder des Ständerats der Partei 'SP' im entsprechenden Jahr", "Anzahl der baselstädtischen Mitglieder des Ständerats der Partei 'FDP' im entsprechenden Jahr"),
                       object_description = "Als Halbkanton steht Basel-Stadt nur ein Sitz im Ständerat zu. Nach dem Freisinnigen Eugen Dietschi (1960–1967) trugen dieses Amt über Jahrzehnte nur noch Vertreterinnen und Vertreter der SP: Willi Wenk (1967–1979), Carl Miville (1979–1991), Gian-Reto Plattner (1991–2003), Anita Fetz (2003–2019), Eva Herzog (seit 2019)",
                       creator = list(list(name = "Tobias Ehrenbold"),
                                      list(name = "Silas Gusset"),
                                      list(name = "Anina Zahn")),
                       contributor = list(list(name = "Nico Görlich",
                                               orcid = "0000-0003-3860-1488"),
                                          list(name = "Moritz Twente",
                                               email = "moritz.twente@unibas.ch",
                                               orcid = "0009-0005-7187-9774")),
                       date = "1963/2019",
                       coverage = "Zeitgeschichte",
                       source = "Quelle: Kanton Basel-Stadt: nationale und kantonale Wahlen seit 1919, Bundesamt für Statistik, je-d-17.02.01_12BS, online: https://www.bfs.admin.ch/bfs/de/home/statistiken/kataloge-datenbanken/tabellen.assetdetail.14836245.html. Bearbeitung: Nico Görlich / Moritz Twente",
                       rights = "Public Domain Mark",
                       relation = list("m80238d_1", "m80238d_2")
)