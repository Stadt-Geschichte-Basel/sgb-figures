# Packages -------------------

library(here)
library(ggplot2)
library(tidyr)
library(scales)
library(dplyr)

# Functions ------------------

source(here("src", "Funktionen", "Format_Theme.R"))
source(here("src", "Funktionen", "Format_Tausendertrennzeichen.R"))
source(here("src", "Funktionen", "Format_Achsenbeschriftung.R"))
source(here("src", "Funktionen", "Export_Plot.R"))

# Read Data ------------------

#data39017 <- readr::read_csv(here("data", "clean", "Band3", "39017", "39017_Data.csv"))
source(here("src", "39017", "39017_clean.R"))

# Transform Data ------------------

subset39017 <- data39017 %>%
  select(Jahr, `Summe Ablösungen`, `Summe Neueinträge`) %>%
  pivot_longer(cols = c(`Summe Ablösungen`, `Summe Neueinträge`),
               names_to = "type",
               values_to = "value")

# Plot -----------------------

plot39017 <- ggplot() +
  
  geom_bar(aes(x = Jahr, y = value, fill = type),
           position = position_dodge2(preserve = "total",
                                      padding = 0),
           stat = "identity",
           data = subset39017) +
  
  geom_line(aes(x = Jahr, y = `Investierte Summe netto`, color = "Investierte Summe netto"),
            data = data39017,
            linewidth = 0.561) +
  
  scale_fill_manual(values = c("#F7CB45", "#6195CF"), name = "Kategorie") +

  scale_color_manual(values = c("Investierte Summe netto" = "#DC050C"), name = "Kategorie") + 
  
  scale_x_continuous(
    breaks = seq(1484, 1521, 5),
    guide = guide_axis(angle = 0),
    expand = expansion(mult = c(0, 0))
  ) +

  scale_y_continuous(
    limits = c(0, 10000),
    breaks = seq(0, 10000, by = 2000),
    expand = expansion(mult = c(0, 0)),
    labels = ch_numbers
  ) +
  
  coord_cartesian(clip = "off") +
  
  theme_sgb_basis() +
  theme(legend.position = "none",
        axis.text.y = element_text(margin = margin(r = 5),
                                   hjust = 1),
        legend.key.height = unit(2.05, "mm"), # entspricht 1.64mm
        legend.key.width = unit(5, "mm"), # entspricht 4mm
        plot.margin = margin(0.5,0,0,0, "lines"))

# Export -----------------------

export_plot(plot39017, 3, 104.25, 60, 77, 7.3)