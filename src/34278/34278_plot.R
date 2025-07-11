# Packages -------------------

library(here)
library(ggplot2)
library(tidyr)
library(scales)
library(dplyr)

# Functions ------------------

source(here("src", "Funktionen", "Format_Theme.R"))
source(here("src", "Funktionen", "Format_Achsenbeschriftung.R"))
source(here("src", "Funktionen", "Export_Plot.R"))

# Read Data ------------------

#data34278 <- readr::read_csv(here("Band2", "34278", "34278_Data.csv"))
source(here("src", "34278", "34278_clean.R"))

# Transform Data -------------

data34278_longer <- pivot_longer(data34278,
                                 cols = 2:25,
                                 names_to = "Monat",
                                 values_to = "Bewirtschaftung")

# change month names to numbers
data34278_longer$Monat[data34278_longer$Monat == "Januar"] <- 1
data34278_longer$Monat[data34278_longer$Monat == "Januar15"] <- 1.5
data34278_longer$Monat[data34278_longer$Monat == "Februar"] <- 2
data34278_longer$Monat[data34278_longer$Monat == "Februar15"] <- 2.5
data34278_longer$Monat[data34278_longer$Monat == "März"] <- 3
data34278_longer$Monat[data34278_longer$Monat == "März15"] <- 3.5
data34278_longer$Monat[data34278_longer$Monat == "April"] <- 4
data34278_longer$Monat[data34278_longer$Monat == "April15"] <- 4.5
data34278_longer$Monat[data34278_longer$Monat == "Mai"] <- 5
data34278_longer$Monat[data34278_longer$Monat == "Mai15"] <- 5.5
data34278_longer$Monat[data34278_longer$Monat == "Juni"] <- 6
data34278_longer$Monat[data34278_longer$Monat == "Juni15"] <- 6.5
data34278_longer$Monat[data34278_longer$Monat == "Juli"] <- 7
data34278_longer$Monat[data34278_longer$Monat == "Juli15"] <- 7.5
data34278_longer$Monat[data34278_longer$Monat == "August"] <- 8
data34278_longer$Monat[data34278_longer$Monat == "August15"] <- 8.5
data34278_longer$Monat[data34278_longer$Monat == "September"] <- 9
data34278_longer$Monat[data34278_longer$Monat == "September15"] <- 9.5
data34278_longer$Monat[data34278_longer$Monat == "Oktober"] <- 10
data34278_longer$Monat[data34278_longer$Monat == "Oktober15"] <- 10.5
data34278_longer$Monat[data34278_longer$Monat == "November"] <- 11
data34278_longer$Monat[data34278_longer$Monat == "November15"] <- 11.5
data34278_longer$Monat[data34278_longer$Monat == "Dezember"] <- 12
data34278_longer$Monat[data34278_longer$Monat == "Dezember15"] <- 12.5

data34278_longer$Bewirtschaftung <- as.factor(data34278_longer$Bewirtschaftung)
data34278_longer$Monat <- factor(data34278_longer$Monat,
                                 levels = as.character(seq(1, 12.5, by = 0.5)))

# vertikale Linien zur besseren Ablesbarkeit
vertical_lines <- seq(1, 12, 1)

hjust_value = 2

# Plot -----------------------

plot34278 <- ggplot(data34278_longer, aes(x = as.numeric(as.character(Monat)) -0.25, y = Feldtyp, fill = Bewirtschaftung)) +
  
  geom_tile() +
  
  geom_vline(xintercept = vertical_lines + 0.5,
             color = "#777777", linewidth = 0.14,
             linetype = "longdash") +
  
  scale_fill_manual(values = c("#CAE0AB", "#D1BBD7", "#F4A736", "#F7CB45")) +
  
  scale_x_continuous(
    breaks = c(seq(1.25, 9.25, by = 1), seq(10.5, 12.5, by = 1)),
    labels = as.character(1:12),
    expand = expansion(mult = c(0, 0))
  ) +

  scale_y_discrete(
    expand = expansion(mult = c(0, 0))
  ) +
  
  coord_cartesian(clip = "off") +
  
  theme_sgb_basis() +
  theme(legend.position = "none",
        axis.ticks.x = element_blank(),
        axis.ticks.y = element_blank(),
        axis.text.x = element_text(hjust = hjust_value),
        axis.text.y = element_text(margin = margin(r = 5)),
        plot.margin = margin(0.05,0,0,0.5, "lines"),
        legend.key.height = unit(2.05, "mm"), # entspricht 1.64mm
        legend.key.width = unit(5, "mm")) # entspricht 4mm


# Export ---------------------

export_plot(plot34278, 2, 120, 35.75, 23, 13)