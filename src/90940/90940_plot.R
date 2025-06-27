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

source(here("src", "90940", "90940_clean.R"))

# Transform Data ------------------

data90940_longer <- pivot_longer(data90940,
                                 cols = -Jahr,
                                 names_to = "Jahreseinkommen",
                                 values_to = "Anzahl")

data90940_longer$Jahr <- as.numeric(data90940_longer$Jahr)

data90940_longer$Jahreseinkommen <- factor(data90940_longer$Jahreseinkommen,
                                           levels = c(">20 000 Franken",
                                                      "6000–20 000 Franken",
                                                      "3000–6000 Franken",
                                                      "1500–3000 Franken",
                                                      "800–1500 Franken"))

# Plot -----------------------

plot90940 <- ggplot(data = data90940_longer,
                    aes(x = Jahr, y = Anzahl, fill = Jahreseinkommen)) +
  
  geom_area(alpha = 1) +

  scale_fill_manual(values = c("#F9CF5A",
                               "#FEE971",
                               "#A8BEA2",
                               "#6195CF",
                               "#7BAFDE"),
                    name = "Haushaltseinkommen") +
  
  scale_x_continuous(
    guide = guide_axis(),
    expand = expansion(mult = c(0, 0))
  ) +

  scale_y_continuous(
    limits = c(0, 35000),
    breaks = pretty_breaks(),
    expand = expansion(mult = c(0, 0)),
    labels = ch_numbers
  ) +
  
  coord_cartesian(clip = "off") +
  
  theme_sgb_basis() +
  theme(legend.position = "none",
        legend.key.height = unit(2.5, "mm"), # entspricht 2 mm
        legend.key.width = unit(5, "mm"), # entspricht 4.5 mm
        legend.title = element_text(color = "black", size = 6.5, hjust = 0),
        plot.margin = margin(0.5,1.2,0,0.5, "lines"),
        axis.text.y = element_text(margin = margin(r = 5),
                                   hjust = 1)
        )

# Export -----------------------

export_plot(plot90940, 6, 120, 72, 33, 20)