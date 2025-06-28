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

# Process Data ---------------

data88454 <- read_excel(here("data", "raw", "Band8", "88454", "88454_Data_raw.xlsx"),
                        range = "A6:C82")

save_clean_csv(data88454, vol = 8)

# Create Metadata ------------

meta88454 <- annotate(data = data88454,
                      mediaID = 88454,
                      vol = 8,
                      title = "Museumseintritte und Kinobesuche in Basel-Stadt, 1945–2020",
                      column_description = c("Jahreszahl nach unserer Zeitrechnung", "Anzahl der Kinobesuche im Kanton Basel-Stadt im entsprechenden Jahr. Angaben nach der Billetsteuerabrechnung, ab 1999 wegen der Abschaffung der Billetsteuer nur wenige Daten erhältlich. Wegen der COVID-19-Pandemie waren Kinos vom 28.02.2020 bis zum 05.06.2020 geschlossen, danach eingeschränkter Betrieb bezüglich Platz- und Personenzahl.", "Anzahl der Museumseintritte im Kanton Basel-Stadt im entsprechenden Jahr. Daten vor 1980 sind nicht vorhanden. Angabe zu den Eintritten bis inkl. 1991 nach StaBS ED-REG 37a 7-1 (2) Besucherstatistik nach Jahren 1980–2008, Daten ab 1992 aus dem Statistischen Jahrbuch. Im Jahr 2020 reduzierter Betrieb aufgrund der COVID-19-Pandemie."),
                      object_description = "In der zweiten Hälfte des 20. Jahrhunderts öffneten sich die Museen zunehmend für breitere Bevölkerungskreise und entwickelten Angebote für die ganze Familie. Das manifestierte sich auch in den Besucherzahlen, insbesondere ab den 1990er-Jahren. Ein gegenläufiger Trend war bei den Kinos zu beobachten. Das Fernsehen, später auch Videos, DVDs und Streamingdienste mit Flatrate-Angeboten wurden für viele eine günstige Alternative. 2005 besuchten nur noch eine Million Menschen Filmvorführungen (1957: 4.2 Millionen), die Zahl der Kinos sank von 19 (1957) auf 7 (2020). Als 2023 mit dem Multiplexkino Küchlin das letzte Lichtspielhaus in der Steinenvorstadt schliessen musste, war in den Medien die Rede vom «Tod der Kinostrasse».",
                      creator = list(list(name = "Tobias Ehrenbold"),
                                     list(name = "Silas Gusset"),
                                     list(name = "Anina Zahn")),
                      contributor = list(list(name = "Nico Görlich",
                                              orcid = "0000-0003-3860-1488"),
                                         list(name = "Moritz Twente",
                                              email = "moritz.twente@unibas.ch",
                                              orcid = "0009-0005-7187-9774")),
                      date = "1945/2020",
                      temporal = "Zeitgeschichte",
                      source = "Statistisches Jahrbuch des Kantons Basel-Stadt. Daten zu Museumseintritten vor 1992 nach StaBS ED-REG 37a 7-1 (2). Bearbeitung: Nico Görlich / Moritz Twente",
                      rights = "Public Domain Mark. Bearbeitung: Nico Görlich / Moritz Twente",
                      relation = list("m88454_1", "m88454_2")
)
