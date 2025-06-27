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

# Process Data --------

data91310 <- read_excel(here("data", "raw", "Band6", "91310", "91310_Data_raw.xlsx"),
                        sheet = 1,
                        range = "B3:P7")

colnames(data91310) <- gsub("\\.0$", "", colnames(data91310))

data91310 <- data91310 %>%
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

save_clean_csv(data91310, vol = 6)

# Create Metadata -------

meta91310 <- annotate(data = data91310,
                      mediaID = 91310,
                      vol = 6,
                      title = "Anzahl der Sitze im Regierungsrat des Kantons Basel-Stadt, 1875–1914",
                      column_description = c("Angabe des Jahres nach unserer Zeitrechnung, für das die entsprechenden Zahlen gelten.",
                                             "Anzahl der freisinnigen Mitglieder des Regierungsrats des Kantons Basel-Stadt nach den Gesamterneuerungswahlen im angegebenen Jahr",
                                             "Anzahl der konservativen Mitglieder des Regierungsrats des Kantons Basel-Stadt nach den Gesamterneuerungswahlen im angegebenen Jahr",
                                             "Anzahl der sozialdemokratischen Mitglieder des Regierungsrats des Kantons Basel-Stadt nach den Gesamterneuerungswahlen im angegebenen Jahr",
                                             "Anzahl der parteilosen Mitglieder des Regierungsrats des Kantons Basel-Stadt nach den Gesamterneuerungswahlen im angegebenen Jahr"),
                      object_description = "Die Grafik zeigt die Zusammensetzung des Regierungsrates jeweils nach den Gesamterneuerungswahlen alle drei Jahre. Bis 1887 wählte der Grosse Rat die Regierung. Seit 1890 wählt das Volk den Regierungsrat im Majorzsystem, im Gegensatz zum Grossen Rat, der seit 1905 im Proporzsystem gewählt wird",
                      creator = list(list(name = "Eva Gschwind"),
                                     list(name = "Benedikt Pfister")),
                      contributor = list(list(name = "Nico Görlich",
                                              orcid = "0000-0003-3860-1488"),
                                         list(name = "Moritz Twente",
                                              email = "moritz.twente@unibas.ch",
                                              orcid = "0009-0005-7187-9774")),
                      date = "1875/1914",
                      temporal = list("19 Jahrhundert", "20. Jahrhundert"),
                      source = "Quelle: Liste der Mitglieder des basel-städtischen Regierungsrates seit 1875. Bearbeitung: Nico Görlich / Moritz Twente",
                      rights = "Public Domain Mark",
                      relation = list("m91310_1", "m91310_2")
)
