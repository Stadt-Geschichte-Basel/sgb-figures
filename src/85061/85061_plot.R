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

source(here("src", "85061", "85061_clean.R"))

# Transform Data ------------------

data85061 <- data85061 %>%
  mutate(across(.cols = Leerstandsquote, .fns = ~ . / 100))

# Plot -----------------------

plot85061 <- ggplot() +
  
  geom_segment(aes(x = data85061$Jahr, xend = data85061$Jahr,
                   y = 0, yend = data85061$Leerstandsquote),
               color = "#777777",
               linewidth = 0.561) +
  
  geom_point(aes(x = data85061$Jahr,
                 y = data85061$Leerstandsquote,
             color = "Leerstandsquote\nin Prozent"),
             size = 2) +

  scale_x_continuous(
    breaks = pretty_breaks(),
    guide = guide_axis(),
    expand = expansion(mult = c(0, 0.005))
  ) +
  
  scale_y_continuous(
    limits = c(0, 0.025),
    breaks = pretty_breaks(),
    expand = expansion(mult = c(0, 0)),
    labels = percent_format()
  ) +
  
  scale_color_manual(values = c("Leerstandsquote\nin Prozent" = "#F7CB45")) +
  
  coord_cartesian(clip = "off") + 
  
  theme_sgb_basis() +
  theme(
    legend.position = "none",
    axis.text.y = element_text(margin = margin(r = 5)),
    plot.margin = margin(0.5,0.9,0,0.5, "lines")
  )

# Export -----------------------

export_plot(plot85061, 8, 120, 63, 27, 5)