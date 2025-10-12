# Packages -------------------

library(here)
library(readxl)
library(magrittr)
library(csvwr)
library(jsonlite)

# Functions ------------------

source(here("src", "Utils", "Metadata_JSON.R"))
source(here("src", "Utils", "Export_CSV.R"))

# Process Data ---------------

data39050d <- read_excel(here("data", "raw", "Band3", "39050", "39050_Data_raw.xlsx"),
  sheet = 3,
  col_names = TRUE,
  range = "A1:D61"
)

save_clean_csv(data39050d, csv_suffix = 9, vol = 3)

# Create Metadata ------------

meta39050d <- annotate(
  data = data39050d,
  media_id = 39050,
  csv_suffix = 9,
  vol = 3,
  title = "Einnahmen der Stadt Basel ab 1424",
  column_description = c("Rechnungsjahr, Angabe als Jahreszahl in Jahren unserer Zeitrechnung", "Laufende Einnahmen der Stadt Basel im jeweiligen Zeitraum: Steuereinnahmen in Basler Pfund", "Laufende Einnahmen der Stadt Basel im jeweiligen Zeitraum: Leibrenten in Basler Pfund", "Laufende Einnahmen der Stadt Basel im jeweiligen Zeitraum: verkäufliche Renten in Basler Pfund"),
  column_datatype = c("{'base': 'string', 'format': 'yyyy/yy|yyyy-yyyy'}", "integer", rep("float", 2)),
  object_description = c("Die Einnahmen sind jeweils getrennt dargestellt nach ausserordentlichen Einnahmen (direkte Steuern und Anleihen; letztere aufgeschlüsselt nach an den Gläubiger gebundene Leibrenten und verkäufliche Renten) und laufenden Einnahmen (indirekte Steuern und Zölle). Alle Einnahmen in Basler Pfund."),
  creator = list(list(
    name = "Benjamin Hitz",
    orcid = "0000-0002-3208-4881"
  )),
  contributor = list(
    list(
      name = "Nico Görlich",
      orcid = "0000-0003-3860-1488"
    ),
    list(
      name = "Moritz Twente",
      email = "mtwente@protonmail.com",
      orcid = "0009-0005-7187-9774"
    )
  ),
  date = "1424/1484",
  coverage = "Mittelalter",
  source = "Harms, Bernhard: Die Münz- und Geldpolitik der Stadt Basel im Mittelalter, Tübingen 1907, S. 640–672. Bearbeitung: Nico Görlich / Moritz Twente",
  rights = "Public Domain Mark",
  relation = c("m39050_6", "m39050_10")
)
