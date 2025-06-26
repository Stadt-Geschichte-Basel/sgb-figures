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

source(here("src", "90340", "90340_clean.R"))

# Transform Data ------------------

data90340_longer <- pivot_longer(
  data90340,
  cols = c("Grossbasel", "Kleinbasel"),
  names_to = "Stadtteil",
  values_to = "Wachstum"
)

# Normalize values for percent plot (if needed)
data90340_longer <- data90340_longer %>%
   mutate(Wachstum = Wachstum / 100)

# Plot (relative) -----------------------

plot90340 <- ggplot(data = data90340_longer, aes(x = Zeitraum,
                                                 y = Wachstum,
                                                 fill = Stadtteil)) +
  
  geom_bar(stat = "identity",
           position = position_dodge2(preserve = "single")) +
  
  scale_fill_manual(values = c("#F7CB45", "#6195CF")) +
  
  scale_x_discrete(
    #breaks = c(1850, 1910),
    guide = guide_axis(),
    expand = expansion(mult = c(0, 0.005))
  ) +
  
  scale_y_continuous(
    limits = c(0, 1),
    breaks = pretty_breaks(),
    expand = expansion(mult = c(0, 0)),
    labels = label_percent()
  ) +
  
  coord_cartesian(clip = "off") + 
  
  theme_sgb_basis() +
  theme(
    legend.position = "none",
    legend.key.height = unit(2.5, "mm"), # entspricht 2 mm
    legend.key.width = unit(5, "mm"), # entspricht 4.5 mm
    axis.ticks.x = element_blank(),
    axis.text.y = element_text(margin = margin(r = 5),
                               hjust = 1),
    plot.margin = margin(0.5,0.1,0,0.5, "lines")
  )

# Export -----------------------

export_plot(plot90340, 6, 120, 70, 21, 8)