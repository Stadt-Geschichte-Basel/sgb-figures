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

data21912 <- read_excel(here("data", "raw", "Band7", "21912", "21912_Data_raw.xlsx"),
                        range = "F35:G42",
                        col_names = TRUE)

data21912 <- data21912[-1,]

colnames(data21912) <- c("Jahr",
                         "Staatsausgaben pro Einwohner:in in CHF")

save_clean_csv(data21912, vol = 7)

# Create Metadata ------------

meta21912 <- annotate(data = data21912,
                      mediaID = 21912,
                      vol = 7,
                      title = "Kantonale Staatsausgaben pro Einwohner in CHF, 1920–1966",
                      column_description = c("Jahreszahl, Angabe in Jahren unserer Zeitrechnung", "Höhe der Staatsausgaben des Kantons Basel-Stadt in Schweizer Franken pro Einwohner:in im angegebenen Jahr"),
                      object_description = "Die Zahl der Staatsangestellten und die Staatsausgaben wuchsen zwischen 1912 und 1966 deutlich überproportional im Verhältnis zur Einwohnerschaft.",
                      creator = list(list(name = "Noëmi Crain Merz")),
                      contributor = list(list(name = "Nico Görlich",
                                              orcid = "0000-0003-3860-1488"),
                                         list(name = "Moritz Twente",
                                              email = "moritz.twente@unibas.ch",
                                              orcid = "0009-0005-7187-9774")),
                      date = "1920/1966",
                      temporal = "Zeitgeschichte",
                      source = "Quelle: Statistisches Jahrbuch des Kantons Basel-Stadt, diverse Jahrgänge. Bearbeitung: Nico Görlich / Moritz Twente",
                      rights = "Public Domain Mark",
                      relation = list("m21912_1", "m21912_2", "m21892_1", "m21892_2", "m21892_3")
)