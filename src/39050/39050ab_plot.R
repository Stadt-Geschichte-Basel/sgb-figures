# Packages -------------------

library(here)
library(ggplot2)
library(tidyr)
library(scales)
library(dplyr)
library(ggpubr)
library(patchwork)

# Functions ------------------

source(here("src", "Funktionen", "Format_Theme.R"))
source(here("src", "Funktionen", "Format_Tausendertrennzeichen.R"))
source(here("src", "Funktionen", "Format_Achsenbeschriftung.R"))
source(here("src", "Funktionen", "Export_Plot.R"))

# Read Data ------------------

#data39050a <- readr::read_csv(here("Band3", "39050", "39050a_Data.csv"))
source(here("src", "39050", "39050a_clean.R"))
#data39050b <- readr::read_csv(here("Band3", "39050", "39050b_Data.csv"))
source(here("src", "39050", "39050b_clean.R"))

# Transform Data ------------------

vertical_lines <- seq(1373, 1399, by = 2)
xlabels39050 <- c("1373/74", "1375/76", "1377/78", "1379/80", "1381/82", "1383/84", "1385/86", "1387/88", "1389/90", "1391/92", "1393/94", "1395/96", "1397/98", "1399/1400")

## Transform Data Plot a ----------------

data39050a$Jahr_einzel <- c(1373:1399)

data39050a <- data39050a[,-1]

data39050a_longer <- data39050a %>%
  pivot_longer(
    !Jahr_einzel,
    names_to = "Typ",
    values_to = "Betrag"
  )

## Transform Data Plot b ----------------

data39050b$Jahr_einzel <- c(1373:1399)

data39050b <- data39050b %>% select(-Jahr)

data39050b_longer <- data39050b %>%
  pivot_longer(
    !Jahr_einzel,
    names_to = "Typ",
    values_to = "Summe"
  )

# Plot 39050a: Weinungeld, Mühlenungeld, Zölle ---------

plot39050a <- ggplot(data39050a_longer,
                     aes(x = Jahr_einzel, y = Betrag, fill = Typ)) +
  
  geom_area(alpha = 1) +
  
  geom_vline(xintercept = vertical_lines,
             color = "#777777", linewidth = 0.14,
             linetype = "longdash") +
  
  scale_fill_manual(values = c("#F7CB45", # Weinungeld
                               "#90C987", # Mühlenungeld
                               "#6195CF")) + # Zölle

  # mit expand_scale, wg. untersch. x-Skalierung von bar/area charts, die
  # angepasst werden muss zur Vergleichbarkeit mit 39050b
  scale_x_continuous(
    breaks = seq(1373, 1399, by = 2),
    labels = xlabels39050,
    guide = guide_axis(angle = 45),
    expand = expansion(add = 0.65)
  ) +

  scale_y_continuous(
    limits = c(0, 25000),
    breaks = pretty_breaks(),
    expand = expansion(mult = c(0, 0)),
    labels = ch_numbers
  ) +
  
  coord_cartesian(clip = "off") +
  
  theme_sgb_basis() +
  theme(legend.position = "none",
        legend.key.height = unit(2.05, "mm"), # entspricht 1.64mm
        legend.key.width = unit(5, "mm"), # entspricht 4mm
        axis.text.y = element_text(margin = margin(r = 5),
                                   hjust = 1),
        plot.margin = margin(0.5,0.5,0,0, "lines"))

# Plot 39050b: Steuereinnahmen, Leibrenten, verk. Renten ---------

plot39050b <- ggplot(data39050b_longer,
                     aes(x = Jahr_einzel, y = Summe, fill = Typ)) +
  
  geom_bar(stat = "identity", position = "stack") +
  
  geom_vline(xintercept = vertical_lines,
             color = "#777777", linewidth = 0.14,
             linetype = "longdash") +
  
  scale_fill_manual(name = "1373-1400",
                    values = c("#777777", # Steuereinnahmen
                               "#AE76A3", # Leibrenten
                               "#D1BBD7")) + # verkäufliche Renten
  
  # mit expand_scale, wg. untersch. Skalierung von bar/area charts, die
  # angepasst werden muss zur Vergleichbarkeit mit 39050a
  scale_x_continuous(
    breaks = seq(1373, 1399, by = 2),
    labels = xlabels39050,
    guide = guide_axis(angle = 45),
    expand = expand_scale(add = 0.2)) +
  
  scale_y_continuous(
    limits = c(0, 40000),
    breaks = pretty_breaks(),
    expand = expansion(mult = c(0, 0)),
    labels = ch_numbers
  ) +
  
  coord_cartesian(clip = "off") +
  
  theme_sgb_basis() +
  theme(plot.margin = margin(0.5,0.5,0,0, "lines"),
        legend.position = "none",
        axis.text.x = element_blank(),
        axis.text.y = element_text(margin = margin(r = 5),
                                   hjust = 1),
        axis.ticks.x = element_blank(),
        legend.key.height = unit(2.05, "mm"), # entspricht 1.64mm
        legend.key.width = unit(5, "mm"), # entspricht 4mm
        legend.title = element_text(size = 6.5, color = "black"),
        legend.title.align = 0
  )

# Combine Plots ---------

## Plot 39050a: get legend
plot39050a_with_legend <- plot39050a + theme(legend.position = "right",
                                             legend.justification = c("left", "bottom"))

legende39050a <- get_legend(plot39050a_with_legend) %>%
  as_ggplot()

## Plot 39050b: get legend
plot39050b_with_legend <- plot39050b + theme(legend.position = "right",
                                             legend.justification = c("left", "bottom"))

legende39050b <- get_legend(plot39050b_with_legend) %>%
  as_ggplot()

## Combine Plots with patchwork package

plot39050ab <- plot39050b + legende39050b + plot39050a + legende39050a + plot_layout(ncol = 2, widths = c(4, 1))

# Export -----------------------

export_plot(plot39050ab, 3, 175, 139)