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

data24528 <- read_excel(here("data", "raw", "Band4", "24528", "24528_Data_raw.xls"),
                        sheet = 1,
                        range = "A1:G569")

data24528 <- data24528[,-3]

colnames(data24528) <- c("Jahr", "Swiss GHD DOY", "Mittlere April-Juli-Temperatur", "11-jährig gleitendes Temperaturmittel", "oberer doppelter Standard-Temperaturschätzfehler", "unterer doppelter Standard-Temperaturschätzfehler")

save_clean_csv(data24528, vol = 4)

# Create Metadata -------

meta24528 <- annotate(data = data24528,
                      mediaID = 24528,
                      vol = 4,
                      title = "Temperaturabweichungen in °C, 1444–2011",
                      column_description = c("Jahreszahl, Angabe in Jahren unserer Zeitrechnung", "Nummer des Tages im jeweiligen Jahr (DOY, Day of Year), an dem die Weinlese begonnen wurde (GHD, Grape Harvest Date)", "Abweichung der mittleren April-Juli-Temperatur verglichen mit den monatlichen Anomalien des Mittelwerts von 1901 bis 2000 in Grad Celsius", "Abweichung des elfjährig gleitenden Temperaturmittels verglichen mit den monatlichen Anomalien des Mittelwerts von 1901 bis 2000 in Grad Celsius", "oberer doppelter Standard-Temperaturschätzfehler verglichen mit den monatlichen Anomalien des Mittelwerts von 1901 bis 2000 in Grad Celsius", "unterer doppelter Standard-Temperaturschätzfehler verglichen mit den monatlichen Anomalien des Mittelwerts von 1901 bis 2000 in Grad Celsius"),
                      object_description = "Die Temperaturrekonstruktion zeigt, dass die Anomalie im Jahr 1540, der keine langanhaltende Klimaerwärmung folgte, sogar den «bisher heissesten» Sommer 2003 übertraf.",
                      creator = list(list(name = "Susanna Burghartz"),
                                     list(name = "Marcus Sandl"),
                                     list(name = "Daniel Sidler")),
                      contributor = list(list(name = "Nico Görlich",
                                              orcid = "0000-0003-3860-1488"),
                                         list(name = "Moritz Twente",
                                              email = "moritz.twente@unibas.ch",
                                              orcid = "0009-0005-7187-9774")),
                      date = "1444/2011",
                      temporal = "Neuzeit",
                      source = "Wetter, Oliver; Pfister, Christian: Spring–summer Temperatures Reconstructed for Northern Switzerland and Southwestern Germany from Winter Rye Harvest Dates, 1454–1970, in: Climate of the Past 7 (4), 2011, S. 1307–1326. Bearbeitung: Nico Görlich / Moritz Twente",
                      rights = "CC BY-SA. Daten: Wetter; Pfister 2011, S. 1307–1326. Bearbeitung: Nico Görlich / Moritz Twente",
                      relation = list("m24528_1", "m24528_2")
)