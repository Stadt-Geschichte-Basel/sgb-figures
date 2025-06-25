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

source(here("src", "81757", "81757_clean.R"))

# Transform Data ------------------

data81757_long <- data81757 %>%
  pivot_longer(cols = -Jahr,
               names_to = "Gebiet",
               values_to = "Ausländeranteil")

data81757_long <- data81757_long %>%
  mutate(across(.cols = Ausländeranteil, .fns = ~ . / 100))

data81757_long <- data81757_long %>%
  mutate(Gebiet = factor(Gebiet, levels = c("Kanton", "Matthäus", "St. Johann", 
                                            "Gundeldingen", "Breite", "Riehen", 
                                            "Bruderholz")))

# Plot -----------------------

plot81757 <- ggplot(data81757_long, aes(x = Jahr, y = Ausländeranteil,
                                        color = Gebiet,
                                        linetype = Gebiet)) +
  
  geom_line(data = data81757_long[!is.na(data81757_long$Ausländeranteil),],
            linewidth = 0.561) +
  
  geom_point() +
  
  scale_x_continuous(
    breaks = pretty_breaks(),
    guide = guide_axis(),
    expand = expansion(mult = c(0, 0.005))
  ) +
  
  scale_y_continuous(
    limits = c(0, 0.6001),
    breaks = pretty_breaks(),
    expand = expansion(mult = c(0, 0)),
    labels = percent_format(),
  ) +
  
  scale_color_manual(values = c("Kanton" = "#000000",
                                "Matthäus" = "#882E72",
                                "St. Johann" = "#AE76A3",
                                "Breite" = "#6195CF",
                                "Gundeldingen" = "#90C987",
                                "Bruderholz" = "#EE8026",
                                "Riehen" = "#DC050C")) +
  
  scale_linetype_manual(values = c("Kanton" = "solid",
                                   "Matthäus" = "longdash",
                                   "St. Johann" = "longdash",
                                   "Breite" = "longdash",
                                   "Gundeldingen" = "longdash",
                                   "Bruderholz" = "longdash",
                                   "Riehen" = "longdash")) +
  
  guides(
    linetype = guide_legend(override.aes = list(linetype = "solid"))
  ) +
  
  coord_cartesian(clip = "off") + 
  
  theme_sgb_basis() +
  theme(
    legend.position = "none",
    legend.key.width = unit(5, "mm"), # resultiert in 4 mm
    legend.key.height = unit(2.5, "mm"), # resultiert in 2 mm
    axis.text.y = element_text(margin = margin(r = 5),
                               hjust = 1),
    plot.margin = margin(0.5,0.9,0,0, "lines")
  )

# Export -----------------------

export_plot(plot81757, 8, 120, 64, 25, 18)