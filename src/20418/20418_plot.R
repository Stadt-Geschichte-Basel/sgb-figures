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

#data20418 <- readr::read_csv(here("Band4", "20418", "20418_Data.csv"))
source(here("src", "20418", "20418_clean.R"))

# Plot -----------------------

plot20418 <- ggplot(data = data20418, aes(x = Jahr)) +
  geom_line(aes(y = `Konsumabgaben Stadt`, color = "Konsumabgaben Stadt"), linewidth = 0.561) +
  geom_line(aes(y = `Konsumabgaben Land`, color = "Konsumabgaben Land"), linewidth = 0.561) +
  geom_line(aes(y = `Handels- und Marktabgaben`, color = "Handels- und Marktabgaben"), linewidth = 0.561) +
  
  geom_smooth(aes(y = Einwohnerzahl_alternativ, color = "Bevölkerungsentwicklung"), 
              se = FALSE, linetype = "dotted", linewidth = 0.561) +
  
  # unsichtbares Element für zusätzlichen Text in der Legende
  geom_blank(aes(x = 1690, y = 0, color = "Alle Angaben in Pfund.")) +
  
  scale_x_continuous(
    breaks = seq(1690, 1795, 10),
    guide = guide_axis(angle = 45),
    expand = expansion(mult = c(0, 0))
  ) +
  
  scale_y_log10(
    limits = c(min(data20418$`Handels- und Marktabgaben`), 180000),
    breaks = c(15000, 30000, 60000, 120000, 180000),
    expand = expansion(mult = c(0, 0)),
    labels = ch_numbers
  ) +
  
  ylab("") +
  ggtitle("Pfund") +
  
  scale_color_manual(
    name = "",
    values = c(
      "Handels- und Marktabgaben" = "#F7CB45",
      "Konsumabgaben Stadt" = "#6195CF",
      "Konsumabgaben Land" = "#90C987",
      "Bevölkerungsentwicklung" = "#A5170E",
      "Alle Angaben in Pfund." = "transparent"  # Notiz unter der Legende
    ),
    breaks = c(
      "Handels- und Marktabgaben", 
      "Konsumabgaben Stadt", 
      "Konsumabgaben Land", 
      "Bevölkerungsentwicklung",
      "Alle Angaben in Pfund."
    ),
    labels = c(
      "Handels- und\nMarktabgaben", 
      "Konsumabgaben Stadt", 
      "Konsumabgaben Land", 
      "Bevölkerungsentwicklung\nin der Stadt (in Personen)",
      "Alle Angaben in Pfund."
    ),
    guide = guide_legend(override.aes = list(
      linetype = c(1, 1, 1, 3, 0)  # 1: solid, 3: dotted, 0: no line
    ))
  ) +
  
  coord_cartesian(clip = "off") +
  
  theme_sgb_basis() +
  theme(
    legend.position = "none",
    axis.text.y = element_text(margin = margin(r = 5),
                               hjust = 1),
    plot.margin = margin(0.5, 0.9, 0, 0, "lines")
  )

# Export ---------------------

export_plot(plot20418, 4, 116, 66, 38, 30)