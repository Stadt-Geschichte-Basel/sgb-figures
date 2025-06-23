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

source(here("src", "80238", "80238b_clean.R"))

# Transform Data ------------------

data80238b <- data80238b[,-18]

colnames(data80238b)[5] <- "GB (Grünes Bündnis aus\nGrüne & BastA, ab 2021 GAB)"
colnames(data80238b)[11] <- "CVP (ab 2021 Die Mitte)"
colnames(data80238b)[12] <- "EVP (bis 2006 VEW)"
colnames(data80238b)[13] <- "FDP (bis 1973 RDP)"
colnames(data80238b)[16] <- "NA (ab 1991 UVP, ab 1992 SD)"

data80238b_longer <- data80238b %>%
  pivot_longer(cols = -Jahr,
               names_to = "Partei",
               values_to = "Grossratssitze",
               names_prefix = "'",
               names_transform = list(Jahr = as.numeric)) %>%
  mutate(Jahr = gsub("'", "", Jahr)) %>%
  mutate(Jahr = as.numeric(Jahr))

# Plot -----------------------

plot80238b <- ggplot(data80238b_longer,
                    aes(x = Jahr,
                        y = Grossratssitze,
                        fill = factor(Partei, levels = c("POB",
                                                         "FraB",
                                                         "PdA",
                                                         "GB (Grünes Bündnis aus\nGrüne & BastA, ab 2021 GAB)",
                                                         "GP",
                                                         "SP",
                                                         "LdU",
                                                         "GLP",
                                                         "DSP",
                                                         "CVP (ab 2021 Die Mitte)",
                                                         "EVP (bis 2006 VEW)",
                                                         "FDP (bis 1973 RDP)",
                                                         "LDP",
                                                         "SVP",
                                                         "NA (ab 1991 UVP, ab 1992 SD)",
                                                         "Andere")))) +
  
  geom_bar(stat = "identity", position = "stack") +
  
  scale_x_continuous(
    breaks = seq(1960, 2020, 4) - 1.8,  # shift breaks to the left edge of bars
    labels = seq(1960, 2020, 4),
    guide = guide_axis(),
    expand = expansion(mult = c(0, 0.005))
  ) +
  
  scale_y_continuous(
    limits = c(0, 130),
    breaks = seq(10, 130, 10),
    expand = expansion(mult = c(0, 0)),
    labels = ch_numbers
  ) +
  
  scale_fill_manual(values = c("POB" = "#88519C",
                               "FraB" = "#8C2736",
                               "PdA" = "#BF3939",
                               "GB (Grünes Bündnis aus\nGrüne & BastA, ab 2021 GAB)" = "#84B547",
                               "GP" = "#487F5A",
                               "SP" = "#F0554D",
                               "LdU" = "#1BAA6E",
                               "GLP" = "#C4C43D",
                               "DSP" = "#BF3939",
                               "CVP (ab 2021 Die Mitte)" = "#D6862B",
                               "EVP (bis 2006 VEW)" = "#DEAA28",
                               "FDP (bis 1973 RDP)" = "#3872B5",
                               "LDP" = "#618DEA",
                               "SVP" = "#4B8A3E",
                               "NA (ab 1991 UVP, ab 1992 SD)" = "#5A3827",
                               "Andere" = "#B8B8B8")) +
  
  guides(color = guide_legend(keyheight = unit(4.8, "mm"), # results in ca. 3mm
                              ncol = 1)) +

  coord_cartesian(clip = "off") + 
  
  theme_sgb_basis() +
  theme(
    legend.position = "none",
    legend.key.width = unit(5, "mm"), # resultiert in 4 mm
    legend.key.height = unit(2.5, "mm"), # resultiert in 2 mm
    axis.text.y = element_text(margin = margin(r = 5)),
    plot.margin = margin(0.5,0.1,0,0.5, "lines"),
  )

# Export -----------------------

export_plot(plot80238b, 8, 120, 63, 45, 43)