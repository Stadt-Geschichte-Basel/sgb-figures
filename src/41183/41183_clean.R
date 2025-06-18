# Packages -------------------

library(here)
library(readxl)
library(magrittr)
library(csvwr)
library(jsonlite)

# Functions ------------------

source(here("src", "Funktionen", "Metadata_JSON.R"))
source(here("src", "Funktionen", "Export_CSV.R"))

# Process Data --------

data41183 <- read_excel(here("data", "raw", "Band3", "41183", "41183_Data_raw.xlsx"),
                        col_names = c("Jahr",
                                      "ß", "d", "Preis in d",
                                      "Basel: in d", "Basel: in g Ag", "Basel: Roggen (hl in fl)",
                                      "Strasbourg: in d", "Strasbourg: Roggen (hl in fl)","Strasbourg: in g Ag (1)", "Strasbourg: in g Ag (2)", "Weizen V in d", "Strasbourg: Weizen (hl in fl)",
                                      "Nürnberg: Sümmer in d", "Nürnberg: hl in d", "Nürnberg: Sümmer in fl", "Nürnberg: Roggen (hl in fl)",
                                      "Köln: hl in g Ag", "Köln: Malter in Mk", "Köln: hl in Allbus", "Köln: Roggen oder Weizen (hl in fl)"),
                        range = "A7:U64")

save_clean_csv(data41183, vol = 3)

# Create Metadata -------

meta41183 <- annotate(data = data41183,
                      mediaID = 41183,
                      vol = 3,
                      title = "Getreidepreise in Basel, Strassburg, Nürnberg und Köln, 1443–1500",
                      column_description = c("Jahreszahl, Angabe in Jahren unserer Zeitrechnung", "ß", "d (Pfennig)", "Preis in d (Pfennig)", "Basel: in d", "Basel: in g Ag. Umrechnung nach Schulz 320.", "Basel: Roggen (hl in fl)", "Strasbourg: in d", "Strasbourg: Roggen (hl in fl)", "Strasbourg: in g Ag (1)", "Strasbourg: in g Ag (2)", "Weizen V in d", "Strasbourg: Weizen (hl in fl)", "Nürnberg: Sümmer in d", "Nürnberg: hl in d", "Nürnberg: Sümmer in fl", "Nürnberg: Roggen (hl in fl)", "Köln: hl in g Ag", "Köln: Malter in Mk", "Köln: hl in Allbus", "Köln: Roggen oder Weizen (hl in fl)"),
                      object_description = c("Zu den Jahren 1481/82 hielt der in Basel tätige Jurist Johannes Ursi fest, alles – ausser Fisch – sei teuer geworden. Viele seien an Hunger gestorben (BChr, Bd. 7, S. 179). Grund waren Missernten in den Jahren 1478 bis 1482. Ursis Angaben konnten in einer Untersuchung zu den Preisen für Korn in verschiedenen Städten bestätigt werden. Die in der Grafik ersichtlichen Durchschnittspreise korrelierten in Basel und Strassburg besonders eng. Dabei spielten verschiedene Ursachen zusammen: ähnliche Ertragsgebiete, intensiver Handel und rascher Austausch von Preisnachrichten (Holzwart-Schäfer 2000)."),
                      creator = list(list(name = "Benjamin Hitz",
                                          orcid = "0000-0002-3208-4881")),
                      contributor = list(list(name = "Nico Görlich",
                                              orcid = "0000-0003-3860-1488"),
                                         list(name = "Moritz Twente",
                                              email = "moritz.twente@unibas.ch",
                                              orcid = "0009-0005-7187-9774")),
                      date = "1443/1500",
                      temporal = "Mittelalter",
                      source = "Simon-Muscheid, Katharina: Gewalt und Ehre im spätmittelalterlichen Handwerk am Beispiel Basels, in: Zeitschrift für historische Forschung 18, 1991, S. 1–31, hier S. 30 f. Bearbeitung: Nico Görlich / Moritz Twente",
                      relation = list("m41183_1", "m41183_2"),
                      rights = "CC BY-SA. Daten: Katharina Simon-Muscheid. Bearbeitung: Nico Görlich / Moritz Twente"
)