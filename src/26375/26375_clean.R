# Packages -------------------

library(here)
library(readxl)
library(csvwr)
library(jsonlite)
library(tidyr)

# Functions ------------------

source(here("src", "Funktionen", "Metadata_JSON.R"))
source(here("src", "Funktionen", "Export_CSV.R"))

# Read Data ------------------

data26375 <- read_excel(here("data", "raw", "Band7", "26375", "26375_Data_raw.xlsx"),
                        range = "A2:E9",
                        col_names = c("Branche", "1929", "1939", "1955", "1965"))

save_clean_csv(data26375, vol = 7)

# Create Metadata ------------

meta26375 <- annotate(data = data26375,
                      mediaID = 26375,
                      vol = 7,
                      title = "Hauptberuflich Beschäftigte im Dienstleistungssektor im Kanton Basel-Stadt, 1929–1965",
                      column_description = c("Bezeichnung der Branche, für die die angegebenen Zahlen gelten",
                                             "Anzahl der im angegebenen Bereich beschäftigten Personen im Kanton Basel-Stadt im Jahr 1929",
                                             "Anzahl der im angegebenen Bereich beschäftigten Personen im Kanton Basel-Stadt im Jahr 1939",
                                             "Anzahl der im angegebenen Bereich beschäftigten Personen im Kanton Basel-Stadt im Jahr 1955",
                                             "Anzahl der im angegebenen Bereich beschäftigten Personen im Kanton Basel-Stadt im Jahr 1965"),
                      object_description = "Die Beschäftigten im Dienstleistungssektor nahmen mit jeder Zählung zu, sprunghaft insbesondere in der Nachkriegszeit. 1965 wurden erstmals auch die Zahlen der Beschäftigten der öffentlichen Verwaltung im Rahmen der eidgenössischen Betriebszählungen separat erhoben",
                      creator = list(list(name = "Isabel Koellreuter")),
                      contributor = list(list(name = "Nico Görlich",
                                              orcid = "0000-0003-3860-1488"),
                                         list(name = "Moritz Twente",
                                              email = "moritz.twente@unibas.ch",
                                              orcid = "0009-0005-7187-9774")),
                      date = "1929/1965",
                      temporal = list("20. Jahrhundert"),
                      source = "Quelle: Böhner, Martin: Die Eidgenössische Betriebszählung 1965 aus baslerischer Sicht, Basel 1968, S. 66f; Eidgenössisches Statistisches Amt (Hg.): Beschäftigte in den Gemeinden: nach Wirtschaftsfaktoren, Bern 1968 S. 59. Bearbeitung: Nico Görlich / Moritz Twente",
                      rights = "Public Domain Mark",
                      relation = list("m26375_1", "m26375_2")
)