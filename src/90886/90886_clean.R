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

data90886 <- read_excel(here("data", "raw", "Band6", "90886", "90886_Data_raw.xlsx"),
                        sheet = 1,
                        range = "B1:D11")

colnames(data90886)[1] <- "Branche"

data90886 <- data90886[c("Branche", "1870", "1910")]

data90886$Branche[10] <- "Persönliche Dienste/Dienstboten"

save_clean_csv(data90886, vol = 6)

# Create Metadata ------------

meta90886 <- annotate(data = data90886,
                      mediaID = 90886,
                      vol = 6,
                      title = "Anteil der Erwerbstätigen in wichtigen Branchen, 1870 und 1910",
                      column_description = c("Bezeichnung der Branche, für die die jeweiligen Zahlen zum Anteil der dort beschäftigten im jeweiligen Jahr gilt",
                                             "Anteil der jeweiligen Branche an der Gesamtsumme der in den genannten Branchen Erwerbstätigen im Jahr 1870, Angabe in Prozent",
                                             "Anteil der jeweiligen Branche an der Gesamtsumme der in den genannten Branchen Erwerbstätigen im Jahr 1910, Angabe in Prozent"),
                      object_description = "Im Vergleich der Jahre 1870 und 1910 zeichnen sich Veränderungen ab: Die Beschäftigten in der Landwirtschaft gehen auf unter 2 Prozent zurück. Das Baugewerbe löst die Textilindustrie als wichtigster gewerblicher Arbeitgeber ab. Der Anteil des Handels steigt auf 20 Prozent, jener von Dienstbotinnen und Dienstboten sinkt deutlich.",
                      creator = list(list(name = "Oliver Kühschelm",
                                          orcid = "0000-0002-3091-5426")),
                      contributor = list(list(name = "Nico Görlich",
                                              orcid = "0000-0003-3860-1488"),
                                         list(name = "Moritz Twente",
                                              email = "moritz.twente@unibas.ch",
                                              orcid = "0009-0005-7187-9774")),
                      date = "[1870, 1910]",
                      coverage = list("19. Jahrhundert", "20. Jahrhundert"),
                      source = "Quelle: Polivka, Heinz: Basel und seine Wirtschaft. Eine Zeitreise durch 2000 Jahre, Lenzburg 2016, S. 206. Bearbeitung: Nico Görlich / Moritz Twente",
                      rights = "Public Domain Mark",
                      relation = list("m90886_1", "m90886_2")
)