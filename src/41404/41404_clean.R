# Packages -------------------

library(here)
library(readxl)

# Functions ------------------

source(here("src", "Utils", "Metadata_JSON.R"))
source(here("src", "Utils", "Export_CSV.R"))

# Process Data ---------------

data41404 <- read_excel(here("data", "raw", "Band3", "41404", "41404_Data_raw.xlsx"),
  col_names = TRUE,
  range = "A15:F737"
)

data41404 <- data41404[, -3]

col_order <- c("Jahr", "Q [m3/s]", "P [m ü. M.]", "gleitender 100 jähriger MW", "Gewässerkorrektionen")
data41404 <- data41404[, col_order]

# in Spalte 5 geparkte Quellenangaben entfernen
spalte5_bereinigen <- c(465, 502, 518, 553, 577, 582)

for (i in spalte5_bereinigen) {
  data41404[i, 5] <- NA
}

save_clean_csv(data41404, csv_suffix = 3, vol = 3)

# Create Metadata ------------

meta41404 <- annotate(
  data = data41404,
  media_id = 41404,
  csv_suffix = 3,
  vol = 3,
  title = "Rheinhochwasser bei Basel-Schifflände, 1300–2021",
  column_description = c("Jahreszahl, Angabe in Jahren unserer Zeitrechnung", "Abflussmenge Q in Kubikmetern pro Sekunde", "P, Angabe in Meter über Meer (m. ü. M.)", "100-jähriges gleitendes Hochwasserabflussmittel der rekonstruierten sowie aller gemessenen Jahresabflussmaxima in Kubikmetern pro Sekunde", "Gewässerkorrektionen im jeweilige Jahr: Kanderkorrektion (ab 1714) und Juragewässerkorrektion (ab 1878)"),
  column_datatype = c("gYear", rep("float", 3), "string"),
  object_description = "Visualisierung der rekonstruierten und gemessenen Hochwasserstände. Gelbe Balken: die Kanderkorrektion (ab 1714) und die Juragewässerkorrektion (ab 1878). Rote Kurve: 100-jähriges gleitendes Hochwasserabflussmittel der rekonstruierten sowie aller gemessenen Jahresabflussmaxima. Graue Balken: 100-jähriges gleitendes Hochwasserabflussmittel der rekonstruierten sowie der höchsten gemessenen Jahresabflussmaxima.",
  creator = list(
    list(
      name = "Oliver Wetter",
      orcid = "0000-0003-1200-3498"
    ),
    list(
      name = "Claudia Moddelmog",
      orcid = "0000-0003-1555-1887"
    )
  ),
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
  date = "1300/2021",
  coverage = "Mittelalter",
  source = "Wetter, O., Pfister, C., Weingartner, R. u.a.: The largest floods in the High Rhine basin since 1268 assessed from documentary and instrmental evidence, in: Hydrological Sciences Journal 56 (5), 2011, S. 733-758. Bearbeitung: Nico Görlich / Moritz Twente",
  rights = "Public Domain Mark",
  relation = c("m41404_1", "m41404_2")
)
