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

data80238c <- read_excel(here("data", "raw", "Band8", "80238", "80238_Data_raw.xlsx"),
                         sheet = 3,
                         range = "A4:L19",
                         col_names = TRUE)

colnames(data80238c)[1] <- "Jahr"
colnames(data80238c)[11] <- "NA (ab 1991 UVP, ab 1982 SD)"

save_clean_csv(data80238c, vol = 8)

# Create Metadata ------------

meta80238c <- annotate(data = data80238c,
                       mediaID = "80238c",
                       vol = 8,
                       title = "Vertretung Basel-Stadt im Nationalrat, 1963–2023",
                       column_description = c("Jahreszahl im 20. Jahrhundert nach unserer Zeitrechnung", "Anzahl der baselstädtischen Mitglieder des Nationalrats der Partei 'POB' im entsprechenden Jahr", "Anzahl der baselstädtischen Mitglieder des Nationalrats der Partei 'GP' im entsprechenden Jahr", "Anzahl der baselstädtischen Mitglieder des Nationalrats der Partei 'SP' im entsprechenden Jahr", "Anzahl der baselstädtischen Mitglieder des Nationalrats der Partei 'LdU' im entsprechenden Jahr", "Anzahl der baselstädtischen Mitglieder des Nationalrats der Partei 'GLP' im entsprechenden Jahr", "Anzahl der baselstädtischen Mitglieder des Nationalrats der Partei 'CVP' im entsprechenden Jahr. Ab 2021 unter dem Namen 'Die Mitte'", "Anzahl der baselstädtischen Mitglieder des Nationalrats der Partei 'FDP' im entsprechenden Jahr. Bis 1973 unter dem Namen 'RDP'", "Anzahl der baselstädtischen Mitglieder des Nationalrats der Partei 'LDP' im entsprechenden Jahr", "Anzahl der baselstädtischen Mitglieder des Nationalrats der Partei 'SVP' im entsprechenden Jahr", "Anzahl der baselstädtischen Mitglieder des Nationalrats der Partei 'NA' im entsprechenden Jahr. Ab 1991 unter dem Namen 'UVP', ab 1992 unter dem Namen 'SD'", "Gesamtzahl der baselstädtischen Mitglieder des Nationalrats im entsprechenden Jahr. Reduzierung der Anzahl der Mandate auf die Jahre 1971, 1983, 2003"),
                       object_description = "In den 1960er-Jahren verfügte Basel-Stadt über acht Nationalratssitze, ab den Wahlen 1971 sank die Vertretung auf sieben, 1983 auf sechs, 2003 auf fünf, 2023 auf vier. Da in anderen Kantonen die Bevölkerung stark zunahm, war der Stadtkanton immer schwächer vertreten. Relativ konstant blieb die Balance der politischen Vertretung: Basel-Stadt schickte stets ähnlich viele Linke und Bürgerliche in die Grosse Kammer nach Bern",
                       creator = list(list(name = "Tobias Ehrenbold"),
                                      list(name = "Silas Gusset"),
                                      list(name = "Anina Zahn")),
                       contributor = list(list(name = "Nico Görlich",
                                               orcid = "0000-0003-3860-1488"),
                                          list(name = "Moritz Twente",
                                               email = "moritz.twente@unibas.ch",
                                               orcid = "0009-0005-7187-9774")),
                       date = "1963/2019",
                       temporal = "Zeitgeschichte",
                       source = "Quelle: Kanton Basel-Stadt: nationale und kantonale Wahlen seit 1919, Bundesamt für Statistik, je-d-17.02.01_12BS, online: https://www.bfs.admin.ch/bfs/de/home/statistiken/kataloge-datenbanken/tabellen.assetdetail.14836245.html. Bearbeitung: Nico Görlich / Moritz Twente",
                       rights = "Public Domain Mark",
                       relation = list("m80238c_1", "m80238c_2")
)