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

source(here("src", "39050", "39050c_clean.R"))
source(here("src", "39050", "39050d_clean.R"))

# Transform Data -------------

vertical_lines <- seq(1425, 1484, by = 5)

## Transform Data Plot c -----

data39050c$Jahr_einzel <- as.numeric(substr(data39050c$Rechnungjahr, 1, 4))

xlabels39050c <- data39050c[data39050c$Jahr_einzel %% 5 == 0, 1]
xlabels39050c <- unlist(xlabels39050c$Rechnungjahr)

data39050c <- data39050c[,-1]

# Spaltenreihenfolge: Weinungeld 1, Mühlenungeld 2, Gasthäuser 3, Zölle 4, Messen 5, Jahr 6
# für Print: Messen 5, Gasthäuser 3, Wein 1, Mühlen 2, Zölle 4, Jahr 6

data39050c_longer <- data39050c %>%
  pivot_longer(
    !Jahr_einzel,
    names_to = "Typ",
    values_to = "Betrag"
  ) %>%
  mutate(Typ = factor(Typ, levels = c("Von den Messen", "Weinungeld in Gasthäusern", "Weinungeld", "Mühlenungeld", "Zölle")))

## Transform Data Plot d -----

data39050d$Jahr_einzel <- as.numeric(substr(data39050d$Rechnungjahr, 1, 4))

xlabels39050d <- data39050d[data39050d$Jahr_einzel %% 5 == 0, 1]
xlabels39050d <- unlist(xlabels39050d$Rechnungjahr)

data39050d <- data39050d %>% select(-Rechnungjahr)

data39050d_longer <- data39050d %>%
  pivot_longer(
    !Jahr_einzel,
    names_to = "Typ",
    values_to = "Summe"
  )

# Plot 39050c: Weinungeld, Mühlenungeld, Zölle ---------

plot39050c <- ggplot(data39050c_longer,
                     aes(x = Jahr_einzel, y = Betrag, fill = Typ)) +
  
  geom_area(alpha = 1) +
  
  geom_vline(xintercept = vertical_lines,
             color = "#777777", linewidth = 0.14,
             linetype = "longdash") +
  
  scale_fill_manual(values = c("#7BAFDE", # von den Messen
                               "#F7F056", # Weinungeld in Gasthäusern
                               "#F7CB45", # Weinungeld
                               "#90C987", # Mühlenungeld
                               "#6195CF")) + # Zölle
  
  scale_x_continuous(
    breaks = seq(1425, 1484, by = 5),
    labels = xlabels39050c,
    guide = guide_axis(angle = 45), # zentriert Labels passend zu ticks
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

# Plot 39050d: Steuereinnahmen, Leibrenten, verk. Renten ---------

plot39050d <- ggplot(data39050d_longer,
                     aes(x = Jahr_einzel, y = Summe, fill = Typ)) +
  
  geom_bar(stat = "identity", position = "stack") +
  
  geom_vline(xintercept = vertical_lines,
             color = "#777777", linewidth = 0.14,
             linetype = "longdash") +
  
  scale_fill_manual(name = "1424-1484",
                    values = c("#777777", # Steuereinnahmen
                               "#AE76A3", # Leibrenten
                               "#D1BBD7")) + # verkäufliche Renten
  
  scale_x_continuous(
    breaks = seq(1425, 1484, by = 5),
    labels = xlabels39050d,
    guide = guide_axis(angle = 45),
    expand = expand_scale(add = 0.2)
  ) +

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

# Combine Plots --------------

## Plot 39050c: get legend
plot39050c_with_legend <- plot39050c + theme(legend.position = "right",
                                             legend.justification = c("left", "bottom"))

legende39050c <- get_legend(plot39050c_with_legend) %>%
  as_ggplot()

## Plot 39050d: get legend
plot39050d_with_legend <- plot39050d + theme(legend.position = "right",
                                             legend.justification = c("left", "bottom"))

legende39050d <- get_legend(plot39050d_with_legend) %>%
  as_ggplot()

## Combine Plots with patchwork package

plot39050cd <- plot39050d + legende39050d + plot39050c + legende39050c + plot_layout(ncol = 2, widths = c(4, 1))

# Export ---------------------

export_plot(plot39050cd, 3, 205, 139)