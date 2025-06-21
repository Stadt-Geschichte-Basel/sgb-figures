# Packages -------------------

library(here)
library(readxl)
library(csvwr)
library(magrittr)
library(jsonlite)

# Functions ------------------

source(here("src", "Funktionen", "Metadata_JSON.R"))
source(here("src", "Funktionen", "Export_CSV.R"))

# Process Data --------

data14158 <- read_excel(here("data", "raw", "Band4", "14158", "14158_Data_raw.xlsx"),
                        sheet = 1,
                        range = "A1:C5")

data14158$Jahrhundert <- c(
  "15. Jahrhundert",
  "16. Jahrhundert",
  "17. Jahrhundert",
  "18. Jahrhundert"
)

colnames(data14158) <- c("Zeitraum", "Total Bürgerrechtsaufnahmen", "Total aufgenommene Personen", "Jahrhundert")

data14158 <- data14158[, c("Zeitraum", "Jahrhundert", "Total Bürgerrechtsaufnahmen", "Total aufgenommene Personen")]

save_clean_csv(data14158, vol = 4)

# Create Metadata -------

meta14158 <- annotate(data = data14158,
                      mediaID = 14158,
                      vol = 4,
                      title = "Bürgerrechtsaufnahmen, 1400–1798",
                      column_description = c("Zeitraum zwischen zwei Jahreszahlen, Angaben der Jahre nach unserer Zeitrechnung", "Angabe des Jahrhunderts nach unserer Zeitrechnung", "Anzahl der im entsprechenden Zeitraum bzw. Jahrhundert erfolgten Aufnahmen ins Bürgerrecht", "Anzahl der im entsprechenden Zeitraum bzw. Jahrhundert aufgenommenen Personen"),
                      object_description = "Basels Einbürgerungspolitik wurde im Laufe der Frühen Neuzeit immer restriktiver. Im 18. Jahrhundert kam es kaum noch zu Neuaufnahmen ins Bürgerrecht (Angaben nach Gschwind 1977, S. 170).",
                      creator = list(list(name = "Susanna Burghartz"),
                                     list(name = "Marcus Sandl"),
                                     list(name = "Daniel Sidler")),
                      contributor = list(list(name = "Nico Görlich",
                                              orcid = "0000-0003-3860-1488"),
                                         list(name = "Moritz Twente",
                                              email = "moritz.twente@unibas.ch",
                                              orcid = "0009-0005-7187-9774")),
                      date = "1400/1798",
                      temporal = "Neuzeit",
                      source = "Gschwind, Franz: Bevölkerungsentwicklung und Wirtschaftsstruktur der Landschaft Basel im 18. Jahrhundert. Ein historisch-demographischer Beitrag zur Sozial- und Wirtschaftsgeschichte mit besonderer Berücksichtigung der langfristigen Bevölkerungsentwicklung von Stadt (seit 1100) und Landschaft (seit 1500) Basel, Liestal 1977, S. 170. Bearbeitung: Nico Görlich / Moritz Twente",
                      rights = "CC BY-SA, Quelle: Gschwind 1977, S. 170. Bearbeitung: Nico Görlich / Moritz Twente",
                      relation = list("m14158_1", "m14158_2")
)