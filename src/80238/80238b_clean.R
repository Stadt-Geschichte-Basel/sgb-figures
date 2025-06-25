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

data80238b <- read_excel(here("data", "raw", "Band8", "80238", "80238_Data_raw.xlsx"),
                         sheet = 2,
                         range = "A3:R19",
                         col_names = TRUE)

save_clean_csv(data80238b, vol = 8)

# Create Metadata -------

meta80238b <- annotate(data = data80238b,
                       mediaID = "80238b",
                       vol = 8,
                       title = "Grosser Rat in Basel-Stadt, 1960–2024",
                       column_description = c("Jahreszahl im 20. Jahrhundert nach unserer Zeitrechnung", "Anzahl der Grossratsmitglieder der Partei 'POB' im entsprechenden Jahr", "Anzahl der Grossratsmitglieder der Partei 'FraB' im entsprechenden Jahr", "Anzahl der Grossratsmitglieder der Partei 'PdA' im entsprechenden Jahr", "Anzahl der Grossratsmitglieder der Partei 'GB' im entsprechenden Jahr. 'GB' bezeichnet das Grüne Bündnis aus Grüne und BastA, ab 2021 als 'GAB'", "Anzahl der Grossratsmitglieder der Partei 'GP' im entsprechenden Jahr", "Anzahl der Grossratsmitglieder der Partei 'SP' im entsprechenden Jahr", "Anzahl der Grossratsmitglieder der Partei 'LdU' im entsprechenden Jahr", "Anzahl der Grossratsmitglieder der Partei 'GLP' im entsprechenden Jahr", "Anzahl der Grossratsmitglieder der Partei 'DSP' im entsprechenden Jahr", "Anzahl der Grossratsmitglieder der Partei 'CVP' im entsprechenden Jahr. Ab 2021 unter dem Namen 'Die Mitte'", "Anzahl der Grossratsmitglieder der Partei 'EVP' im entsprechenden Jahr. Bis 2006 als 'VEW'", "Anzahl der Grossratsmitglieder der Partei 'FDP' im entsprechenden Jahr. Bis 1973 als 'RDP'", "Anzahl der Grossratsmitglieder der Partei 'LDP' im entsprechenden Jahr", "Anzahl der Grossratsmitglieder der Partei 'SVP' im entsprechenden Jahr", "Anzahl der Grossratsmitglieder der Partei 'NA' im entsprechenden Jahr. Ab 1991 als 'UVP', ab 1992 als 'SD'", "Anzahl der Grossratsmitglieder weiterer Parteien im entsprechenden Jahr", "Gesamtzahl der Grossratsmitglieder. Reduzierung der Anzahl der Mandate im Jahr 2008"),
                       object_description = "Die Parteienlandschaft in Basel hat sich seit 1960 stark verändert, mit Auswirkungen auf die Sitzverteilung im Basler Grossrat. Besonders stark waren die­ Umwälzungen in den 1990er-Jahren: Traditionsreiche Parteien wie die PdA und die LdU verloren ihre letzten Sitze, aufstrebende Parteien wie die Grünen und die SVP gewannen in kurzer Zeit viele Mandate. 2005 nahm das Stimmvolk die neue Kantonsverfassung an, eine gewichtige Folge davon war die Verkleinerung des Grossen Rates auf hundert Mitglieder",
                       creator = list(list(name = "Tobias Ehrenbold"),
                                      list(name = "Silas Gusset"),
                                      list(name = "Anina Zahn")),
                       contributor = list(list(name = "Nico Görlich",
                                               orcid = "0000-0003-3860-1488"),
                                          list(name = "Moritz Twente",
                                               email = "moritz.twente@unibas.ch",
                                               orcid = "0009-0005-7187-9774")),
                       date = "1960/2024",
                       temporal = "Zeitgeschichte",
                       source = "Quelle: Sitzverteilung im Grossen Rat seit 1905, Entwicklung Frauenanteil im Grossen Rat, t17.3.05, Statistisches Amt BS, online: https://grosserrat.bs.ch/parlament/ratsgeschichte/entwicklung-der-parteien; Parteien, Jungeparteien und Listenvereinigungen seit 1971, t17.1.01, Statistisches Amt BS, online: https://grosserrat.bs.ch/parlament/ratsgeschichte/entwicklung-der-parteien; Nationale und kantonale Wahlen seit 1919, Bundesamt für Statistik, je-d-17.02.01_12BS, online: https://www.bfs.admin.ch/bfs/de/home/statistiken/kataloge-datenbanken/tabellen.assetdetail.14836245.html. Bearbeitung: Nico Görlich / Moritz Twente",
                       rights = "Public Domain Mark",
                       relation = list("m80238b_1", "m80238b_2")
)