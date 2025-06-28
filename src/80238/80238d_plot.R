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

source(here("src", "80238", "80238d_clean.R"))

# Transform Data -------------

data80238d_longer <- data80238d %>%
  pivot_longer(cols = -Jahr,
               names_to = "Partei",
               values_to = "Ständeratssitze",
               names_prefix = "'",
               names_transform = list(Jahr = as.numeric)) %>%
  mutate(Jahr = gsub("'", "", Jahr)) %>%
  mutate(Jahr = as.numeric(Jahr))

# Plot -----------------------

plot80238d <- ggplot(data80238d_longer,
                    aes(x = Jahr,
                        y = Ständeratssitze,
                        fill = factor(Partei, levels = c("SP",
                                                         "FDP")))) +
                      
  geom_bar(stat = "identity", position = "stack") +
  
  scale_x_continuous(
    breaks = seq(1963, 2019, 4) - 1.8,
    labels = seq(1963, 2019, 4),
    guide = guide_axis(),
    expand = expansion(mult = c(0, 0.005))
  ) +
  
  scale_y_continuous(
    limits = c(0, 1),
    breaks = c(0, 1),
    expand = expansion(mult = c(0, 0)),
    labels = ch_numbers
  ) +
  
  scale_fill_manual(values = c("SP" = "#F0554D",
                               "FDP" = "#3872B5")) +
  
  guides(color = guide_legend(keyheight = unit(4.8, "mm"), # results in ca. 3mm
                              ncol = 1)) +
  
  coord_cartesian(clip = "off") + 
  
  theme_sgb_basis() +
  theme(
    legend.position = "none",
    legend.key.width = unit(5, "mm"), # resultiert in 4 mm
    legend.key.height = unit(2.5, "mm"), # resultiert in 2 mm
    plot.margin = margin(0.5,0.9,0,0.4, "lines"),
    axis.ticks = element_blank(),
    axis.text.y = element_text(margin = margin(r = 5)),
  )

# Export ---------------------

export_plot(plot80238d, 8, 120, 12.7, 15, 8)