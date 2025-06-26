# Packages -------------------

library(here)
library(readxl)
library(csvwr)
library(magrittr)
library(jsonlite)

# Functions ------------------

source(here("src", "Funktionen", "Metadata_JSON.R"))
source(here("src", "Funktionen", "Export_CSV.R"))

# Read Data --------

data90340 <- read_excel(here("data", "raw", "Band6", "90340", "90340_Data_raw.xlsx"),
                        range = "A6:G9")

# Process Data --------

data90340 <- data90340[-1,-2]
colnames(data90340)[1] <- "Stadtteil"

data90340 <- data90340 %>%
  pivot_longer(
    cols = -Stadtteil,
    names_to = "Zeitraum",
    values_to = "Wachstum"
  ) %>%
  pivot_wider(
    names_from = Stadtteil,
    values_from = Wachstum
  )

save_clean_csv(data90340, vol = 6)

# Create Metadata -------

meta88415 <- annotate(data = data90340,
                      mediaID = 90340,
                      vol = 6,
                      title = "Prozentuales Bevölkerungswachstum in Gross- und Kleinbasel, 1860–1910",
                      column_description = c("Zeitraum, für den die angegebenen Zahlen gelten. Angabe in Jahren unserer Zeitrechnung.",
                                             "Zunahme der Bevölkerungszahl im Grossbasel im angegebenen Zeitraum, Angaben in Prozent",
                                             "Zunahme der Bevölkerungszahl im Kleinbasel im angegebenen Zeitraum, Angaben in Prozent"),
                      object_description = "Innerhalb eines halben Jahrhunderts wuchs die Bevölkerung der Stadt von 37 915 um beinahe 100 000 Einwohnerinnen und Einwohner. Während sich in Grossbasel die Bevölkerung verdreifachte, entsprach die Zunahme im Kleinbasel von 10 283 auf 48 455 Einwohnerinnen und Einwohner nahezu einer Verfünffachung. Die Einwohner:innen Kleinhüningens werden ab 1900 dem Kleinbasel zugerechnet",
                      creator = list(list(name = "Franziska Schürch"),
                                     list(name = "Isabel Koellreuter")),
                      contributor = list(list(name = "Nico Görlich",
                                              orcid = "0000-0003-3860-1488"),
                                         list(name = "Moritz Twente",
                                              email = "moritz.twente@unibas.ch",
                                              orcid = "0009-0005-7187-9774")),
                      date = "1860/1910",
                      temporal = list("19. Jahrhundert", "20. Jahrhundert"),
                      source = "Quelle: Bauer, Stephan: Die Bevölkerung des Kantons Basel-Stadt, Basel 1905; Jenny, Oskar Hugo: Die Bevölkerung des Kantons Basel-Stadt. Am 1. Dezember 1910, Basel 1924 (Mitteilungen des Statistischen Amtes des Kantons Basel-Stadt Nr. 28, Ed. 1924)., Tabelle I, 3*–5*. Bearbeitung: Nico Görlich / Moritz Twente",
                      rights = "Public Domain Mark",
                      relation = list("m90340_1", "m90340_2")
)
