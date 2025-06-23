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

source(here("src", "80238", "80238c_clean.R"))

# Transform Data ------------------

data80238c <- data80238c[,-12]

colnames(data80238c) <- c("Jahr", "POB", "Grüne", "SP",
                          "LdU", "GLP", "CVP (ab 2021 Die Mitte)",
                          "FDP (bis 1973 RDP)", "LDP",
                          "SVP", "NA (ab 1991 UVP, ab 1982 SD)")

data80238c_longer <- data80238c %>%
  pivot_longer(cols = -Jahr,
               names_to = "Partei",
               values_to = "Nationalratssitze",
               names_prefix = "'",
               names_transform = list(Jahr = as.numeric)) %>%
  mutate(Jahr = gsub("'", "", Jahr)) %>%
  mutate(Jahr = as.numeric(Jahr))

# Plot -----------------------

plot80238c <- ggplot(data80238c_longer,
                    aes(x = Jahr,
                        y = Nationalratssitze,
                        fill = factor(Partei, levels = c("POB",
                                                         "Grüne",
                                                         "SP",
                                                         "LdU",
                                                         "GLP",
                                                         "CVP (ab 2021 Die Mitte)",
                                                         "FDP (bis 1973 RDP)",
                                                         "LDP",
                                                         "SVP",
                                                         "NA (ab 1991 UVP, ab 1982 SD)")))) +
                      
  geom_bar(stat = "identity", position = "stack") +
  
  scale_x_continuous(
    breaks = seq(1963, 2019, 4) - 1.8,  # shift breaks to the left edge of bars
    labels = seq(1963, 2019, 4),
    guide = guide_axis(),
    expand = expansion(mult = c(0, 0.005))
  ) +
  
  scale_y_continuous(
    limits = c(0, 8),
    breaks = seq(0, 8, 2),
    expand = expansion(mult = c(0, 0)),
    labels = ch_numbers
  ) +
  
  scale_fill_manual(values = c("POB" = "#88519C",
                               "Grüne" = "#84B547",
                               "SP" = "#F0554D",
                               "LdU" = "#1BAA6E",
                               "GLP" = "#C4C43D",
                               "CVP (ab 2021 Die Mitte)" = "#D6862B",
                               "FDP (bis 1973 RDP)" = "#3872B5",
                               "LDP" = "#618DEA",
                               "SVP" = "#4B8A3E",
                               "NA (ab 1991 UVP, ab 1982 SD)" = "#777777")) +
  
  guides(color = guide_legend(keyheight = unit(4.8, "mm"), # results in ca. 3mm
                              ncol = 1)) +
  
  coord_cartesian(clip = "off") + 
  
  theme_sgb_basis() +
  theme(
    legend.position = "none",
    legend.key.width = unit(5, "mm"), # resultiert in 4 mm
    legend.key.height = unit(2.5, "mm"), # resultiert in 2 mm
    axis.ticks = element_blank(),
    axis.text.y = element_text(margin = margin(r = 5)),
    plot.margin = margin(0.5,0.9,0,0.5, "lines")
  )

# Export -----------------------

export_plot(plot80238c, 8, 120, 63, 42, 26)