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

data39050d <- read_excel(here("data", "raw", "Band3", "39050", "39050_Data_raw.xlsx"),
                         sheet = 3,
                         col_names = TRUE,
                         range = "A1:D61")

save_clean_csv(data39050d, vol = 3)

# Create Metadata -------

meta39050d <- annotate(data = data39050d,
                       mediaID = "39050d",
                       vol = 3,
                       title = "Einnahmen der Stadt Basel: Ungelder und Zölle ab 1424",
                       column_description = c("Rechnungsjahr, Angabe als Jahreszahl in Jahren unserer Zeitrechnung", "Laufende Einnahmen der Stadt Basel im jeweiligen Zeitraum: Steuereinnahmen in Basler Pfund", "Laufende Einnahmen der Stadt Basel im jeweiligen Zeitraum: Leibrenten in Basler Pfund", "Laufende Einnahmen der Stadt Basel im jeweiligen Zeitraum: verkäufliche Renten in Basler Pfund"),
                       object_description = c("Die Einnahmen sind jeweils getrennt dargestellt nach ausserordentlichen Einnahmen (direkte Steuern und Anleihen; letztere aufgeschlüsselt nach an den Gläubiger gebundene Leibrenten und verkäufliche Renten) und laufenden Einnahmen (indirekte Steuern und Zölle). Alle Einnahmen in Basler Pfund."),
                       creator = list(list(name = "Benjamin Hitz",
                                           orcid = "0000-0002-3208-4881")),
                       contributor = list(list(name = "Nico Görlich",
                                               orcid = "0000-0003-3860-1488"),
                                          list(name = "Moritz Twente",
                                               email = "moritz.twente@unibas.ch",
                                               orcid = "0009-0005-7187-9774")),
                       date = "1424/1484",
                       temporal = "Frühe Neuzeit",
                       source = "Harms, Bernhard: Die Münz- und Geldpolitik der Stadt Basel im Mittelalter, Tübingen 1907, S. 640–672. Bearbeitung: Nico Görlich / Moritz Twente",
                       rights = "CC BY-SA. Daten: Harms 1907. Bearbeitung: Nico Görlich / Moritz Twente",
                       relation = list("m39050a_1", "m39050a_2", "m39050b_1", "m39050b_2", "m39050c_1", "m39050c_2", "m39050d_1", "m39050d_2")
                       )