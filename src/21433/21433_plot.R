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

source(here("src", "21433", "21433_clean.R"))

# Transform Data -------------

data21433_longer <- pivot_longer(data21433,
                                 cols = !Jahr,
                                 names_to = "Bürgerrecht",
                                 values_to = "Anzahl")

data21433_longer$Bürgerrecht <- factor(
  data21433_longer$Bürgerrecht,
  levels = c(
    "Basler Bürgerrecht",
    "Bürgerrecht eines anderen Schweizer Kantons",
    "Ausländische Staatsbürgerschaft"
  )
)

# Plot -----------------------

plot21433 <- ggplot(data = data21433_longer,
                    aes(x = Jahr, y = Anzahl, fill = Bürgerrecht)) +
  
  geom_area(alpha = 1) +
  
  scale_fill_manual(values = c("Ausländische Staatsbürgerschaft" = "#F7CB45",
                               "Basler Bürgerrecht" = "#6195CF",
                               "Bürgerrecht eines anderen Schweizer Kantons" =  "#90C987"),
                    labels = c("Basler Bürgerrecht",
                               "Bürgerrecht eines anderen\nSchweizer Kantons",
                               "Ausländische Staatsbürgerschaft")) +
  
  scale_x_continuous(
    breaks = pretty_breaks(),
    guide = guide_axis(),
    expand = expansion(mult = c(0, 0.005))
  ) +
  
  scale_y_continuous(
    limits = c(0, 250000),
    breaks = pretty_breaks(),
    expand = expansion(mult = c(0, 0)),
    labels = ch_numbers
  ) +
  
  coord_cartesian(clip = "off") +
  
  theme_sgb_basis() +
  theme(legend.position = "none",
        plot.margin = margin(0.5,0.15,0,0.5, "lines"),
        axis.text.y = element_text(margin = margin(r = 5),
                                   hjust = 1),
        legend.key.height = unit(2.5, "mm"), # entspricht 2 mm
        legend.key.width = unit(5, "mm"), # entspricht 4.5 mm
        legend.key.justification = "top") # FIXME works only from Jan25 on, see https://github.com/tidyverse/ggplot2/pull/6279

# Export ---------------------

export_plot(plot21433, 7, 120, 60, 45, 12)