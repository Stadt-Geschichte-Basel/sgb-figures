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

source(here("src", "26060", "26060_clean.R"))

# Transform Data -------------

data26060_longer <- data26060 %>%
  pivot_longer(
    cols = -Branche,
    names_to = "Jahr",
    values_to = "Beschäftigte"
  )

data26060_longer$Jahr <- as.numeric(data26060_longer$Jahr)

branche_order <- c(
  "Dienstleistungen (ohne öffentliche Verwaltung)",
  "Elektrizitäts-, Gas- und Wasserversorgung",
  "Baugewerbe",
  "Industrie und Handwerk",
  "Land- und Forstwirtschaft"
)

data26060_longer$Branche <- factor(data26060_longer$Branche,
                                   levels = rev(branche_order))

# Plot -----------------------

plot26060 <- ggplot(data26060_longer) +
  
  geom_col(aes(x = Jahr, y = Beschäftigte, fill = Branche)) +
  
  scale_fill_manual(values = c("Land- und Forstwirtschaft" = "#90C987",
                               "Industrie und Handwerk" = "#F7CB45",
                               "Baugewerbe" = "#EE8026",
                               "Elektrizitäts-, Gas- und Wasserversorgung" = "#72190E",
                               "Dienstleistungen (ohne öffentliche Verwaltung)" = "#6195CF"),
                    labels = c("Land- und Forstwirtschaft",
                               "Industrie und Handwerk",
                               "Baugewerbe",
                               "Elektrizitäts-, Gas- und\nWasserversorgung",
                               "Dienstleistungen (ohne\nöffentliche Verwaltung)")) +
  
  scale_x_continuous(
    breaks = c(1929, 1939, 1955, 1965),
    guide = guide_axis(angle = 0),
    expand = expansion(mult = c(0, 0))) +

  scale_y_continuous(
    limits = c(0, 140000),
    breaks = seq(0, 140000, 20000),
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

export_plot(plot26060, 7, 120, 55, 36, 19)