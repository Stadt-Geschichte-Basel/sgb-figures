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

#data17308 <- readr::read_csv(here("Band4", "17308", "17308_Data.csv"))
source(here("src", "17308", "17308_clean.R"))

# Transform Data ------------------

data17308_pest <- subset(data17308,
                         Pestjahr == TRUE,
                         select = c(Jahr, Bevölkerungszahl))

# Manipulation: zusätzlich 1500 mit Werten von 1501 für bessere x-Achsen-Darstellung
Zusatzeintrag = list(Jahr = 1500, Bevölkerungszahl = 9500, Pestjahr = FALSE)
data17308 <- rbind(data17308, Zusatzeintrag)

# Manipulation: Jahre anpassen für bessere x-Achsen-Darstellung
data17308$Jahr[34] <- 1700 # eigentlich 1699

data17308$Jahr[2] <- 1502 # eigentlich 1501, Label bleibt
data17308_pest$Jahr[1] <- 1502 # eigentlich 1501, Label bleibt

# Plot -----------------------

plot17308 <- ggplot(data = data17308, aes(x = Jahr)) +
  
  geom_segment(
    data = data17308_pest,
    aes(x = Jahr, y = max(Bevölkerungszahl),
        xend = Jahr, yend = Bevölkerungszahl + 120,
        color = "Pestjahr"),
    linewidth = 0.8,
    lineend = "round",
    key_glyph = "path"
  ) +
  
  geom_text(
    data = data17308_pest,
    aes(x = Jahr, y = max(Bevölkerungszahl + 900),
        label = c(1501, 1517, 1525, 1540, 1552, 1563, 1577, 1582, 1593, 1609, 1627, 1634, 1666)),
    color = "black", size = 2.14, # ggplot geom_text<>size ratio: x/(14/5) => 6.5/(14/5) = 2.14
    angle = 90,
  ) +
  
  geom_area(aes(y = Bevölkerungszahl, fill = "Bevölkerungszahl"), show.legend = TRUE) +
  
  scale_x_continuous(
    limits = c(1500, 1700),
    breaks = c(1500, 1550, 1600, 1650, 1700),
    guide = guide_axis(angle = 45),
    expand = expansion(mult = c(0, 0))
  ) +
  
  scale_y_continuous(
    limits = c(0, 15000),
    breaks = breaks_pretty(),
    expand = expansion(mult = c(0, 0)),
    labels = ch_numbers
  ) +
  
  scale_color_manual(
    values = c("Pestjahr" = "#F7CB45"),
    labels = c("Pestjahr"),
    breaks = c("Pestjahr"),
  ) +
  
  scale_fill_manual(
    values = c("Bevölkerungszahl" = "#7BAFDE"),
    labels = c("Anzahl Einwohner"),
    breaks = c("Bevölkerungszahl")
  ) +
  
  guides(
    fill = guide_legend(order = 1),
    color = guide_legend(order = 2,
                         override.aes = list(fill = NA))
  ) +
  
  coord_cartesian(clip = "off") +
  
  theme_sgb_basis() +
  theme(
    axis.text.y = element_text(margin = margin(r = 5),
                               hjust = 1),
    plot.margin = margin(0.5,0.9,0,0, "lines"),
    legend.position = "none",
    legend.key.height = unit(2.05, "mm"), # entspricht 1.64mm
    legend.key.width = unit(5, "mm"), # entspricht 4mm
    legend.box = "vertical",
    legend.box.just = "left",
    legend.spacing.y = unit(0.2, "cm"),
    legend.margin = margin(0,0,0,0, "cm"),
  )

# Export -----------------------

export_plot(plot17308, 4, 114.5, 63.8, 28, 8)