# Packages -------------------

library(here)
library(readxl)
library(csvwr)
library(jsonlite)
library(magrittr)

# Functions ------------------

source(here("src", "Funktionen", "Metadata_JSON.R"))
source(here("src", "Funktionen", "Export_CSV.R"))

# Process Data ---------------

data15429 <- read_excel(here("data", "raw", "Band7", "15429", "15429_Data_raw.xlsx"),
                        sheet = 1,
                        range = "A11:G18")

colnames(data15429) <- c("Jahr", "Protestant:innen (Ausland)", "Protestant:innen (Inland)", "Katholik:innen inkl. Christkatholik:innen (Ausland)", "Katholik:innen inkl. Christkatholik:innen (Inland)", "Jüd:innen (Inland und Ausland)", "Andere, ohne Religionszugehörigkeit und ohne Angabe (Inland und Ausland)")

save_clean_csv(data15429, vol = 7)

# Create Metadata ------------

meta15429 <- annotate(data = data15429,
                      mediaID = 15429,
                      vol = 7,
                      title = "Wohnbevölkerung im Kanton Basel-Stadt nach Religionszugehörigkeit und Herkunft, 1910–1970",
                      column_description = c("Jahreszahl im 20. Jahrhundert nach unserer Zeitrechnung",
                                             "Anzahl der aus dem Ausland stammenden Protestant:innen im Kanton Basel-Stadt im angegebenen Jahr",
                                             "Anzahl der aus dem Inland stammenden Protestant:innen im Kanton Basel-Stadt im angegebenen Jahr",
                                             "Anzahl der aus dem Ausland stammenden Katholik:innen inkl. Christkatholik:innen im Kanton Basel-Stadt im angegebenen Jahr",
                                             "Anzahl der aus dem Inland stammenden Katholik:innen inkl. Christkatholik:innen im Kanton Basel-Stadt im angegebenen Jahr",
                                             "Anzahl der aus dem In- und Ausland stammenden Jüd:innen im Kanton Basel-Stadt im angegebenen Jahr",
                                             "Anzahl der aus dem In- und Ausland stammenden Menschen mit anderer Religionszugehörigkeit, ohne Religionszugehörigkeit oder mit fehlender Angabe im Kanton Basel-Stadt im angegebenen Jahr"),
                      object_description = "Der Anteil der Katholiken und Katholikinnen stieg zwischen 1910 und 1970 von 33 auf 40 Prozent der basel-städtischen Wohnbevölkerung. Bis zum Zweiten Weltkrieg und dann ab 1960 wieder stammten relativ viele von ihnen aus dem Ausland. Der Anteil der Juden und Jüdinnen an der Wohnbevölkerung betrug 1910 knapp zwei, 1970 knapp ein Prozent. Diese Abnahme wird mit der Abwanderung nach 1945 vor allem nach Israel in Zusammenhang gebracht (Erlanger 2005, S. 220–221). Mit zwei bis drei Prozent war der Anteil der als konfessionslos oder als einer anderen Konfession zugehörig registrierten Personen bis in die 1960er-Jahre noch klein. Ihr Anteil stieg bis 1970 auf fünf Prozent und sollte im letzten Drittel des Jahrhunderts markant zu Buche schlagen. Die Kategorien «Inland» und «Ausland» entstammen der Quelle",
                      creator = list(list(name = "Céline Angehrn")),
                      contributor = list(list(name = "Nico Görlich",
                                              orcid = "0000-0003-3860-1488"),
                                    list(name = "Moritz Twente",
                                         email = "moritz.twente@unibas.ch",
                                         orcid = "0009-0005-7187-9774")),
                      date = "1910/1970",
                      temporal = "Zeitgeschichte",
                      source = "Quelle: Statistisches Jahrbuch des Kantons Basel-Stadt 1971 (Volkszählungen). Bearbeitung: Nico Görlich / Moritz Twente",
                      rights = "Public Domain Mark",
                      relation = list("m15429_1", "m15429_2")
                      )