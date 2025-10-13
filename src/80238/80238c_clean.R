# Packages -------------------

library(here)
library(readxl)

# Functions ------------------

source(here("src", "Utils", "Metadata_JSON.R"))
source(here("src", "Utils", "Export_CSV.R"))

# Process Data ---------------

data80238c <- read_excel(here("data", "raw", "Band8", "80238", "80238_Data_raw.xlsx"),
  sheet = 3,
  range = "A4:L19",
  col_names = TRUE
)

colnames(data80238c)[1] <- "Jahr"
colnames(data80238c)[11] <- "NA (ab 1991 UVP, ab 1982 SD)"

save_clean_csv(data80238c, csv_suffix = 9, vol = 8)

# Create Metadata ------------

meta80238c <- annotate(
  data = data80238c,
  media_id = 80238,
  csv_suffix = 9,
  vol = 8,
  title = "Vertretung Basel-Stadt im Nationalrat, 1963–2023",
  column_description = c("Jahreszahl im 20. Jahrhundert nach unserer Zeitrechnung", "Anzahl der baselstädtischen Mitglieder des Nationalrats der Partei 'Progressive Organisationen Basel' im entsprechenden Jahr", "Anzahl der baselstädtischen Mitglieder des Nationalrats der Partei 'Grüne Partei' im entsprechenden Jahr", "Anzahl der baselstädtischen Mitglieder des Nationalrats der Partei 'Sozialdemokratische Partei' im entsprechenden Jahr", "Anzahl der baselstädtischen Mitglieder des Nationalrats der Partei 'Landesring der Unabhängigen' im entsprechenden Jahr", "Anzahl der baselstädtischen Mitglieder des Nationalrats der Partei 'Grünliberale Partei' im entsprechenden Jahr", "Anzahl der baselstädtischen Mitglieder des Nationalrats der Partei 'Christlichdemokratische Volkspartei' im entsprechenden Jahr. Ab 2021 unter dem Namen 'Die Mitte'", "Anzahl der baselstädtischen Mitglieder des Nationalrats der Partei 'FDP.Die Liberalen' im entsprechenden Jahr. Bis 1973 unter dem Namen 'Radikal-Demokratische Partei' (RDP)", "Anzahl der baselstädtischen Mitglieder des Nationalrats der Partei 'Liberal-Demokratische Partei' im entsprechenden Jahr", "Anzahl der baselstädtischen Mitglieder des Nationalrats der Partei 'Schweizerische Volkspartei' im entsprechenden Jahr", "Anzahl der baselstädtischen Mitglieder des Nationalrats der Partei 'Nationale Aktion' im entsprechenden Jahr. Ab 1991 unter dem Namen 'UVP', ab 1992 unter dem Namen 'Schweizer Demokraten' (SD)", "Gesamtzahl der baselstädtischen Mitglieder des Nationalrats im entsprechenden Jahr. Reduzierung der Anzahl der Mandate auf die Jahre 1971, 1983, 2003"),
  column_datatype = c("gYear", rep("integer", 11)),
  object_description = "In den 1960er-Jahren verfügte Basel-Stadt über acht Nationalratssitze, ab den Wahlen 1971 sank die Vertretung auf sieben, 1983 auf sechs, 2003 auf fünf, 2023 auf vier. Da in anderen Kantonen die Bevölkerung stark zunahm, war der Stadtkanton immer schwächer vertreten. Relativ konstant blieb die Balance der politischen Vertretung: Basel-Stadt schickte stets ähnlich viele Linke und Bürgerliche in die Grosse Kammer nach Bern.",
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
  date = "1963/2019",
  coverage = "20. Jahrhundert",
  source = "Kanton Basel-Stadt: nationale und kantonale Wahlen seit 1919, Bundesamt für Statistik, je-d-17.02.01_12BS, online: https://www.bfs.admin.ch/bfs/de/home/statistiken/kataloge-datenbanken/tabellen.assetdetail.14836245.html. Bearbeitung: Nico Görlich / Moritz Twente",
  rights = "Public Domain Mark",
  relation = c("m80238_7", "m80238_8")
)
