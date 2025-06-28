# Packages -------------------

library(here)
library(readxl)
library(csvwr)
library(magrittr)
library(jsonlite)
library(tidyr)
library(dplyr)

# Functions ------------------

source(here("src", "Funktionen", "Metadata_JSON.R"))
source(here("src", "Funktionen", "Export_CSV.R"))

# Process Data ---------------

data91407 <- read_excel(here("data", "raw", "Band6", "91407", "91407_Data_raw.xlsx"),
                        range = "A2:O9",
                        col_names = TRUE)

data91407 <- data91407 %>%
  pivot_longer(
    cols = -Partei,
    names_to = "Jahr",
    values_to = "Sitze"
  ) %>%
  pivot_wider(
    names_from = Partei,
    values_from = Sitze
  ) %>%
  mutate(Jahr = as.numeric(Jahr)) %>%
  arrange(Jahr)

save_clean_csv(data91407, vol = 6)

# Create Metadata ------------

meta91407 <- annotate(data = data91407,
                      mediaID = 91407,
                      vol = 6,
                      title = "Mandate der Parteien bei Grossratswahlen, 1875–1914",
                      column_description = c("Angabe des Jahres nach unserer Zeitrechnung, für das die entsprechenden Zahlen gelten.",
                                             "Anzahl der Mandate der FDP/RDP nach den Grossratswahlen im angegebenen Jahr. Sitze der Demokratischen Partei (1908: 1 / 1911:2) werden dem Freisinn (FDP/RDP) zugerechnet",
                                             "Anzahl der Mandate der LP/LDP nach den Grossratswahlen im angegebenen Jahr",
                                             "Anzahl der Mandate des Zentrums nach den Grossratswahlen im angegebenen Jahr",
                                             "Anzahl der Mandate der BGP nach den Grossratswahlen im angegebenen Jahr",
                                             "Anzahl der Mandate der SP nach den Grossratswahlen im angegebenen Jahr",
                                             "Anzahl der Mandate der KVP/CPV nach den Grossratswahlen im angegebenen Jahr",
                                             "Anzahl der Mandate für übrige Parteien/Kandidaturen nach den Grossratswahlen im angegebenen Jahr"),
                      object_description = "Die Einführung des Proporzes 1905 bedeutete eine Zäsur. Mit dem Erstarken der Sozialdemokratischen Partei (SP) und der Katholischen Volkspartei (KVP) diversifizierte sich die Parteienlandschaft. Davor stand die Wahl von Persönlichkeiten im Vordergrund, die auf Wahllisten für die Freisinnigen (Radikale, Demokraten, FDP/RDP), die liberal-konservative Mitte (Juste Milieu, Zentrum) und die Konservativen (LP, LDP) kandidierten",
                      creator = list(list(name = "Eva Gschwind"),
                                     list(name = "Benedikt Pfister")),
                      contributor = list(list(name = "Nico Görlich",
                                              orcid = "0000-0003-3860-1488"),
                                         list(name = "Moritz Twente",
                                              email = "moritz.twente@unibas.ch",
                                              orcid = "0009-0005-7187-9774")),
                      date = "1875/1914",
                      temporal = list("19 Jahrhundert", "20. Jahrhundert"),
                      source = "Quelle: für die Jahre 1875 bis 1902: Lüthi, Walter: Der Basler Freisinn von den Anfängen bis 1914, Basel 1983, S. 175. Ab 1905: Statistisches Amt Basel-Stadt. Bearbeitung: Nico Görlich / Moritz Twente",
                      rights = "Public Domain Mark",
                      relation = list("m91407_1", "m91407_2")
)