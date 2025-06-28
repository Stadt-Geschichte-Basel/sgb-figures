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

source(here("src", "39492", "39492_clean.R"))

# Plots ----------------------

# vertikale Linien zur besseren Ablesbarkeit
vertical_lines <- seq(1375, 1525, by = 15)

## erster Plot: Kriegsausgaben -----------

plot39492a <- ggplot(data39492, aes(x = Startjahr)) +
  
  geom_vline(xintercept = vertical_lines,
             color = "#777777", linewidth = 0.14,
             linetype = "longdash") +
  
  geom_line(aes(y = `Summe Kriegsausgaben in Pfund`, colour = "Summe Kriegsausgaben in Pfund"),
            linewidth = 0.561) +
  
  scale_colour_manual(values = c("Summe Kriegsausgaben in Pfund" = "#F7CB45"),
                      labels = "Summe Kriegs-\nausgaben in Pfund",
                      drop = FALSE) +
  
  scale_x_continuous(
    breaks = seq(1360, 1525, by = 5),
    labels = everysecond(data39492$Zeitraum),
    guide = guide_axis(angle = 45),
    expand = expansion(mult = c(0, 0))
  ) +

  scale_y_continuous(
    limits = c(0, 40000),
    breaks = pretty_breaks(),
    expand = expansion(mult = c(0, 0)),
    labels = ch_numbers
  ) +
  
  coord_cartesian(clip = "off") +
  
  theme_sgb_basis() +
  theme(legend.position = "none",
        axis.text.x = element_blank(),
        axis.ticks.x = element_blank(),
        axis.text.y = element_text(margin = margin(r = 5),
                                   hjust = 1),
        plot.margin = margin(0.5,0.25,0,0.2, "lines"))

## zweiter Plot: Bürgeraufnahmen -----------

plot39492b <- ggplot(data39492, aes(x = Startjahr)) +
  
  geom_vline(xintercept = vertical_lines,
             color = "#777777", linewidth = 0.14,
             linetype = "longdash") +
  
  geom_line(aes(y = `Summe Bürgeraufnahmen`, colour = "Bürgeraufnahmen"),
            linewidth = 0.561) +
  
  scale_colour_manual(values = c("Bürgeraufnahmen" = "#6195CF"),
                      drop = FALSE) +
  
  scale_x_continuous(
    breaks = seq(1360, 1525, by = 5),
    labels = everysecond(data39492$Zeitraum),
    guide = guide_axis(angle = 45),
    expand = expansion(mult = c(0, 0)),
  ) +

  scale_y_continuous(
    limits = c(0, 1200),
    breaks = seq(0, 1200, by = 300),
    expand = expansion(mult = c(0, 0)),
    labels = ch_numbers
  ) +
  
  coord_cartesian(clip = "off") +
  
  theme_sgb_basis() +
  theme(legend.position = "none",
        axis.text.y = element_text(margin = margin(r = 5),
                                   hjust = 1),
        plot.margin = margin(0.5,0.25,0,0.2, "lines"))

# Combine Plots --------------

## Plot 39492a: get legend
plot39492a_with_legend <- plot39492a + theme(legend.position = "right",
                                             legend.justification = c("left", "bottom"))

legende39492a <- get_legend(plot39492a_with_legend) %>%
  as_ggplot()

## Plot 39492b: get legend
plot39492b_with_legend <- plot39492b + theme(legend.position = "right",
                                             legend.justification = c("left", "bottom"))

legende39492b <- get_legend(plot39492b_with_legend) %>%
  as_ggplot()

## Combine Plots with patchwork
plot39492 <- plot39492a + legende39492a + plot39492b + legende39492b + plot_layout(ncol = 2, widths = c(4, 1))

# Export ---------------------

export_plot(plot39492, 3, 175, 139)