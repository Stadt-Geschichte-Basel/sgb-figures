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

source(here("src", "11589", "11589_clean.R"))

# Plot -----------------------

plot11589 <- ggplot(data = data11589, aes(x = Jahr)) +
  
  geom_line(aes(y = Personenwagen, color = "#6195CF"), linewidth = 0.561) +
  geom_line(aes(y = Motorräder, color = "#F7CB45"), linewidth = 0.561) +
  geom_line(aes(y = Fahrräder, color = "#90C987"), linewidth = 0.561) +
  
  scale_x_continuous(
    breaks = seq(1920, 1970, by = 5),
    guide = guide_axis(angle = 45),
    expand = expansion(mult = c(0, 0.005))
  ) +

  scale_y_continuous(
    limits = c(0, 50),
    breaks = seq(0, 50, by = 10),
    expand = expansion(mult = c(0, 0)),
    labels = ch_numbers
  ) +
  
  scale_color_identity(
    name = "",
    breaks = c("#6195CF", "#F7CB45", "#90C987"),
    labels = c("Personenwagen", "Motorräder", "Fahrräder"),
    guide = "legend"
  ) +
  
  coord_cartesian(clip = "off") + 
  
  theme_sgb_basis() +
  theme(
    legend.position = "none",
    legend.key.height = unit(2.5, "mm"), # entspricht 2 mm
    legend.key.width = unit(5, "mm"), # entspricht 4.5 mm
    axis.text.y = element_text(margin = margin(r = 5),
                               hjust = 1),
    plot.margin = margin(0.5,0.2,0,0, "lines"),
  )

# Export ---------------------

export_plot(plot11589, 7, 120, 63, 26, 11)