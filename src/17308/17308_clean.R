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

data17308 <- read_excel(here("data", "raw", "Band4", "17308", "17308_Data_raw.xlsx"),
                        sheet = 2,
                        range = "A1:C44",
                        col_names = TRUE)

colnames(data17308) <- c("Jahr", "Bevölkerungszahl", "Pestjahr")

data17308$Pestjahr <- ifelse(is.na(data17308$Pestjahr), FALSE, data17308$Pestjahr == "Pest")

save_clean_csv(data17308, vol = 4)

# Create Metadata -------

meta17308 <- annotate(data = data17308,
                      mediaID = 17308,
                      vol = 4,
                      title = "Bevölkerungsentwicklung und Pestepidemien, 1500–1700",
                      column_description = c("Jahreszahl, Angaben bezeichnen jeweils in Jahr unserer Zeitrechnung", "Bevölkerungszahl von Basel in Anzahl Personen", "Jahre, in denen die Pest auftrat (TRUE)"),
                      object_description = "Bis ins 17. Jahrhundert brach in der Stadt ungefähr alle fünfzehn Jahre eine Seuche oder die Pest aus und forderte häufig tausende Opfer. So stieg die Zahl der Stadtbewohnerinnen und -bewohner kaum an. Erst nach der letzten grossen Pestwelle 1666/67 setzte ein kontinuierliches Bevölkerungswachstum ein, dem der Rat im 18. Jahrhundert mit einer restriktiven Einwanderungspolitik entgegenwirkte. Bei der Volkszählung im Jahr 1779 wurden 15 040 Personen erfasst. Für die Zeit davor liegen keine exakten Zahlen vor. Mithilfe von Tauf- und Geburtsregistern, Verzeichnissen der Bürgeraufnahmen, Häuserverzeichnissen, Steuerrödeln und des ‹Pestberichts› des Stadtarztes Felix Platter lassen sich aber Näherungswerte abschätzen.",
                      creator = list(list(name = "Susanna Burghartz"),
                                     list(name = "Marcus Sandl"),
                                     list(name = "Daniel Sidler")),
                      contributor = list(list(name = "Nico Görlich",
                                              orcid = "0000-0003-3860-1488"),
                                         list(name = "Moritz Twente",
                                              email = "moritz.twente@unibas.ch",
                                              orcid = "0009-0005-7187-9774")),
                      date = "1497/1798",
                      temporal = "Neuzeit",
                      source = "Gschwind, Franz: Bevölkerungsentwicklung und Wirtschaftsstruktur der Landschaft Basel im 18. Jahrhundert. Ein historisch-demographischer Beitrag zur Sozial- und Wirtschaftsgeschichte mit besonderer Berücksichtigung der langfristigen Bevölkerungsentwicklung von Stadt (seit 1100) und Landschaft (seit 1500) Basel, Liestal 1977, S. 172–174. Bearbeitung: Nico Görlich / Moritz Twente",
                      relation = list("m17308_1", "m17308_2"),
                      rights = "CC BY-SA, Quelle: Gschwind 1977, S. 172–174. Bearbeitung: Nico Görlich / Moritz Twente"
)