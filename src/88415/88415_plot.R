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

source(here("src", "88415", "88415_clean.R"))

# Transform Data ------------------

## Create data frame for mapping number of home games
data88415_Heimspiele <- data88415 %>%
  filter(Jahr %in% c(1965, 1982, 1999, 2016)) %>%
  select(Jahr, `Anzahl Heimspiele`) %>%
  mutate(Mapping = 550000)

data88415 <- data88415 %>%
  select(-`Anzahl Heimspiele`)

## Transform original data frame
data88415_longer <- data88415 %>%
  pivot_longer(cols = -Jahr,
               names_to = "Veranstaltung",
               values_to = "Zuschauer",
               names_prefix = "'",
               names_transform = list(Jahr = as.numeric)) %>%
  mutate(Jahr = gsub("'", "", Jahr)) %>%
  mutate(Jahr = as.numeric(Jahr))

# Plot -----------------------

plot88415 <- ggplot(data88415_longer) +
  
  geom_bar(aes(x = Jahr, y = Zuschauer,
               fill = factor(Veranstaltung, levels = c("Zuschauer:innen FCB-Heimspiele",
                                                       "Zuschauer:innen Konzerte"))),
           stat = "identity",
           position = position_dodge()) +
  
  # Construct for number of home games with segment, point and text
  geom_segment(data = data88415_Heimspiele, aes(x = Jahr,
                                                xend = Jahr,
                                                y = 0,
                                                yend = Mapping),
               color = "#000000",
               linewidth = 0.25) +

  geom_point(data = data88415_Heimspiele, aes(x = Jahr,
                                              y = Mapping,
                                              color = "Anzahl Heimspiele"),
             size = 4) +
  
  geom_text(data = data88415_Heimspiele, aes(x = Jahr,
                                             y = Mapping,
                                             label = `Anzahl Heimspiele`),
            size = 2.3,
            hjust = 0.55,
            color = "#ffffff") +
  
  scale_x_continuous(
    breaks = seq(1960, 2022, 6),
    guide = guide_axis(),
    expand = expansion(mult = c(0, 0.005))
  ) +
  
  scale_y_continuous(
    limits = c(0, 600000),
    breaks = seq(0, 600000, 100000),
    expand = expansion(mult = c(0, 0)),
    labels = ch_numbers
  ) +
  
  scale_fill_manual(values = c("Zuschauer:innen FCB-Heimspiele" = "#6195CF",
                               "Zuschauer:innen Konzerte" = "#F7CB45")) +
  
  scale_color_manual(values = c("Anzahl Heimspiele" = "#4EB265")) +
  
  guides(fill = guide_legend(order = 1), 
         color = guide_legend(order = 2)) +
  
  coord_cartesian(clip = "off") + 
  
  theme_sgb_basis() +
  theme(
    legend.position = "none",
    legend.key.width = unit(5, "mm"), # resultiert in 4.5 mm
    legend.key.height = unit(2.5, "mm"), # resultiert in 2 mm
    legend.box = "vertical",
    legend.box.just = "left",
    legend.spacing.y = unit(0, "cm"),
    legend.margin = margin(0,0,0,0, "cm"),
    axis.text.y = element_text(margin = margin(r = 5)),
    plot.margin = margin(0.5,0.9,0,0.4, "lines"))

# Export -----------------------

export_plot(plot88415, 8, 120, 63, 46, 10)