# Packages -------------------

library(here)
library(readxl)
library(csvwr)
library(magrittr)
library(jsonlite)
library(tidyr)

# Functions ------------------

source(here("src", "Funktionen", "Metadata_JSON.R"))
source(here("src", "Funktionen", "Export_CSV.R"))

# Process Data --------

data85061 <- read_excel(here("data", "raw", "Band8", "85061", "85061_Data_raw.xlsx"),
                        range = "A2:BI3")

data85061 <- data85061 %>%
  pivot_longer(cols = everything(),
               names_to = "Jahr",
               values_to = "Leerstandsquote",
               names_prefix = "'",
               names_transform = list(Jahr = as.numeric)) %>%
  mutate(Jahr = gsub("'", "", Jahr)) %>%
  mutate(Jahr = as.numeric(Jahr))

save_clean_csv(data85061, vol = 8)

# Create Metadata -------

meta85061 <- annotate(data = data85061,
                      mediaID = 85061,
                      vol = 8,
                      title = "Leerstandsquote, 1960–2020",
                      column_description = c("Angabe des Jahres nach unserer Zeitrechnung",
                                             "Leerstandsquote in Basel-Stadt in Prozent"),
                      object_description = "Insbesondere in der Hochkonjunktur der 1960er-Jahre, als die Zahl der Einwohnerinnen und Einwohner stark wuchs, war die Wohnungsnot gross. In den 1970er-Jahren entspannte sich die Situation auf dem Wohnungsmarkt. In den 2010er-Jahren machte sich die wachsende Wohnbevölkerung erneut anhand der wenigen freien Wohnungen bemerkbar",
                      creator = list(list(name = "Tobias Ehrenbold"),
                                     list(name = "Silas Gusset"),
                                     list(name = "Anina Zahn")),
                      contributor = list(list(name = "Nico Görlich",
                                              orcid = "0000-0003-3860-1488"),
                                         list(name = "Moritz Twente",
                                              email = "moritz.twente@unibas.ch",
                                              orcid = "0009-0005-7187-9774")),
                      date = "1960/2020",
                      temporal = "Zeitgeschichte",
                      source = "Quelle: Statistisches Amt Kanton Basel-Stadt Bearbeitung: Nico Görlich / Moritz Twente",
                      rights = "Public Domain Mark",
                      relation = list("m85061_1", "m85061_2")
                      )