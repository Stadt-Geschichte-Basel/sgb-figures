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

source(here("src", "15429", "15429_clean.R"))

# Transform Data -------------

# Manipulation von 1941 als 1940, damit gleiche Abstände im Plot erzielt werden
# Label bleibt bei 1941
data15429$Jahr[4] <- 1940

data15429_longer <- data15429 %>%
  pivot_longer(
    cols = -Jahr,
    names_to = "Konfessionen",
    values_to = "Anzahl"
  )

data15429_longer$Konfessionen <- factor(
  data15429_longer$Konfessionen,
  levels = c(
    "Protestant:innen (Ausland)",
    "Protestant:innen (Inland)",
    "Katholik:innen inkl. Christkatholik:innen (Ausland)",
    "Katholik:innen inkl. Christkatholik:innen (Inland)",
    "Jüd:innen (Inland und Ausland)",
    "Andere, ohne Religionszugehörigkeit und ohne Angabe (Inland und Ausland)")
  )

# Plot -----------------------


plot15429 <- ggplot(data15429_longer, aes(x = Jahr, y = Anzahl, fill = Konfessionen)) +
  
  geom_bar(stat = "identity", position = "fill") +
  
  scale_fill_manual(values = c("Protestant:innen (Ausland)" = "#7BAFDE",
                               "Protestant:innen (Inland)" = "#6195CF",
                               "Katholik:innen inkl. Christkatholik:innen (Ausland)" =  "#F7F056",
                               "Katholik:innen inkl. Christkatholik:innen (Inland)" =  "#F7CB45",
                               "Jüd:innen (Inland und Ausland)" = "#90C987",
                               "Andere, ohne Religionszugehörigkeit und ohne Angabe (Inland und Ausland)" =  "#777777")) +
  
  scale_x_continuous(
    breaks = data15429$Jahr,
    labels = c("1910", "1920", "1930", "1941", "1950", "1960", "1970"),
    guide = guide_axis(angle = 0),
    expand = expansion(mult = c(0, 0))
  ) +
  
  scale_y_continuous(
    breaks = breaks_pretty(),
    labels = label_percent(),
    expand = expansion(mult = c(0, 0))
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
    plot.margin = margin(0.5,0.1,0,0, "lines")
  )

# Export ---------------------

export_plot(plot15429, 7, 120, 63, 92, 16)