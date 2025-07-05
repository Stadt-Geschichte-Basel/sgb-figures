# Packages -------------------

library(here)
library(ggplot2)
library(tidyr)
library(scales)
library(dplyr)
library(patchwork)

# Functions ------------------

source(here("src", "Funktionen", "Format_Theme.R"))
source(here("src", "Funktionen", "Format_Tausendertrennzeichen.R"))
source(here("src", "Funktionen", "Format_Achsenbeschriftung.R"))
source(here("src", "Funktionen", "Export_Plot.R"))

# Read Data ------------------

source(here("src", "88300", "88300a_clean.R"))
source(here("src", "88300", "88300b_clean.R"))

# Transform Data -------------

## Plot A: Kultursubventionen pro Kopf je Kanton
data88300a <- data88300a %>%
  mutate(Kanton = factor(Kanton, levels = rev(unique(Kanton))))

## Plot B: Subventionsempfängerinnen in Basel-Stadt
data88300b <- data88300b %>%
  mutate(
    Proportion = `Ausgaben in CHF (2021)` / sum(`Ausgaben in CHF (2021)`),
    Proportion_Label = paste0(round(Proportion * 100, 1), "%"),
    Legend_Label = paste0(Empfänger, " (", Proportion_Label, ")")
  )

data88300b$Legend_Label <- factor(data88300b$Legend_Label,
                                 levels = rev(c(
                                   data88300b$Legend_Label[order(data88300b$`Ausgaben in CHF (2021)`,
                                                                decreasing = FALSE)
                                                          & data88300b$Empfänger != "Diverses"],
                                   "Diverses (13.5%)"))
                                 )

color_mapping <- c("Museen (42.2%)" =           "#F7CB45",
                   "Theater und Tanz (31%)" =   "#6195CF",
                   "Musik (7.9%)" =             "#EE8026",
                   "Literatur (5.3%)" =         "#882E72",
                   "Diverses (13.5%)" =         "#777777"
                   )

# Plot -----------------------

plot88300a <- ggplot(data88300a, aes(x = Kanton,
                                   y = `Kultursubventionen pro Kopf in Franken (2021)`,
                                   fill = "#cc4a23")) + # Bandfarbe 8
  
  geom_bar(stat = "identity") +
  
  ggtitle("CHF/pro Kopf") +
  
  scale_y_continuous(
    limits = c(0, 409),
    breaks = seq(0, 400, 100),
    expand = expansion(mult = c(0, 0)),
    labels = ch_numbers
  ) +
  
  theme_sgb_basis() +
  theme(
    axis.ticks.x = element_blank(),
    axis.text.y = element_text(margin = margin(r = 5)),
    panel.grid.major.y = element_line(color = "black", linewidth = 0.14),
    panel.grid.major.x = element_blank(),
    plot.title = element_text(size = 6.5,
                              color = "black",
                              margin = unit(c(2.2, 0, 4, 0), "pt"),
                              hjust = 0),
    legend.position = "none")

## Create Plot B (Subventionsempfängerinnen in Basel-Stadt)
plot88300b <- ggplot(data88300b) +
  
  geom_bar(aes(x = "", y = `Ausgaben in CHF (2021)`, fill = Legend_Label),
           stat = "identity", width = 1) +
  
  scale_y_continuous(breaks = NULL) +
  
  scale_fill_manual(values = color_mapping) +
  
  coord_polar("y", start = 0) +
  
  guides(fill = guide_legend(ncol = 2, reverse = TRUE)) +
  
  theme_void() +
  theme(
    axis.line.x.bottom = element_blank(),
    axis.line.y.left = element_blank(),
    axis.ticks.y = element_blank(),
    legend.position = "none",
    legend.key = element_rect(fill = "transparent", colour = NA),
    legend.key.width = unit(5, "mm"), # resultiert in 4 mm
    legend.key.height = unit(2.5, "mm"), # resultiert in 2 mm
    legend.text = element_text(size = 6.5),
    legend.direction = "vertical",
    legend.title = element_blank()
  )

# Combine Plots --------------

## Plot 88300b: get legend
plot88300b_with_legend <- plot88300b + theme(legend.position = "right")

legende88300b <- get_legend(plot88300b_with_legend) %>%
  as_ggplot()

## Join legend and plot to a new single plot for better appearance in combination with plot88300a
plot88300b_joined <- plot88300b + plot_spacer() + legende88300b + plot_layout(ncol = 1,
                                                                              heights = c(12, 0.7, 0.2))

## Combine Plots with patchwork package
plot88300 <- plot88300a + plot_spacer() + plot88300b_joined + plot_layout(ncol = 3,
                                                                          widths = c(1.2, 0.2, 1.9))

# Export ---------------------

export_plot(plot88300, 8, 120, 88)