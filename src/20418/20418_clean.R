# Packages -------------------

library(here)
library(readxl)
library(magrittr)
library(csvwr)
library(jsonlite)
library(readr)

# Functions ------------------

source(here("src", "Funktionen", "Metadata_JSON.R"))
source(here("src", "Funktionen", "Export_CSV.R"))

# Process Data --------

data20418 <- readr::read_csv(here("data", "raw", "Band4", "20418", "20418_Data_raw.csv"))

# manuell hinzugefügte Daten für Anfang 18. Jhd.:
data20418$Einwohnerzahl_alternativ[1] <- data20418$Einwohnerzahl[1]

data20418 <- data20418[, -2]
data20418 <- data20418[, -1]

colnames(data20418) <- c("Jahr", "Handels- und Marktabgaben", "Konsumabgaben Stadt", "Konsumabgaben Land", "Einwohnerzahl", "Einwohnerzahl_alternativ")

save_clean_csv(data20418, vol = 4)


# Create Metadata -------

meta20418 <- annotate(data = data20418,
                      mediaID = 20418,
                      vol = 4,
                      title = "Exportabgaben und Konsumsteuern, 1690–1798",
                      column_description = c("Jahreszahl, Angaben bezeichnen jeweils ein Jahr unserer Zeitrechnung", "Handels- und Marktabgaben. Angaben in Pfund", "Konsumabgaben der Stadt. Angaben in Pfund", "Konsumabgaben der Landschaft. Angaben in Pfund", "Einwohnerzahl der Stadt in Personen. Angaben übernommen aus abb17308", "Alternative Angaben zur Einwohnerzahl der Stadt in Personen. Angaben von S. Burghartz"),
                      object_description = "Die logarithmische Darstellung verdeutlicht das exponentielle Wachstum der Abgaben auf Export- und Handelswaren im Vergleich zu den Konsumabgaben. Seit den 1770er-Jahren übertrafen die Konsumabgaben der Landschaft diejenigen der Stadt.",
                      creator = list(list(name = "Susanna Burghartz"),
                                     list(name = "Marcus Sandl"),
                                     list(name = "Daniel Sidler")),
                      contributor = list(list(name = "Nico Görlich",
                                              orcid = "0000-0003-3860-1488"),
                                         list(name = "Moritz Twente",
                                              email = "moritz.twente@unibas.ch",
                                              orcid = "0009-0005-7187-9774")),
                      date = "1689/1797",
                      temporal = "Neuzeit",
                      source = "Vettori, Arthur: Finanzhaushalt und Wirtschaftsverwaltung Basels (1689–1798). Wirtschafts - und Lebensverhältnisse einer Gesellschaft zwischen Tradition und Umbruch, Basel; Frankfurt a. M. 1984, S. 211–215, 334–340. Gschwind, Franz: Bevölkerungsentwicklung und Wirtschaftsstruktur der Landschaft Basel im 18. Jahrhundert. Ein historisch-demographischer Beitrag zur Sozial- und Wirtschaftsgeschichte mit besonderer Berücksichtigung der langfristigen Bevölkerungsentwicklung von Stadt (seit 1100) und Landschaft (seit 1500) Basel, Liestal 1977, S. 173–174, 639–641. Bearbeitung: Nico Görlich / Moritz Twente",
                      rights = "CC BY-SA 4.0. Quelle: Vettori 1984, S. 211–215, 334–340; Gschwind 1977, S. 173–174, 639–641. Bearbeitung: Nico Görlich / Moritz Twente",
                      relation = list("m20418_1", "m20418_2")
)