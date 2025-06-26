# Packages -------------------

library(here)
library(ggplot2)
library(tidyr)
library(scales)
library(dplyr)
library(forcats)

# Functions ------------------

source(here("src", "Funktionen", "Format_Theme.R"))
source(here("src", "Funktionen", "Format_Tausendertrennzeichen.R"))
source(here("src", "Funktionen", "Format_Achsenbeschriftung.R"))
source(here("src", "Funktionen", "Export_Plot.R"))

# Read Data ------------------

source(here("src", "90894", "90894_clean.R"))

# Transform Data ------------------

top_ziellaender <- c("England", "USA", "Frankreich", "Deutschland")

# Collapse minor countries into "Übrige" and summarise
data90894_processed <- data90894 %>%
  mutate(Zielland = if_else(Zielland %in% top_ziellaender, Zielland, "Übrige")) %>%
  group_by(Zielland) %>%
  summarise(across(c(Seidenband, Schappe, Teerfarben), sum), .groups = "drop")

# Pivot to long format
data90894_long <- data90894_processed %>%
  pivot_longer(cols = Seidenband:Teerfarben, names_to = "Ware", values_to = "Summe")

# Keep only top3 Zielländer, add fourth to "Übrige"
data90894_modified <- data90894_long %>%
  group_by(Ware) %>%
  # Identify the Zielland with the minimum value (excluding "Übrige")
  mutate(
    min_value = min(Summe[Zielland != "Übrige"]),
    min_country = Zielland[which.min(replace(Summe, Zielland == "Übrige", Inf))]
  ) %>%
  ungroup() %>%
  mutate(
    Summe = case_when(
      Zielland == "Übrige" ~ Summe + min_value,
      Zielland == min_country ~ NA_real_,
      TRUE ~ Summe
    )
  ) %>%
  filter(!is.na(Summe)) %>%
  select(Zielland, Ware, Summe)

# Factor ordering and rescaling
data90894_modified <- data90894_modified %>%
  mutate(
    Ware = factor(Ware, levels = c("Teerfarben", "Schappe", "Seidenband")),
    Zielland = factor(Zielland, levels = c("England",
                                           "USA",
                                           "Frankreich",
                                           "Deutschland",
                                           "Übrige")),
    Summe = Summe / 1000  # convert to millions
  )

# Plot -----------------------

plot90894 <- ggplot(data90894_modified) +
  
  geom_col(aes(x = Ware, y = Summe, fill = Zielland)) +
  
  scale_fill_manual(name = "Exporte in Millionen Franken",
                    values = c("England" = "#F7CB45",
                               "Deutschland" = "#90C987",
                               "USA" = "#F7F056",
                               "Frankreich" = "#6195CF",
                               "Übrige" = "#777777")) +
  
  scale_x_discrete(expand = expansion(mult = c(0, 0))) +

  scale_y_continuous(
    breaks = seq(0, 35, 5),
    limits = c(0, 35.1),
    expand = expansion(mult = c(0, 0)),
    labels = ch_numbers
  ) +
  
  coord_cartesian(clip = "off") +
  coord_flip() +
  
  theme_sgb_basis() +
  theme(
    legend.position = "none",
    legend.title = element_text(color = "black", size = 6.5),
    legend.key.height = unit(2.5, "mm"), # entspricht 2 mm
    legend.key.width = unit(5, "mm"), # entspricht 4.5 mm
    axis.ticks.y = element_blank(),
    axis.text.y = element_text(margin = margin(r = 5),
                               hjust = 1),
    panel.grid.major.x = element_line(color = "black", linewidth = 0.14),
    panel.grid.major.y = element_blank(),
    plot.margin = margin(0,1,0,0, "lines")
  )

# Export -----------------------

export_plot(plot90894, 6, 120, 55, 33, 20)