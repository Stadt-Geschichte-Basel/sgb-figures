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

data22355 <- read_excel(here("data", "raw", "Band7", "22355", "22355_Data_raw.xlsx"),
                         sheet = 2,
                         range = "A1:J19",
                         col_names = TRUE)

colnames(data22355)[1] <- "Jahr"
names(data22355) <- gsub("[0-9]", "", names(data22355))
colnames(data22355)[2] <- "Liberaldemokratische Bürgerpartei"
colnames(data22355)[4] <- "Radikaldemokratische Partei"

save_clean_csv(data22355, vol = 7)

# Create Metadata ------------

meta22355 <- annotate(data = data22355,
                       mediaID = 22355,
                       vol = 7,
                       title = "Grossratsmandate nach Parteien, 1911–1964",
                       column_description = c("Jahreszahl im 20. Jahrhundert nach unserer Zeitrechnung",
                                              "Anzahl der Grossratsmitglieder der Partei 'Liberaldemokratische Bürgerpartei' im entsprechenden Jahr. bis 1956 Liberale Partei, ab 1943 gemeinsame Liste mit der Bürger- und Gewerbe-Partei, seit 1957 eine Partei",
                                              "Anzahl der Grossratsmitglieder der Partei 'Bürger- und Gewerbepartei' im entsprechenden Jahr. bis 1941 Nationale Volkspartei (bis 1941), ab 1957 vereinigt mit der vormaligen Liberalen Partei zur Liberaldemokratischen Bürgerpartei",
                                              "Anzahl der Grossratsmitglieder der Partei 'Radikaldemokratische Partei' im entsprechenden Jahr",
                                              "Anzahl der Grossratsmitglieder der Partei 'Vereinigung Evangelischer Wähler' im entsprechenden Jahr. bis 1947 Evangelische Volkspartei",
                                              "Anzahl der Grossratsmitglieder der Partei 'Partei der Arbeit' im entsprechenden Jahr. bis 1940 Kommunistische Partei; 1944 Liste der Arbeit; seit 1945 Partei der Arbeit (1960: und parteilose Gewerkschafter)",
                                              "Anzahl der Grossratsmitglieder der Partei 'Sozialdemokratische Partei' im entsprechenden Jahr. bis 1963 Sozialdemokratische Partei: 1964 Sozialdemokraten und Gewerkschafter",
                                              "Anzahl der Grossratsmitglieder der Partei 'Kath. und Christlich-Soziale Volkspartei' im entsprechenden Jahr. bis 1961 Katholische Volkspartei; seit 1963 Katholische und Christlichsoziale Volkspartei",
                                              "Anzahl der Grossratsmitglieder der Partei 'Landesring der Unabhängigen' im entsprechenden Jahr",
                                              "Anzahl der Grossratsmitglieder anderer Parteien im entsprechenden Jahr"),
                       object_description = "Im frühen 20. Jahrhundert lösten die Sozialdemokraten die zuvor dominierenden Freisinnigen als stärkste Kraft in Basel ab.",
                       creator = list(list(name = "Noëmi Crain Merz")),
                       contributor = list(list(name = "Nico Görlich",
                                               orcid = "0000-0003-3860-1488"),
                                          list(name = "Moritz Twente",
                                               email = "moritz.twente@unibas.ch",
                                               orcid = "0009-0005-7187-9774")),
                       date = "1911/1964",
                       coverage = "Zeitgeschichte",
                       source = "Quelle: Statistisches Jahrbuch des Kantons Basel-Stadt, diverse Jahrgänge: Daten 1911-1920: Ausgabe 1930. Daten 1923-1941: Ausgabe 1942, S. 195. Daten 1944-1964: Ausgabe 1966, S. 167. Bearbeitung: Nico Görlich / Moritz Twente",
                       rights = "Public Domain Mark",
                       relation = list("m22355_1", "m22355_2")
)