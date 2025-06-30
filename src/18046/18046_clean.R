# Packages -------------------

library(here)
library(readxl)
library(magrittr)
library(csvwr)
library(jsonlite)

# Functions ------------------

source(here("src", "Funktionen", "Metadata_JSON.R"))
source(here("src", "Funktionen", "Export_CSV.R"))

# Process Data ---------------

data18046 <- read_excel(here("data", "raw", "Band4", "18046", "18046_Data_raw.xlsx"),
                        col_names = TRUE)

colnames(data18046) = c("Jahr", "Dinkel (in Viernzeln)", "Roggen (in Säcken)", "Hafer (in Viernzeln)")

data18046[, 1] <- seq(1613, 1652, 1)

# Umrechnung von Roggen (in Säcken) auch in Viernzeln
data18046$`Roggen (in Säcken)` <- data18046$`Roggen (in Säcken)` / 2

colnames(data18046) <- c("Jahr", "Dinkel (in Viernzeln)", "Roggen (in Viernzeln)", "Hafer (in Viernzeln)")

save_clean_csv(data18046, vol = 4)

# Create Metadata ------------

meta18046 <- annotate(data = data18046,
                      mediaID = 18046,
                      vol = 4,
                      title = "Getreidevorräte in der Stadt Basel, 1613–1653",
                      column_description = c("Jahreszahl, Angabe in Jahren unserer Zeitrechnung", "Vorrat an Dinkel, Angabe in Viernzeln", "Vorrat an Roggen, Angabe in Viernzeln", "Vorrat an Hafer, Angabe in Viernzeln"),
                      object_description = "Dinkel und – in geringerem Masse – Roggen zum Backen von Brot sowie Hafer als Futter für die Pferde waren für die Versorgung der Stadt und ihrer Bewohnerinnen und Bewohner essenziell. Um Engpässe ausgleichen zu können, legte die Obrigkeit in ertragreichen Jahren Getreidevorräte an, die sie in Krisenzeiten vergünstigt an die Bevölkerung abgab. 1621 etwa – im vierten Jahr des Dreissigjährigen Kriegs – versorgte die Stadt auf diese Weise zahlreiche Flüchtlinge.",
                      creator = list(list(name = "Daniel Sidler"),
                                     list(name = "Marcus Sandl")),
                      contributor = list(list(name = "Nico Görlich",
                                              orcid = "0000-0003-3860-1488"),
                                         list(name = "Moritz Twente",
                                              email = "moritz.twente@unibas.ch",
                                              orcid = "0009-0005-7187-9774")),
                      date = "1613/1653",
                      temporal = "Neuzeit",
                      source = "Stritmatter, Robert: Die Stadt Basel während des Dreissigjährigen Krieges. Politik, Wirtschaft, Finanzen, Basel; Frankfurt a. M.; Las Vegas 1977, S. 115. Bearbeitung: Nico Görlich / Moritz Twente",
                      rights = "Public Domain Mark",
                      relation = list("m18046_1", "m18046_2")
)