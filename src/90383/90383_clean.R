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

data90383 <- read_excel(here("data", "raw", "Band6", "90383", "90383_Data_raw.xlsx"))

colnames(data90383)[1] <- "Stadtviertel"

colnames(data90383)[1] <- "Stadtviertel"

colnames(data90383) <- gsub(" ", "", colnames(data90383))

save_clean_csv(data90383, vol = 6)

# Create Metadata ------------

meta90383 <- annotate(data = data90383,
                      mediaID = 90383,
                      vol = 6,
                      title = "Erwerbstätige nach sozialen Klassen im St. Alban und Klybeck",
                      column_description = c("Stadtviertel, für die die Angaben zur Zusammensetzung nach sozialen Klassen gelten",
                                             "Anzahl der Zugehörigen zur Klasse 1 'Inhaber und Leiter von Grossbetrieben, hohe Beamte, Professoren, Geistliche, selbstständige Ärzte, Apotheker, Tierärzte, Anwälte, Ingenieure, Architekten, hervorragende Künstler, Grossrentner'.",
                                             "Anzahl der Zugehörigen zur Klasse 2 'Mittlere und kleine Selbstständige'.",
                                             "Anzahl der Zugehörigen zur Klasse 3 'Mittlere Beamte und Lehrer'.",
                                             "Anzahl der Zugehörigen zur Klasse 4 'Unterbeamte und gelernte Arbeiter'.",
                                             "Anzahl der Zugehörigen zur Klasse 5 'Ungelernte Arbeiter'.",
                                             "Anzahl der Zugehörigen zur Klasse 6 'Häusliche Dienstboten'."),
                      object_description = "Um die soziale Zusammensetzung der Wohnviertel zu bestimmen, teilte die Volkszählung von 1910 die Bevölkerung in «Erwerbstätige nach sozialen Klassen» ein. Während im Alban-Viertel die obersten drei sozialen Klassen mehr als ein Drittel ausmachten, waren es im Klybeck knapp ein Fünftel, dafür ungleich mehr gelernte und ungelernte Arbeiter. Obschon die Dienstboten im Alban-Viertel die Anzahl hoher Beamter und Leiter von Grossbetrieben deutlich übertrafen, wurden sie für die Charakterisierung der Stadtteile nicht miteinbezogen: Für die Prägung eines Stadtteils waren sie in den Augen der Statistiker keine relevante Grösse",
                      creator = list(list(name = "Franziska Schürch"),
                                     list(name = "Isabel Koellreuter")),
                      contributor = list(list(name = "Nico Görlich",
                                              orcid = "0000-0003-3860-1488"),
                                         list(name = "Moritz Twente",
                                              email = "moritz.twente@unibas.ch",
                                              orcid = "0009-0005-7187-9774")),
                      date = "1910",
                      temporal = "20. Jahrhundert",
                      source = "Quelle: Jenny, Oskar Hugo: Die Bevölkerung des Kantons Basel-Stadt. Am 1. Dezember 1910, Basel 1924 (Mitteilungen des Statistischen Amtes des Kantons Basel-Stadt Nr. 28, Ed. 1924), S. 156f. Bearbeitung: Nico Görlich / Moritz Twente",
                      rights = "Public Domain Mark",
                      relation = list("m90383_1", "m90383_2")
)