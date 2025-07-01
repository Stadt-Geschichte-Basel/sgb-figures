# Packages -------------------

library(here)
library(readxl)
library(tibble)
library(csvwr)
library(jsonlite)

# Functions ------------------

source(here("src", "Funktionen", "Metadata_JSON.R"))
source(here("src", "Funktionen", "Export_CSV.R"))

# Process Data ---------------

data80380 <- read_excel(here("data", "raw", "Band8", "80380", "80380_Data_raw.xlsx"),
                        sheet = 1,
                        range = "A9:K15")

colnames(data80380) <- c("Tageszeitungen (total verkaufte Auflage Print, exkl. Gratisauflage)",
                         1966,
                         1972,
                         1978,
                         1984,
                         1990,
                         1996,
                         2002,
                         2008,
                         2014,
                         2020)

data80380$`Tageszeitungen (total verkaufte Auflage Print, exkl. Gratisauflage)`[4] <- "Basellandschaftliche Zeitung (ab 2019 bz – Zeitung für die Region Basel)"

data80380$`Tageszeitungen (total verkaufte Auflage Print, exkl. Gratisauflage)`[5] <- "AZ Abend-Zeitung (Daten nur bis 1984)"

## Auflage der AZ gilt für das Jahr 1971, nicht 1972
data80380 <- add_column(data80380,
                        "1971" = c(NA, NA, NA, NA, 7156, NA),
                        .before = "1972")
data80380[5, "1972"] <- NA

## Auflage der Basellandschaftlichen Zeitung gilt für das Jahr 1973, nicht 1972
data80380 <- add_column(data80380,
                        "1973" = c(NA, NA, NA, 14952, NA, NA),
                        .before = "1978")
data80380[4, "1972"] <- NA

## Auflage des Basler Volksblatts gilt für das Jahr 1975, nicht 1978
data80380 <- add_column(data80380,
                        "1975" = c(NA, NA, NA, NA, NA, 9554),
                        .before = "1978")
data80380[6, "1978"] <- NA

## Auflage der Basellandschaftlichen Zeitung gilt für das Jahr 1985, nicht 1984
data80380 <- add_column(data80380,
                        "1985" = c(NA, NA, NA, 18230, NA, NA),
                        .before = "1990")
data80380[4, "1984"] <- NA

## Auflage der Basellandschaftlichen Zeitung gilt für das Jahr 1991, nicht 1990
data80380 <- add_column(data80380,
                        "1991" = c(NA, NA, NA, 20213, NA, NA),
                        .before = "1996")
data80380[4, "1990"] <- NA

## Auflage des Basler Volksblatts/Nordschweiz gilt für das Jahr 1992, nicht 1990
data80380 <- add_column(data80380,
                        "1992" = c(NA, NA, NA, NA, NA, 10903),
                        .before = "1996")
data80380[6, "1990"] <- NA

save_clean_csv(data80380, vol = 8)

# Create Metadata ------------

meta80380 <- annotate(data = data80380,
                      mediaID = 80380,
                      vol = 8,
                      title = "Auflage der Tageszeitungen in der Region Basel, 1966–2020",
                      column_description = c("Name der jeweiligen Tageszeitung", "Total verkaufte Auflage der jeweiligen Zeitung im entsprechenden Jahr. Angaben für die Printausgabe, exkl. Gratisauflage",
                                             "Total verkaufte Auflage der jeweiligen Zeitung im enstprechenden Jahr. Angaben für die Printausgabe, exkl. Gratisauflage",
                                             "Total verkaufte Auflage der jeweiligen Zeitung im enstprechenden Jahr. Angaben für die Printausgabe, exkl. Gratisauflage",
                                             "Total verkaufte Auflage der jeweiligen Zeitung im enstprechenden Jahr. Angaben für die Printausgabe, exkl. Gratisauflage",
                                             "Total verkaufte Auflage der jeweiligen Zeitung im enstprechenden Jahr. Angaben für die Printausgabe, exkl. Gratisauflage",
                                             "Total verkaufte Auflage der jeweiligen Zeitung im enstprechenden Jahr. Angaben für die Printausgabe, exkl. Gratisauflage",
                                             "Total verkaufte Auflage der jeweiligen Zeitung im enstprechenden Jahr. Angaben für die Printausgabe, exkl. Gratisauflage",
                                             "Total verkaufte Auflage der jeweiligen Zeitung im enstprechenden Jahr. Angaben für die Printausgabe, exkl. Gratisauflage",
                                             "Total verkaufte Auflage der jeweiligen Zeitung im enstprechenden Jahr. Angaben für die Printausgabe, exkl. Gratisauflage",
                                             "Total verkaufte Auflage der jeweiligen Zeitung im enstprechenden Jahr. Angaben für die Printausgabe, exkl. Gratisauflage",
                                             "Total verkaufte Auflage der jeweiligen Zeitung im enstprechenden Jahr. Angaben für die Printausgabe, exkl. Gratisauflage",
                                             "Total verkaufte Auflage der jeweiligen Zeitung im enstprechenden Jahr. Angaben für die Printausgabe, exkl. Gratisauflage",
                                             "Total verkaufte Auflage der jeweiligen Zeitung im enstprechenden Jahr. Angaben für die Printausgabe, exkl. Gratisauflage",
                                             "Total verkaufte Auflage der jeweiligen Zeitung im enstprechenden Jahr. Angaben für die Printausgabe, exkl. Gratisauflage",
                                             "Total verkaufte Auflage der jeweiligen Zeitung im enstprechenden Jahr. Angaben für die Printausgabe, exkl. Gratisauflage",
                                             "Total verkaufte Auflage der jeweiligen Zeitung im enstprechenden Jahr. Angaben für die Printausgabe, exkl. Gratisauflage"),
                      object_description = "Die 'National-Zeitung' fusionierte mit den 'Basler Nachrichten' zur 'Basler Zeitung', die 'Basellandschaftliche Zeitung' übernahm die 'Nordschweiz', und die 'AZ Abend-Zeitung' musste den Betrieb einstellen. Die BaZ war über Jahrzehnte die bestverkaufte Zeitung in der Region – allerdings mit stark rückläufigen Verkaufszahlen. Die Digitalisierung hat den Medienkonsum grundlegend verändert.",
                      creator = list(list(name = "Tobias Ehrenbold"),
                                     list(name = "Silas Gusset"),
                                     list(name = "Anina Zahn")),
                      contributor = list(list(name = "Nico Görlich",
                                              orcid = "0000-0003-3860-1488"),
                                         list(name = "Moritz Twente",
                                              email = "moritz.twente@unibas.ch",
                                              orcid = "0009-0005-7187-9774")),
                      date = "1966/2020",
                      coverage = "Zeitgeschichte",
                      source = "WEMF-Archiv: Auflagebulletins. Bearbeitung: Nico Görlich / Moritz Twente",
                      rights = "Public Domain",
                      relation = list("m80380_1", "m80380_2")
)