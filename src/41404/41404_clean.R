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

data41404 <- read_excel(here("data", "raw", "Band3", "41404", "41404_Data_raw.xlsx"),
                        col_names = TRUE,
                        range = "A15:F737")

data41404 <- data41404[,-3]

col_order <- c("Jahr", "Q [m3/s]", "P [m ü. M.]", "gleitender 100 jähriger MW" ,"Gewässerkorrektionen")
data41404 <- data41404[, col_order] 

# in Spalte 5 geparkte Quellenangaben entfernen
spalte5_bereinigen <- c(465, 502, 518, 553, 577, 582)

for (i in spalte5_bereinigen) {
  data41404[i, 5] <- NA
} 

save_clean_csv(data41404, vol = 3)

# Create Metadata ------------

meta41404 <- annotate(data = data41404,
                      mediaID = 41404,
                      vol = 3,
                      title = "Rheinhochwasser bei Basel-Schifflände, 1300–2021",
                      column_description = c("Jahreszahl, Angabe in Jahren unserer Zeitrechnung", "Abflussmenge Q in Kubikmetern pro Sekunde", "P, Angabe in Meter über Meer (m. ü. M.)", "100-jähriges gleitendes Hochwasserabflussmittel der rekonstruierten sowie aller gemessenen Jahresabflussmaxima in Kubikmetern pro Sekunde", "Gewässerkorrektionen im jeweilige Jahr: Kanderkorrektion (ab 1714) und Juragewässerkorrektion (ab 1878)"),
                      object_description = "Visualisierung der rekonstruierten und gemessenen Hochwasserstände. Gelbe Balken: die Kanderkorrektion (ab 1714) und die Juragewässerkorrektion (ab 1878). Rote Kurve: 100-jähriges gleitendes Hochwasserabflussmittel der rekonstruierten sowie aller gemessenen Jahresabflussmaxima. Graue Balken: 100-jähriges gleitendes Hochwasserabflussmittel der rekonstruierten sowie der höchsten gemessenen Jahresabflussmaxima.",
                      creator = list(list(name = "Oliver Wetter"),
                                         list(name = "Claudia Moddelmog")),
                      contributor = list(list(name = "Nico Görlich",
                                              orcid = "0000-0003-3860-1488"),
                                         list(name = "Moritz Twente",
                                              email = "moritz.twente@unibas.ch",
                                              orcid = "0009-0005-7187-9774")),
                      date = "1300/2021",
                      temporal = "Neuzeit",
                      source = "Wetter, O., Pfister, C., Weingartner, R. u.a.: The largest floods in the High Rhine basin since 1268 assessed from documentary and instrmental evidence, in: Hydrological Sciences Journal 56 (5), 2011, S. 733-758. Bearbeitung: Nico Görlich / Moritz Twente",
                      relation = list("m41404_1", "m41404_2"),
                      rights = "CC BY-SA. Daten: O. Wetter, C. Pfister, R. Weingartner u.a., Bearbeitung: Nico Görlich / Moritz Twente"
)