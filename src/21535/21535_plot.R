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

source(here("src", "21535", "21535_clean.R"))

# Transform Data -------------

data21535_longer <- data21535 %>%
  pivot_longer(
    cols = -Jahr,
    names_to = "Heimatnation",
    values_to = "Anzahl"
  )

# Plot -----------------------

plot21535 <- ggplot(data = data21535_longer,
                    aes(x = Jahr, y = Anzahl, fill = Heimatnation)) +
  
  geom_bar(stat = "identity", position = "fill") +
  
  scale_fill_manual(name = "Heimatnation",
    values = c("#F7CB45", "#6195CF", "#90C987", "#777777")) +
  
  scale_x_continuous(
    breaks = data21535$Jahr,
    labels = seq(1920, 1965, by = 5),
    guide = guide_axis(angle = 0),
    expand = expansion(mult = c(0, 0))
  ) +
  
  scale_y_continuous(
    breaks = breaks_pretty(),
    labels = label_percent(),
    expand = expansion(mult = c(0, 0))
  ) +
  
  coord_cartesian(clip = "off") +
  
  theme_sgb_basis() +
  theme(legend.position = "none",
        legend.title = element_text(color = "black", size = 6.5),
        legend.key.height = unit(2.5, "mm"), # entspricht 2 mm
        legend.key.width = unit(5, "mm"), # entspricht 4.5 mm
        legend.key.justification = "top", # FIXME works only from Jan25 on, see https://github.com/tidyverse/ggplot2/pull/6279
        plot.margin = margin(0.5,0,0,0, "lines"),
        axis.ticks.x = element_blank(),
        axis.text.y = element_text(margin = margin(r = 5),
                                   hjust = 1)
        )

# Export ---------------------

export_plot(plot21535, 7, 120, 60, 27, 16)