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

data90894 <- read_excel(here("data", "raw", "Band6", "90894", "90894_Data_raw.xlsx"),
                        sheet = 3,
                        range = "A1:D13")

colnames(data90894)[1] <- "Zielland"

save_clean_csv(data90894, vol = 6)

# Create Metadata ------------

meta90894 <- annotate(data = data90894,
                      mediaID = 90894,
                      vol = 6,
                      title = "Exporte in die wichtigsten Zielländer, 1900",
                      column_description = c("Bezeichnung des Staates, in das exportiert wird",
                                             "Export von Seidenband in das entsprechende Zielland. Angaben in Millionen Franken",
                                             "Export von Schappe in das entsprechende Zielland. Angaben in Millionen Franken",
                                             "Export von Teerfarben in das entsprechende Zielland. Angaben in Millionen Franken"),
                      object_description = "Die Seidenbandindustrie exportierte im Jahr 1900 Waren im Wert von 31 Millionen Franken. Rund 87 Prozent gingen in die drei wichtigsten Zielländer, so wie auch im Fall des aus Seidenabfällen hergestellten Schappegarns. Die Exporte der Farbenindustrie verweisen bereits auf den Aufstieg der chemischen Industrie. Sie betrugen zwar mit 15 Millionen Franken weniger als die Hälfte des mit Seidenbändern erzielten Exports. Dafür streuten sich die Abnehmerländer breiter. Nur 55 Prozent gingen in die drei wichtigsten Märkte.",
                      creator = list(list(name = "Oliver Kühschelm",
                                          orcid = "0000-0002-3091-5426")),
                      contributor = list(list(name = "Nico Görlich",
                                              orcid = "0000-0003-3860-1488"),
                                         list(name = "Moritz Twente",
                                              email = "moritz.twente@unibas.ch",
                                              orcid = "0009-0005-7187-9774")),
                      date = "1900",
                      coverage = "19. Jahrhundert",
                      source = "Quelle: Jahresbericht Basler Handelskammer 1901, S. 10. Bearbeitung: Nico Görlich / Moritz Twente",
                      rights = "Public Domain Mark",
                      relation = list("m90894_1", "m90894_2")
)