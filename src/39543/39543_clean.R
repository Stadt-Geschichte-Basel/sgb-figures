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

data39543 <- read_excel(here("data", "raw", "Band3", "39543", "39543_Data_raw.xlsx"),
                        col_names = c("Startjahr", "Endjahr", "Zeitraum", "Wundtat", "Totschlag", "«Geloiff» (Tumult)", "Ehrverletzung", "Jugenddelikt", "Ungehorsam", "Eigentum", "Sexualdelikt", "Meineid", "Gotteslästerung"),
                        range = "A2:M9")

col_order <- c("Startjahr", "Endjahr", "Zeitraum",
               "Gotteslästerung",
               "Ehrverletzung",
               "Meineid",
               "Ungehorsam",
               "Jugenddelikt",
               "Eigentum",
               "Sexualdelikt",
               "«Geloiff» (Tumult)",
               "Totschlag",
               "Wundtat")

data39543 <- data39543[,col_order]

save_clean_csv(data39543, vol = 3)

# Create Metadata ------------

meta39543 <- annotate(data = data39543,
                      mediaID = 39543,
                      vol = 3,
                      title = "Verbannungsurteile, 1376–1455",
                      column_description = c("Jahreszahl, Angabe in Jahren unserer Zeitrechnung", "Jahreszahl, Angabe in Jahren unserer Zeitrechnung", "Zeitraum, Angabe von Start- und Endjahr als Jahreszahl unserer Zeitrechnung", "Anzahl der Verbannungsurteile wegen Gotteslästerung im angegebenen Zeitraum", "Anzahl der Verbannungsurteile wegen Ehrverletzung im angegebenen Zeitraum", "Anzahl der Verbannungsurteile wegen Meineid im angegebenen Zeitraum", "Anzahl der Verbannungsurteile wegen Ungehorsam im angegebenen Zeitraum", "Anzahl der Verbannungsurteile wegen Jugenddelikten im angegebenen Zeitraum", "Anzahl der Verbannungsurteile wegen Eigentumsdelikten im angegebenen Zeitraum", "Anzahl der Verbannungsurteile wegen Sexualdelikten im angegebenen Zeitraum", "Anzahl der Verbannungsurteile wegen Geloiff (Tumult) im angegebenen Zeitraum", "Anzahl der Verbannungsurteile wegen Totschlag im angegebenen Zeitraum", "Anzahl der Verbannungsurteile wegen Wundtaten im angegebenen Zeitraum"),
                      object_description = c("Die weitaus umfangreichste Urteilskategorie bildeten über den ganzen Zeitraum die Wundtaten, auch Totschläge waren häufig. Demzufolge waren mehr als die Hälfte aller Verbannungen auf Gewalttaten zurückzuführen, obwohl diese im Gegensatz etwa zu Eigentumsdelikten nicht ehrrührig waren (Hagemann 1981, Bd. 1, S. 155f.; Wackernagel 1907-1924, Bd. 2.1, S. 345; Rippmann; Simon-Murscheid 1991, S. 24). Der Frauenanteil unter den Verbannten stieg im Verlauf der untersuchten Zeit tendenziell an, wobei die Täterinnen von Sexualdelikten in der zweiten Hälfte die Täterinnen von Eigentumsdelikten als die grösste Gruppe ablösten (Datengrundlage: Simon-Muscheid 1991, S. 30f.)"),
                      creator = list(list(name = "Benjamin Hitz",
                                          orcid = "0000-0002-3208-4881")),
                      contributor = list(list(name = "Nico Görlich",
                                              orcid = "0000-0003-3860-1488"),
                                         list(name = "Moritz Twente",
                                              email = "moritz.twente@unibas.ch",
                                              orcid = "0009-0005-7187-9774")),
                      date = "1376/1455",
                      temporal = "Frühe Neuzeit",
                      source = "Simon-Muscheid, Katharina: Gewalt und Ehre im spätmittelalterlichen Handwerk am Beispiel Basels, in: Zeitschrift für historische Forschung 18, 1991, S. 1–31, hier S. 30 f. Bearbeitung: Nico Görlich / Moritz Twente",
                      rights = "Public Domain Mark",
                      relation = list("m39543_1", "m39543_2")
)