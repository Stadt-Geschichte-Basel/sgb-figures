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

source(here("src", "82338", "82338_clean.R"))

# Transform Data ------------------

data82338_longer <- data82338 %>%
  pivot_longer(cols = -Jahr,
               names_to = "Kanton",
               values_to = "Arbeitslosenquote") %>%
  mutate(Jahr = as.numeric(Jahr),
         Arbeitslosenquote = Arbeitslosenquote / 100)

data82338_longer$Kanton <- factor(data82338_longer$Kanton, levels=c("Kanton Zürich",
                                                                    "Kanton Genf",
                                                                    "Kanton Basel-Stadt",
                                                                    "Gesamte Schweiz"))

# Plot -----------------------

plot82338 <- ggplot(data82338_longer, aes(x = Jahr, y = Arbeitslosenquote,
                                     color = Kanton,
                                     group = Kanton)) +
    geom_line(linewidth = 0.561) +

    scale_x_continuous(
    breaks = pretty_breaks(),
    guide = guide_axis(),
    expand = expansion(mult = c(0, 0.005))
  ) +
  
  scale_y_continuous(
    limits = c(0, 0.08),
    breaks = pretty_breaks(),
    expand = expansion(mult = c(0, 0)),
    labels = percent_format()
  ) +
  
  scale_color_manual(values = c("Gesamte Schweiz" = "#DC050C",
                                "Kanton Basel-Stadt" = "#000000",
                                "Kanton Genf" = "#F7CB45",
                                "Kanton Zürich" = "#6195CF")) +
  
  guides(color = guide_legend(reverse = TRUE,
                              keyheight = unit(4.8, "mm"))) +  # results in ca. 3mm
  
  coord_cartesian(clip = "off") + 
  
  theme_sgb_basis() +
  theme(
    legend.position = "none",
    axis.text.y = element_text(margin = margin(r = 5),
                               hjust = 1),
    plot.margin = margin(0.5,0.1,0,0.5, "lines")
  )

# Export -----------------------

export_plot(plot82338, 8, 120, 63, 34, 18)