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

data80238a <- read_excel(here("data", "raw", "Band8", "80238", "80238_Data_raw.xlsx"),
                         sheet = 1,
                         range = "A3:K68",
                         col_names = TRUE)

colnames(data80238a)[11] <- "NeueLegislatur"

data80238a$NeueLegislatur <- ifelse(is.na(data80238a$NeueLegislatur), FALSE,
                                       data80238a$NeueLegislatur == "x")

save_clean_csv(data80238a, vol = 8)

# Create Metadata ------------

meta80238a <- annotate(data = data80238a,
                       mediaID = "80238a",
                       vol = 8,
                       title = "Regierungsrat in Basel-Stadt, 1960–2024",
                       column_description = c("Jahreszahl im 20. Jahrhundert nach unserer Zeitrechnung", "Anzahl der Regierungsrät*innen aus der Partei 'Grüne' im entsprechenden Jahr", "Anzahl der Regierungsrät*innen aus der Partei 'SP' im entsprechenden Jahr", "Anzahl der parteilosen Regierungsrät*innen im entsprechenden Jahr", "Anzahl der Regierungsrät*innen aus der Partei 'GLP' im entsprechenden Jahr", "Anzahl der Regierungsrät*innen aus der Partei 'DSP' im entsprechenden Jahr", "Anzahl der Regierungsrät*innen aus der Partei 'CVP' im entsprechenden Jahr", "Anzahl der Regierungsrät*innen aus der Partei 'FDP' im entsprechenden Jahr", "Anzahl der Regierungsrät*innen aus der Partei 'LDP' im entsprechenden Jahr", "Gesamtzahl der Regierungsrät*innen im entsprechenden Jahr", "Angabe, ob das Jahr der Beginn einer neuen Legislaturperiode markiert"),
                       object_description = "Die Basler Regierung war nach 1960 geprägt von relativ stabilen Verhältnissen. Bis zur Jahrtausendwende herrschte eine eine knappe bürgerliche Mehrheit, linke Parteien besetzten drei von sieben Sitzen. 2004 eroberten die Grünen einen Sitz der FDP, damit dominierte die rot-grüne Linke. Mit der Wahl von 2020 trat eine Pattsituation ein: Die Grünen verloren ihren Sitz an die GLP, die sowohl ökologische wie liberale Interessen vertritt",
                       creator = list(list(name = "Tobias Ehrenbold"),
                                      list(name = "Silas Gusset"),
                                      list(name = "Anina Zahn")),
                       contributor = list(list(name = "Nico Görlich",
                                               orcid = "0000-0003-3860-1488"),
                                          list(name = "Moritz Twente",
                                               email = "moritz.twente@unibas.ch",
                                               orcid = "0009-0005-7187-9774")),
                       date = "1960/2024",
                       coverage = "Zeitgeschichte",
                       source = "Quelle: https://www.bs.ch/regierungsrat/alt-regierungsraete. Bearbeitung: Nico Görlich / Moritz Twente",
                       rights = "Public Domain Mark",
                       relation = list("m80238a_1", "m80238a_2")
)