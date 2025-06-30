# Packages -------------------

library(here)
library(ggplot2)
library(tidyr)
library(scales)
library(dplyr)
library(forcats)

# Functions ------------------

source(here("src", "Funktionen", "Format_Theme.R"))
source(here("src", "Funktionen", "Format_Tausendertrennzeichen.R"))
source(here("src", "Funktionen", "Format_Achsenbeschriftung.R"))
source(here("src", "Funktionen", "Export_Plot.R"))

# Read Data ------------------

source(here("src", "26375", "26375_clean.R"))

# Transform Data -------------

data26375_longer <- data26375 %>%
  pivot_longer(
    cols = -Branche,
    names_to = "Jahr",
    values_to = "Beschäftigte"
  )

data26375_longer$Jahr <- as.numeric(data26375_longer$Jahr)

branche_order <- c(
  "Übrige Dienstleistungen",
  "Gesundheits- und Körperpflege",
  "Gastgewerbe",
  "Verkehr, PTT, Radio",
  "Detailhandel",
  "Grosshandel",
  "Banken, Finanzgesellschaften und Versicherungen",
  "Öffentliche Verwaltung"
)

data26375_longer$Branche <- factor(data26375_longer$Branche,
                                   levels = rev(branche_order))

# Plot -----------------------

plot26375 <- ggplot(data26375_longer) +
  
  geom_col(aes(x = Jahr, y = Beschäftigte, fill = Branche)) +
  
  scale_fill_manual(values = c("Banken, Finanzgesellschaften und Versicherungen" = "#F1932D",
                               "Grosshandel" = "#437DBF",
                               "Detailhandel" = "#7BAFDE",
                               "Verkehr, PTT, Radio" = "#f7cb45",
                               "Gastgewerbe" = "#4eb265",
                               "Gesundheits- und Körperpflege" = "#CAE0AB",
                               "Öffentliche Verwaltung" = "#CAACCB",
                               "Übrige Dienstleistungen" = "#777777"),
                    breaks = c("Banken, Finanzgesellschaften und Versicherungen",
                               "Grosshandel",
                               "Detailhandel",
                               "Verkehr, PTT, Radio",
                               "Gastgewerbe",
                               "Gesundheits- und Körperpflege",
                               "Öffentliche Verwaltung",
                               "Übrige Dienstleistungen"),
                    labels = c("Banken, Finanzgesellschaften,\nVersicherungen",
                               "Grosshandel",
                               "Detailhandel",
                               "Verkehr, PTT, Radio",
                               "Gastgewerbe",
                               "Gesundheits- und Körperpflege",
                               "Öffentliche Verwaltung",
                               "Übrige Dienstleistungen")) +
  
  scale_x_continuous(
    breaks = c(1929, 1939, 1955, 1965),
    guide = guide_axis(angle = 0),
    expand = expansion(mult = c(0, 0))) +

  scale_y_continuous(
    limits = c(0, 70000),
    breaks = seq(0, 70000, 10000),
    expand = expansion(mult = c(0, 0)),
    labels = ch_numbers
  ) +
  
  coord_cartesian(clip = "off") +

  theme_sgb_basis() +
  theme(
    legend.position = "none",
    legend.key.height = unit(2.5, "mm"), # entspricht 2 mm
    legend.key.width = unit(5, "mm"), # entspricht 4.5 mm
    axis.ticks.x = element_blank(),
    axis.text.y = element_text(margin = margin(r = 5),
                               hjust = 1),
    plot.margin = margin(0.5,0.1,0,0, "lines")
  )

# Export ---------------------

export_plot(plot26375, 7, 110, 56, 43, 24)