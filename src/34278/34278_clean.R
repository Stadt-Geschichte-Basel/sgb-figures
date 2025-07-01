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

data34278 <- data.frame(Feldtyp = c("Brachfeld", "Winterfeld", "Sommerfeld"),
                        Januar = c("Brache/Weide", "Winterfrucht", "Brache/Weide"),
                        Januar15 = c("Brache/Weide", "Winterfrucht", "Brache/Weide"),
                        Februar = c("Brache/Weide", "Winterfrucht", "Brache/Weide"),
                        Februar15 = c("Brache/Weide", "Winterfrucht", "Brache/Weide"),
                        März = c("Brache/Weide", "Winterfrucht", "Brache/Weide"),
                        März15 = c("Brache/Weide", "Winterfrucht", "Brache/Weide"),
                        April = c("Brache/Weide", "Winterfrucht", "Pflugarbeiten"),
                        April15 = c("Brache/Weide", "Winterfrucht", "Pflugarbeiten"),
                        Mai = c("Brache/Weide", "Winterfrucht", "Sommerfrucht"),
                        Mai15 = c("Brache/Weide", "Winterfrucht", "Sommerfrucht"),
                        Juni = c("Pflugarbeiten", "Winterfrucht", "Sommerfrucht"),
                        Juni15 = c("Pflugarbeiten", "Winterfrucht", "Sommerfrucht"),
                        Juli = c("Brache/Weide", "Winterfrucht", "Sommerfrucht"),
                        Juli15 = c("Brache/Weide", "Winterfrucht", "Sommerfrucht"),
                        August = c("Brache/Weide", "Brache/Weide", "Sommerfrucht"),
                        August15 = c("Brache/Weide", "Brache/Weide", "Brache/Weide"),
                        September = c("Pflugarbeiten", "Brache/Weide", "Brache/Weide"),
                        September15 = c("Pflugarbeiten", "Brache/Weide", "Brache/Weide"),
                        Oktober = c("Winterfrucht", "Brache/Weide", "Brache/Weide"),
                        Oktober15 = c("Winterfrucht", "Brache/Weide", "Brache/Weide"),
                        November = c("Winterfrucht", "Brache/Weide", "Brache/Weide"),
                        November15 = c("Winterfrucht", "Brache/Weide", "Brache/Weide"),
                        Dezember = c("Winterfrucht", "Brache/Weide", "Brache/Weide"),
                        Dezember15 = c("Winterfrucht", "Brache/Weide", "Brache/Weide")
)

save_clean_csv(data34278, vol = 2)

# Create Metadata ------------

meta34278 <- annotate(data = data34278,
                      mediaID = 34278,
                      vol = 2,
                      title = "Schema der Dreifelderwirtschaft",
                      column_description = c("Typ des bewirtschafteten Feldes",
                                             "Zustand des jeweiligen Feldes in der ersten Hälfte des ersten Monats",
                                             "Zustand des jeweiligen Feldes in der zweiten Hälfte des ersten Monats",
                                             "Zustand des jeweiligen Feldes in der ersten Hälfte des zweiten Monats",
                                             "Zustand des jeweiligen Feldes in der zweiten Hälfte des zweiten Monats",
                                             "Zustand des jeweiligen Feldes in der ersten Hälfte des dritten Monats",
                                             "Zustand des jeweiligen Feldes in der zweiten Hälfte des dritten Monats",
                                             "Zustand des jeweiligen Feldes in der ersten Hälfte des vierten Monats",
                                             "Zustand des jeweiligen Feldes in der zweiten Hälfte des vierten Monats",
                                             "Zustand des jeweiligen Feldes in der ersten Hälfte des fünften Monats",
                                             "Zustand des jeweiligen Feldes in der zweiten Hälfte des fünften Monats",
                                             "Zustand des jeweiligen Feldes in der ersten Hälfte des sechsten Monats",
                                             "Zustand des jeweiligen Feldes in der zweiten Hälfte des sechsten Monats",
                                             "Zustand des jeweiligen Feldes in der ersten Hälfte des siebten Monats",
                                             "Zustand des jeweiligen Feldes in der zweiten Hälfte des siebten Monats",
                                             "Zustand des jeweiligen Feldes in der ersten Hälfte des achten Monats",
                                             "Zustand des jeweiligen Feldes in der zweiten Hälfte des achten Monats",
                                             "Zustand des jeweiligen Feldes in der ersten Hälfte des neunten Monats",
                                             "Zustand des jeweiligen Feldes in der zweiten Hälfte des neunten Monats",
                                             "Zustand des jeweiligen Feldes in der ersten Hälfte des zehnten Monats",
                                             "Zustand des jeweiligen Feldes in der zweiten Hälfte des zehnten Monats",
                                             "Zustand des jeweiligen Feldes in der ersten Hälfte des elften Monats",
                                             "Zustand des jeweiligen Feldes in der zweiten Hälfte des elften Monats",
                                             "Zustand des jeweiligen Feldes in der ersten Hälfte des zwölften Monats",
                                             "Zustand des jeweiligen Feldes in der zweiten Hälfte des zwölften Monats"),
                      object_description = "Die zeitlich verschobene Bewirtschaftung der drei Felder benötigte einen grossen organisatorischen Aufwand und verbindliche Absprachen innerhalb der Dorfgemeinschaft.",
                      creator = list(list(name = "Claudius Sieber-Lehmann"),
                                     list(name = "Peter-Andrew Schwarz")),
                      contributor = list(list(name = "Nico Görlich",
                                              orcid = "0000-0003-3860-1488"),
                                         list(name = "Moritz Twente",
                                              email = "moritz.twente@unibas.ch",
                                              orcid = "0009-0005-7187-9774")),
                      date = "1000~",
                      temporal = "Mittelalter",
                      source = "Abel, Wilhelm: Geschichte der deutschen Landwirtschaft vom frühen Mittelalter bis zum 19. Jahrhundert (Deutsche Agrargeschichte), Stuttgart 1978. Bearbeitung: Nico Görlich / Moritz Twente",
                      rights = "Public Domain Mark",
                      relation = list("m34278_1", "m34278_2")
)