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

source(here("src", "91310", "91310_clean.R"))

# Transform Data ------------------

data91310_longer <- data91310 %>%
  pivot_longer(
    cols = -Jahr,
    names_to = "Partei",
    values_to = "Sitze"
  )

# Parteien sortieren
data91310_longer$Partei <- factor(data91310_longer$Partei, levels = rev(c("Parteilos",
                                                                          "Freisinn",
                                                                          "Konservative",
                                                                          "Sozialdemokraten")))

# Diagramm plotten -----------
plot91310 <- ggplot(data = data91310_longer,
                    aes(x = Jahr, y = Sitze, fill = Partei)) +
  
  geom_vline(
    aes(xintercept = 1888.5, color = "Wechsel des Wahlsystems"),
    linewidth = 0.45,
    key_glyph = "path"
  ) +
  
  geom_bar(stat = "identity", position = "stack") +
  
  scale_fill_manual(values = c("Freisinn" = "#3872B5",  # entspricht Farbe RDP
                               "Konservative" = "#4B8A3E", # entspricht Farbe BGP
                               "Sozialdemokraten" = "#F0554D", # entspricht Farbe SP
                               "Parteilos" = "#777777")) +
  
  scale_color_manual(
    values = c("Wechsel des Wahlsystems" = "#F6C141"),
    breaks = c("Wechsel des Wahlsystems"),
    labels = c("Ab 1890 Wechsel\ndes Wahlsystems,\nneu als Majorzwahl.")
  ) +
  
  guides(
    fill = guide_legend(order = 1),
    color = guide_legend(order = 2,
                         override.aes = list(fill = NA))  # Remove fill from color glyph
  ) +
  
  scale_x_continuous(
    breaks = data91310_longer$Jahr,
    guide = guide_axis(),
    expand = expansion(mult = c(0, 0))
  ) +

  scale_y_continuous(
    breaks = pretty_breaks(),
    expand = expansion(mult = c(0, 0)),
  ) +
  
  coord_cartesian(clip = "off") +
  
  theme_sgb_basis() +
  theme(legend.position = "none",
        axis.ticks.x = element_blank(),
        axis.text.y = element_text(margin = margin(r = 5),
                                   hjust = 1),
        legend.key.height = unit(2.5, "mm"), # entspricht 2 mm
        legend.key.width = unit(5, "mm"), # entspricht 4.5 mm
        legend.box = "vertical",
        legend.box.just = "left",
        legend.spacing.y = unit(0.2, "cm"),
        legend.margin = margin(0,0,0,0, "cm"),
        plot.margin = margin(0.5,0.15,0,0.5, "lines")
  )

# Export -----------------------

export_plot(plot91310, 6, 120, 63, 32, 23)