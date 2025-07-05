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

source(here("src", "77089", "77089_clean.R"))

# Transform Data -------------

data77089_Personenwagen <- data77089[,-3:-4]

data77089_Motorräder_inkl_Mofas <- data77089 %>%
  select(Jahr, "Motorräder inkl. Mofas")

data77089_Fahrräder <- data77089 %>%
  select(Jahr, "Fahrräder") %>%
  na.omit()

# Plot -----------------------

plot77089 <- ggplot() +
  
  geom_line(data = data77089_Personenwagen, aes(x = Jahr, y = Personenwagen, color = "Personenwagen"),
            linewidth = 0.561) +
  
  geom_line(data = data77089_Motorräder_inkl_Mofas, aes(x = Jahr, y = `Motorräder inkl. Mofas`,
                                                        color = "Motorräder inkl. Mofas"),
            linewidth = 0.561) +
  
  geom_line(data = data77089_Fahrräder, aes(x = Jahr, y = Fahrräder,
                                            color = "Fahrräder"),
            linewidth = 0.561) +
  
  scale_x_continuous(
    breaks = pretty_breaks(),
    guide = guide_axis(),
    expand = expansion(mult = c(0, 0.005))
  ) +
  
  scale_y_continuous(
    limits = c(0, 90000),
    breaks = c(0, 30000, 60000, 90000),
    expand = expansion(mult = c(0, 0)),
    labels = ch_numbers
  ) +
  
  scale_color_manual(values = c("Personenwagen" = "#6195CF",
                                "Motorräder inkl. Mofas" = "#F7CB45",
                                "Fahrräder" = "#bc5231")) +

  coord_cartesian(clip = "off") + 
  
  guides(color = guide_legend(keyheight = unit(4.8, "mm"))) + # results in ca. 3mm
  
  theme_sgb_basis() +
  theme(
    legend.position = "none",
    legend.key.height = unit(1.64, "mm"),
    axis.text.y = element_text(margin = margin(r = 5),
                               hjust = 1),
    plot.margin = margin(0.5,0.9,0,0, "lines")
  )

# Export ---------------------

export_plot(plot77089, 8, 120, 63, 33, 13)