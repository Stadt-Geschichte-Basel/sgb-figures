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

#data24528 <- readr::read_csv(here("Band4", "24528", "24528_Data.csv"))
source(here("src", "24528", "24528_clean.R"))

# Transform Data ------------------

# Subset mit Extremjahren
data24528_extrem <- subset(data24528,
                           Jahr %in% c(1540, 1718, 1822, 1865, 1945, 2003),
                           select = c(Jahr, `Mittlere April-Juli-Temperatur`))

# Plot -----------------------

plot24528 <- ggplot(data = data24528, aes(x = Jahr)) +
  
  geom_segment(
    data = data24528_extrem,
    aes(x = Jahr, y = `Mittlere April-Juli-Temperatur` + 0.2,
        xend = Jahr, yend = max(`Mittlere April-Juli-Temperatur`) + 0.7),
    color = "#F7CB45",
    linewidth = 0.2805,
    lineend = "round"
  ) +
  
  geom_point(
    data = data24528_extrem,
    aes(x = Jahr, y = `Mittlere April-Juli-Temperatur` + 0.2),
    color = "#F7CB45",
    shape = 20,
    size = 0.4,
    show.legend = FALSE) +
  
  geom_text(
    data = data24528_extrem,
    aes(x = Jahr, y = max(`Mittlere April-Juli-Temperatur`) + 1.1),
    label = c(1540, 1718, 1822, 1865, 1945, 2003),
    color = "black", size = 2.32,
    angle = 0,
  ) +
  
  geom_line(aes(y = `Mittlere April-Juli-Temperatur`,
                color = "#777777"), linewidth = 0.14) +
  geom_line(aes(y = `11-jährig gleitendes Temperaturmittel`,
                color = "#A5170E"), linewidth = 0.561) +
  
  # Unsichtbare Elemente für zusätzliche Legendentexte
  geom_blank(aes(x = 1444, y = 0, color = "text_note")) +
  
  geom_line(aes(y = 0, color = "black"), linewidth = 0.2805) +
  
  # Extra-Punkt für einzelnen Temperatur-Wert aus dem Jahr 1444
  geom_point(aes(x = 1444, y = `Mittlere April-Juli-Temperatur`[1], color = "#777777"),
             shape = 20,
             size = 0.18,
             alpha = 0.8,
             show.legend = FALSE) +
  
  scale_x_continuous(
    limits = c(min(data24528$Jahr), max(data24528$Jahr)),
    breaks = seq(1444, 2008, by = 50),
    guide = guide_axis(angle = 45),
    expand = expansion(mult = c(0, 0))
  ) +
  
  scale_y_continuous(
    limits = c(-4, 8),
    breaks = seq(-4, 8, by = 2),
    expand = expansion(mult = c(0, 0)),
    labels = number_format(accuracy = 0.01,
                           decimal.mark = '.',
                           style_positive = c("plus"))
  ) +
  
  scale_color_manual(
    values = c(
      "#777777" = "#777777",
      "#A5170E" = "#A5170E",
      "text_note" = "transparent"
    ),
    breaks = c(
      "#777777",
      "#A5170E",
      "text_note"
    ),
    labels = c(
      "Mittlere April-Juli-Temperatur",
      "11-jährig gleitendes Temperaturmittel",
      "\nkalibriert mit den monatlichen\nAnomalien des Mittelwerts 1901-2000"
    ),
    guide = guide_legend(override.aes = list(
      linetype = c(1, 1, 0),
      size = c(0.14, 0.561, 0)
    ))
  ) +
  
  coord_cartesian(clip = "off") +
  
  theme_sgb_basis() +
  theme(
    legend.position = "none",
    legend.key.width = unit(5, "mm"),
    legend.key.height = unit(2.05, "mm"),
    axis.text.y = element_text(margin = margin(r = 5)),
    plot.margin = margin(0.5, 0.5, 0, 0, "lines")
  )

# Export -----------------------

export_plot(plot24528, 4, 140, 64, 50, 17)