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

source(here("src", "91203", "91203_clean.R"))

# Transform Data -------------

data91203_longer <- data91203 %>%
  pivot_longer(cols = -Jahr, names_to = "Typ", values_to = "Anzahl") %>%
  filter(!is.na(Anzahl)) %>%
  mutate(
    Typ = factor(Typ, levels = c("Gesamtbevölkerung", "Stimmberechtigte"))
  )

# Plot -----------------------

plot91203 <- ggplot(data91203_longer, aes(x = Jahr, y = Anzahl, color = Typ)) +
  
  geom_line(linewidth = 1) +
  
  scale_color_manual(
    values = c("Gesamtbevölkerung" = "#6195CF",
               "Stimmberechtigte" = "#F7CB45")
  ) +
  
  scale_x_continuous(
    breaks = pretty_breaks(),
    guide = guide_axis(),
    expand = expansion(mult = c(0, 0.005))
  ) +
  
  scale_y_continuous(
    limits = c(0, 140000),
    breaks = c(0, 25000, 50000, 100000, 140000),
    expand = expansion(mult = c(0, 0)),
    labels = ch_numbers
  ) +
  
  coord_cartesian(clip = "off") + 
  
  theme_sgb_basis() +
  theme(
    legend.position = "none",
    plot.margin = margin(0.5, 0.9, 0, 0, "lines"),
    axis.text.y = element_text(margin = margin(r = 5),
                               hjust = 1)
  )

# Export ---------------------

export_plot(plot91203, 6, 120, 63, 32, 11)