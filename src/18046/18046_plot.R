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

#data18046 <- readr::read_csv(here("Band4", "18046", "18046_Data.csv"))
source(here("src", "18046", "18046_clean.R"))

# Transform Data ------------------

# (Jahr 1652 als 1653 auf Achse laut Regieanweisung)
data18046$Jahr[40] <- 1653

# Plot -----------------------

plot18046 <- ggplot(data = data18046, aes(x = Jahr)) +
  
  geom_line(aes(y = `Dinkel (in Viernzeln)`, color = "#6195CF"), linewidth = 0.561) +
  geom_line(aes(y = `Roggen (in Viernzeln)`, color= "#F7CB45"), linewidth = 0.561) +
  geom_line(aes(y = `Hafer (in Viernzeln)`, color = "#90C987"), linewidth = 0.561) +
  
  scale_x_continuous(
    breaks = c(1613, 1623, 1633, 1643, 1653),
    guide = guide_axis(angle = 45), # zentriert Labels passend zu ticks
    expand = expansion(mult = c(0, 0))
  ) +
  xlab("Jahr") +
  
  scale_y_continuous(
    limits = c(min(data18046), 8000),
    breaks = seq(0, 8000, by = 1000),
    expand = expansion(mult = c(0, 0)),
    labels = ch_numbers
  ) +
  
  scale_color_identity(
    name = "",
    breaks = c("#6195CF", "#F7CB45", "#90C987"),
    labels = c("Dinkel (in Viernzeln)", "Hafer (in Viernzeln)", "Roggen (in Viernzeln)"),
    guide = "legend"
  ) +
  
  coord_cartesian(clip = "off") + # Cut-Off an den Rändern deaktivieren
  
  guides(color = guide_legend(keyheight = unit(4.8, "mm"))) + # results in ca. 3mm
  
  theme_sgb_basis() +
  theme(
    legend.position = "none",
    axis.text.y = element_text(margin = margin(r = 5)),
    plot.margin = margin(0.5,0.9,0,0, "lines")
  )

# Export -----------------------

export_plot(plot18046, 4, 124, 68, 35, 16)