# Packages -------------------

library(here)
library(readxl)
library(csvwr)
library(magrittr)
library(jsonlite)

# Functions ------------------

source(here("src", "Funktionen", "Metadata_JSON.R"))
source(here("src", "Funktionen", "Export_CSV.R"))

# Read Data ------------------

data90940 <- read_excel(here("data", "raw", "Band6", "90940", "90940_Data_raw.xlsx"),
                        sheet = 4,
                        range = "A38:R43")

# Process Data ---------------

colnames(data90940)[1] <- "Jahreseinkommen"

data90940$Jahreseinkommen[4] <- "6000–20 000"
data90940$Jahreseinkommen[5] <- ">20 000"

## Transpose table
data90940_transposed <- as.data.frame(t(data90940[,-1]),
                                      row.names = FALSE)
colnames(data90940_transposed) <- data90940[[1]]
data90940_transposed$Jahr <- colnames(data90940[,-1])

## Reorder columns to have Jahr first
data90940 <- data90940_transposed %>%
  relocate(Jahr)

colnames(data90940)[-1] <- paste(colnames(data90940)[-1], "Franken", sep = " ")

save_clean_csv(data90940, vol = 6)

# Create Metadata ------------

meta90940 <- annotate(data = data90940,
                      mediaID = 90940,
                      vol = 6,
                      title = "Soziale Klassen in Basel, 1888–1904",
                      column_description = c("Angabe des Jahres nach unserer Zeitrechnung, für das die entsprechenden Zahlen gelten",
                                             "Anzahl der Gemeindesteuerpflichtigen in der Gruppe der Haushalte mit jährlichem Haushaltseinkommen von 800-1500 Franken im entsprechenden Jahr",
                                             "Anzahl der Gemeindesteuerpflichtigen in der Gruppe der Haushalte mit jährlichem Haushaltseinkommen von 1500-3000 Franken im entsprechenden Jahr",
                                             "Anzahl der Gemeindesteuerpflichtigen in der Gruppe der Haushalte mit jährlichem Haushaltseinkommen von 3000-6000 Franken im entsprechenden Jahr",
                                             "Anzahl der Gemeindesteuerpflichtigen in der Gruppe der Haushalte mit jährlichem Haushaltseinkommen von 6000-20000 Franken im entsprechenden Jahr",
                                             "Anzahl der Gemeindesteuerpflichtigen in der Gruppe der Haushalte mit jährlichem Haushaltseinkommen von >20000 Franken im entsprechenden Jahr"
                                             ),
                      object_description = "Die Grafik beruht auf den Daten zur Gemeindesteuer. Diese erfasste Haushaltseinkommen ab 800 Franken pro Jahr, der Verdienst der Ehefrau und von minderjährigen Kindern wurde gemeinsam mit dem Einkommen des Mannes versteuert. Die Erhebung war also patriarchal zugeschnitten – und sie erbrachte das Bild einer Bevölkerung, die mehrheitlich am unteren Rand des Möglichen leben musste",
                      creator = list(list(name = "Oliver Kühschelm",
                                          orcid = "0000-0002-3091-5426")),
                      contributor = list(list(name = "Nico Görlich",
                                              orcid = "0000-0003-3860-1488"),
                                         list(name = "Moritz Twente",
                                              email = "moritz.twente@unibas.ch",
                                              orcid = "0009-0005-7187-9774")),
                      date = "1888/1904",
                      coverage = list("19. Jahrhundert", "20. Jahrhundert"),
                      source = "Quelle: Mangold 1905, Tab. XIX. Bearbeitung: Nico Görlich / Moritz Twente",
                      rights = "Public Domain Mark",
                      relation = list("m90940_1", "m90940_2")
)