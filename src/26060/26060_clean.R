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

data26060 <- read_excel(here("data", "raw", "Band7", "26060", "26060_Data_raw.xlsx"),
                        range = "A1:E7")

colnames(data26060) <- c("Branche", "1929", "1939", "1955", "1965")

data26060 <- data26060[-2,]
data26060$Branche[5] <- "Dienstleistungen (ohne öffentliche Verwaltung)"

save_clean_csv(data26060, vol = 7)

# Create Metadata ------------

meta26060 <- annotate(data = data26060,
                      mediaID = 26060,
                      vol = 7,
                      title = "Beschäftigte nach Wirtschaftszweigen im Kanton Basel-Stadt, 1929–1965",
                      column_description = c("Bezeichnung des Wirtschaftszweigs, für die die angegebenen Zahlen gelten",
                                             "Anzahl der im jeweiligen Wirtschaftszweig beschäftigten Personen im Kanton Basel-Stadt im Jahr 1929",
                                             "Anzahl der im jeweiligen Wirtschaftszweig beschäftigten Personen im Kanton Basel-Stadt im Jahr 1939",
                                             "Anzahl der im jeweiligen Wirtschaftszweig beschäftigten Personen im Kanton Basel-Stadt im Jahr 1955",
                                             "Anzahl der im jeweiligen Wirtschaftszweig beschäftigten Personen im Kanton Basel-Stadt im Jahr 1965"),
                      object_description = "Zehn Jahre sollte der Abstand zwischen den einzelnen Zählungen betragen, was die beiden Weltkriege jedoch verhinderten. Trotz beträchtlicher zeitlicher Abstände untersuchten die Statistiker die erhobenen Daten auf Kontinuitäten und Veränderungen. Bei der Zusammenstellung der vier Zählungen von 1965 fällt auf, dass 1939 – als Folge der Wirtschaftskrise der 1930er Jahre – die Zahl der Beschäftigten tiefer ist als 1929, obschon im selben Zeitraum der Kanton einen Bevölkerungszuwachs erfuhr. Von einer deutlichen Zunahme der Beschäftigten während der Hochkonjunktur hingegen zeugen die Daten von 1955 und 1965. Die Zahl der Beschäftigten in «Bergbau, Steinbrüche, Gruben» ist dermassen klein (zwischen 25 und 10), dass sie in der Grafik nicht erscheint.",
                      creator = list(list(name = "Isabel Koellreuter")),
                      contributor = list(list(name = "Nico Görlich",
                                              orcid = "0000-0003-3860-1488"),
                                         list(name = "Moritz Twente",
                                              email = "moritz.twente@unibas.ch",
                                              orcid = "0009-0005-7187-9774")),
                      date = "1929/1965",
                      temporal = list("20. Jahrhundert"),
                      source = "Quelle: Böhner, Martin: Die Eidgenössische Betriebszählung 1965 aus baslerischer Sicht, Basel 1968, S. 66f. Bearbeitung: Nico Görlich / Moritz Twente",
                      rights = "Public Domain Mark",
                      relation = list("m26060_1", "m26060_2")
)