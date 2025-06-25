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

source(here("src", "86088", "86088_clean.R"))

# Transform Data ------------------

data86088_longer <- data86088 %>%
  pivot_longer(cols = -Jahr,
               names_to = "Konfession",
               values_to = "Anzahl",
               names_prefix = "'",
               names_transform = list(Jahr = as.numeric)) %>%
  mutate(Jahr = gsub("'", "", Jahr)) %>%
  mutate(Jahr = as.numeric(Jahr))

# Plot -----------------------

plot86088 <- ggplot(data86088_longer, aes(x = Jahr, y = Anzahl,
                                          fill = factor(Konfession, levels = c("Evangelisch-reformiert",
                                                                               "Römisch-katholisch",
                                                                               "Andere christliche Glaubensgemeinschaften",
                                                                               "Jüdische Glaubensgemeinschaften",
                                                                               "Islamische Glaubensgemeinschaften",
                                                                               "Andere Religionsgemeinschaften",
                                                                               "Konfessionslos",
                                                                               "Ohne Angabe")))) +
  
  geom_bar(stat = "identity",
           position = position_dodge()) +
  
  geom_vline(xintercept = seq(1955, 2015, 10),
             color = "#777777",
             linetype = "longdash",
             linewidth = 0.3) +

  scale_x_continuous(
    breaks = seq(1950, 2020, 10),
    guide = guide_axis(),
    expand = expansion(mult = c(0, 0.005))
  ) +
  
  scale_y_continuous(
    limits = c(0, 160000),
    breaks = seq(0, 160000, 20000),
    expand = expansion(mult = c(0, 0)),
    labels = ch_numbers
  ) +
  
  scale_fill_manual(values = c("Evangelisch-reformiert" = "#6195CF",
                               "Römisch-katholisch" = "#F7CB45",
                               "Andere christliche Glaubensgemeinschaften" = "#EE8026",
                               "Jüdische Glaubensgemeinschaften" = "#F7F056", # was: 90C987
                               "Islamische Glaubensgemeinschaften" = "darkgreen",
                               "Andere Religionsgemeinschaften" = "#882E72",
                               "Konfessionslos" = "#777777",
                               "Ohne Angabe" = "#D1BBD7")) +
  
  coord_cartesian(clip = "off") + 
  
  theme_sgb_basis() +
  theme(
    legend.position = "none",
    axis.ticks.x = element_blank(),
    axis.text.y = element_text(margin = margin(r = 5),
                               hjust = 1),
    legend.key.height = unit(2.05, "mm"), # entspricht 1.64mm
    legend.key.width = unit(5, "mm"), # entspricht 4mm
    plot.margin = margin(0.5,0.9,0,0.4, "lines"))

# Export -----------------------

export_plot(plot86088, 8, 140, 63, 60, 20)