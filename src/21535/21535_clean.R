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

data21535 <- read_excel(here("data", "raw", "Band7", "21535", "21535_Data_raw.xlsx"),
                        sheet = 1,
                        range = "A20:E30")

colnames(data21535)[1] <- "Jahr"

save_clean_csv(data21535, vol = 7)

# Create Metadata ------------

meta21535 <- annotate(data = data21535,
                      mediaID = 21535,
                      vol = 7,
                      title = "Die ausländische Wohnbevölkerung von Basel-Stadt nach Heimatnation, 1920–1965",
                      column_description = c("Jahreszahl im 20. Jahrhundert nach unserer Zeitrechnung",
                                             "Anteil der deutschen Staatsangehörigen an der in Basel wohnhaften ausländischen Bevölkerung in Prozent im angegebenen Jahr",
                                             "Anteil der französischen Staatsangehörigen an der in Basel wohnhaften ausländischen Bevölkerung in Prozent im angegebenen Jahr",
                                             "Anteil der italienischen Staatsangehörigen an der in Basel wohnhaften ausländischen Bevölkerung in Prozent im angegebenen Jahr",
                                             "Anteil der Staatsangehörigen übriger Staaten an der in Basel wohnhaften ausländischen Bevölkerung in Prozent im angegebenen Jahr"),
                      object_description = "Der Anteil der deutschen Staatsangehörigen an der in Basel wohnhaften ausländischen Bevölkerung nahm kontinuierlich ab, jener der italienischen insbesondere in den 1960er-Jahren deutlich zu. Da die Volkszählungen im Dezember stattfanden, waren die ‹Saisonniers›, die sich maximal neun Monate am Stück im Land aufhalten durften, meist nicht eingerechnet. Mit ihnen war die Zahl der italienischen Staatsangehörigen vor allem in den Sommermonaten noch weitaus höher. Ab 1964 fanden die Spanierinnen und Spanier, deren Zahl ab Mitte der 1960er-Jahren deutlich anstieg, separat Eingang ins Statistische Jahrbuch. Vorher wurden sie zur Kategorie ‹Übriges Ausland› gerechnet",
                      creator = list(list(name = "Noëmi Crain Merz")),
                      contributor = list(list(name = "Nico Görlich",
                                              orcid = "0000-0003-3860-1488"),
                                    list(name = "Moritz Twente",
                                         email = "moritz.twente@unibas.ch",
                                         orcid = "0009-0005-7187-9774")),
                      date = "1920/1965",
                      coverage = "Zeitgeschichte",
                      source = "Quelle: Statistisches Jahrbuch des Kantons Basel-Stadt 1966, S. 32. Bearbeitung: Nico Görlich / Moritz Twente",
                      rights = "Public Domain Mark",
                      relation = list("m21535_1", "m21535_2")
                      )