# Packages -------------------

library(here)
library(ggplot2)
library(tidyr)
library(scales)
library(dplyr)

# Functions ------------------

source(here("src", "Utils", "Format_Theme.R"))
source(here("src", "Utils", "Format_Tausendertrennzeichen.R"))
source(here("src", "Utils", "Format_Achsenbeschriftung.R"))
source(here("src", "Utils", "Export_Plot.R"))
source(here("src", "Utils", "Write_InfoPage.R"))

# Read Data ------------------

source(here("src", "76999", "76999_clean.R"))

# Plot -----------------------

plot76999 <- ggplot(data76999, aes(
  x = `Anzahl Wohnungen`,
  y = reorder(Eigentümer, `Anzahl Wohnungen`)
)) +
  geom_bar(
    stat = "identity",
    aes(fill = "Anzahl Wohnungen")
  ) +
  scale_x_continuous(
    limits = c(0, 3001.5),
    breaks = seq(0, 3000, 500),
    expand = expansion(mult = c(0, 0)),
    labels = ch_numbers
  ) +
  scale_fill_manual(
    values = c("Anzahl Wohnungen" = "#3f7653")
  ) + # Bandfarbe 9

  coord_cartesian(clip = "off") +
  theme_sgb_basis() +
  theme(
    panel.grid.major.x = element_line(color = "black", linewidth = 0.14),
    panel.grid.major.y = element_blank(),
    axis.ticks.y = element_blank(),
    axis.text.y = element_text(
      margin = margin(r = 5),
      hjust = 1
    ),
    plot.margin = margin(0.1, 1.15, 0, 0.4, "lines"),
    legend.position = "none",
    legend.key.width = unit(5, "mm"), # resultiert in 4.5 mm
    legend.key.height = unit(2.5, "mm"), # resultiert in 2 mm
  )

# Write Info Page ------------

write_info_page(
  plot_obj = plot76999,
  plot_id = 76999,
  volume = 9,
  csv_suffix = 3
)

# Export ---------------------

export_plot(plot76999, 9, 144, 116, 30, 5,
  plot_suffix = 1,
  legend_suffix = 2
)
