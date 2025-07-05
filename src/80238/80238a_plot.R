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

source(here("src", "80238", "80238a_clean.R"))

# Transform Data -------------

election_years <- c(1960, 1964, 1968, 1972, 1976, 1980, 1984, 1988, 1992, 1997, 2001, 2005, 2009, 2013, 2017, 2021)

data80238a_legislaturen <- data80238a[,-2:-10]
data80238a_vlines <- data80238a_legislaturen$Jahr[data80238a_legislaturen$NeueLegislatur == TRUE]

data80238a <- data80238a[,-10:-11]

data80238a_longer <- data80238a %>%
  pivot_longer(cols = -Jahr,
               names_to = "Partei",
               values_to = "Regierungsratssitze",
               names_prefix = "'",
               names_transform = list(Jahr = as.numeric)) %>%
  mutate(Jahr = gsub("'", "", Jahr)) %>%
  mutate(Jahr = as.numeric(Jahr))

# Plot -----------------------

plot80238a <- ggplot(data80238a_longer,
                    aes(x = Jahr,
                        y = Regierungsratssitze,
                        fill = factor(Partei, levels = c("Grüne",
                                                         "SP",
                                                         "DSP",
                                                         "GLP",
                                                         "CVP",
                                                         "FDP",
                                                         "LDP",
                                                         "Parteilos")))) +
  
  geom_bar(stat = "identity", position = "stack") +
  
  geom_vline(xintercept = data80238a_vlines - 0.5,
             linewidth = 0.25,
             colour = "#000000") +
  
  geom_blank(aes(x = 1960, y = 0, fill = "legislatur_marker")) + # invisible for legend entry
  
  scale_x_continuous(
    breaks = election_years - 0.5,
    labels = election_years,
    guide = guide_axis(),
    expand = expansion(mult = c(0, 0.005))
  ) +
  
  scale_y_continuous(
    limits = c(0, 7),
    breaks = c(0, 1, 3, 5, 7),
    expand = expansion(mult = c(0, 0)),
    labels = ch_numbers
  ) +
  
  scale_fill_manual(name = "",
                    values = c("Grüne" = "#84B547",
                                "SP" = "#F0554D",
                                "DSP" = "#BF3939",
                                "GLP" = "#C4C43D",
                                "CVP" = "#D6862B",
                                "FDP" = "#3872B5",
                                "LDP" = "#618DEA",
                                "Parteilos" = "#777777",
                                "legislatur_marker" = "transparent"),
                    breaks = c(
                      "Grüne", "SP", "DSP", "GLP", "CVP", "FDP", "LDP", "Parteilos",
                      "legislatur_marker"
                    ),
                    labels = c(
                      "Grüne", "SP", "DSP", "GLP", "CVP", "FDP", "LDP", "Parteilos",
                      "\nVertikale Linien\nkennzeichnen\nneue Legislaturen"
                    ),
                    guide = guide_legend(
                      override.aes = list(alpha = c(rep(1, 8), 0)),
                      ncol = 1)
                    ) +
  
  coord_cartesian(clip = "off") + 
  
  theme_sgb_basis() +
  theme(
    legend.position = "none",
    axis.ticks.x = element_blank(),
    axis.text.y = element_text(margin = margin(r = 5)),
    legend.key.width = unit(5, "mm"), # resultiert in 4 mm
    legend.key.height = unit(2.5, "mm"), # resultiert in 2 mm
    plot.margin = margin(0.5,0.1,0,0.4, "lines")
  )

# Export ---------------------

export_plot(plot80238a, 8, 120, 63, 28, 31)