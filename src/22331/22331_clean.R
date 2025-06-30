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

data22331 <- read_excel(here("data", "raw", "Band7", "22331", "22331_Data_raw.xlsx"),
                        range = "A11:H12",
                        col_names = FALSE)

data22331 <- data22331 %>%
  t() %>%
  as.data.frame() %>%
  rename(Jahr = V1,
         `Ausgaben pro 1000 Einwohner in CHF` = V2) %>%
  slice(-1) %>%
  mutate(
    Jahr = as.integer(Jahr),
    `Ausgaben pro 1000 Einwohner in CHF` = as.numeric(`Ausgaben pro 1000 Einwohner in CHF`)
  )

rownames(data22331) <- NULL

save_clean_csv(data22331, vol = 7)

# Create Metadata ------------

meta22331 <- annotate(data = data22331,
                      mediaID = 22331,
                      vol = 7,
                      title = "Staatliche Ausgaben für Musik und Theater, 1913–1966",
                      column_description = c("Jahreszahl, Angabe in Jahren unserer Zeitrechnung", "Höhe der Staatsausgaben des Kantons Basel-Stadt für Musik und Theater in Schweizer Franken pro Kopf im angegebenen Jahr. In den Jahren 1913 bis 1930 beinhalten die Ausgaben neben Musik und Theater auch noch die Literaturförderung. Für das Jahr 1913 wurden zur Berechnung die Bevölkerungszahlen aus der Volkszählung 1910 verwendet (ganzer Kanton, da sich die Staatsausgaben auch auf den Kanton und nicht nur die Stadt Basel beziehen)"),
                      object_description = "Die staatlichen Ausgaben für Musik und Theater stiegen insbesondere während der Hochkonjunktur der Nachkriegszeit exponentiell an. 1966 waren die Ausgaben pro Kopf über siebzigmal so hoch wie 1913.",
                      creator = list(list(name = "Noëmi Crain Merz")),
                      contributor = list(list(name = "Nico Görlich",
                                              orcid = "0000-0003-3860-1488"),
                                         list(name = "Moritz Twente",
                                              email = "moritz.twente@unibas.ch",
                                              orcid = "0009-0005-7187-9774")),
                      date = "1913/1966",
                      temporal = "Zeitgeschichte",
                      source = "Quelle: Statistisches Jahrbuch des Kantons Basel-Stadt, diverse Jahrgänge: Daten 1913-1930: Ausgabe 1935, S. 294 'Musik, Theater, Literatur (einschl. Münster, Kreuzgang usw.)'. Daten 1940-1955: Ausgabe 1955, S. 200f. Daten 1956-1963: Ausgabe 1963, S. 188f. Bearbeitung: Nico Görlich / Moritz Twente",
                      rights = "Public Domain Mark",
                      relation = list("m22331_1", "m22331_2")
)