# Packages -------------------

library(here)
library(readxl)

# Functions ------------------

source(here("src", "Utils", "Metadata_JSON.R"))
source(here("src", "Utils", "Export_CSV.R"))

# Process Data ---------------

data80238a <- read_excel(here("data", "raw", "Band8", "80238", "80238_Data_raw.xlsx"),
  sheet = 1,
  range = "A3:K68",
  col_names = TRUE
)

colnames(data80238a)[11] <- "NeueLegislatur"

data80238a$NeueLegislatur <- ifelse(is.na(data80238a$NeueLegislatur), FALSE,
  data80238a$NeueLegislatur == "x"
)

save_clean_csv(data80238a, csv_suffix = 3, vol = 8)

# Create Metadata ------------

meta80238a <- annotate(
  data = data80238a,
  media_id = 80238,
  csv_suffix = 3,
  vol = 8,
  title = "Regierungsrat in Basel-Stadt, 1960–2024",
  column_description = c("Jahreszahl im 20. Jahrhundert nach unserer Zeitrechnung", "Anzahl der Regierungsrät*innen aus der Partei 'Grüne Partei' im entsprechenden Jahr", "Anzahl der Regierungsrät*innen aus der Partei 'Sozialdemokratische Partei' im entsprechenden Jahr", "Anzahl der parteilosen Regierungsrät*innen im entsprechenden Jahr", "Anzahl der Regierungsrät*innen aus der Partei 'Grünliberale Partei' im entsprechenden Jahr", "Anzahl der Regierungsrät*innen aus der Partei 'Demokratisch-Soziale Partei' im entsprechenden Jahr", "Anzahl der Regierungsrät*innen aus der Partei 'Christlichdemokratische Volkspartei (ab 2021 Die Mitte)' im entsprechenden Jahr", "Anzahl der Regierungsrät*innen aus der Partei 'FDP.Die Liberalen' im entsprechenden Jahr", "Anzahl der Regierungsrät*innen aus der Partei 'Liberal-Demokratische Partei' im entsprechenden Jahr", "Gesamtzahl der Regierungsrät*innen im entsprechenden Jahr", "Angabe, ob das Jahr der Beginn einer neuen Legislaturperiode markiert"),
  column_datatype = c("gYear", rep("integer", 9), "boolean"),
  object_description = "Die Basler Regierung war nach 1960 geprägt von relativ stabilen Verhältnissen. Bis zur Jahrtausendwende herrschte eine knappe bürgerliche Mehrheit, linke Parteien besetzten drei von sieben Sitzen. 2004 eroberten die Grünen einen Sitz der FDP, damit dominierte die rot-grüne Linke. Mit der Wahl von 2020 trat eine Pattsituation ein: Die Grünen verloren ihren Sitz an die GLP, die sowohl ökologische wie liberale Interessen vertritt.",
  creator = list(
    list(name = "Tobias Ehrenbold"),
    list(name = "Silas Gusset"),
    list(name = "Anina Zahn")
  ),
  contributor = list(
    list(
      name = "Nico Görlich",
      orcid = "0000-0003-3860-1488"
    ),
    list(
      name = "Moritz Twente",
      email = "mtwente@protonmail.com",
      orcid = "0009-0005-7187-9774"
    )
  ),
  date = "1960/2024",
  coverage = "20. Jahrhundert",
  source = "https://www.bs.ch/regierungsrat/alt-regierungsraete. Bearbeitung: Nico Görlich / Moritz Twente",
  rights = "Public Domain Mark",
  relation = c("m80238_1", "m80238_2")
)
