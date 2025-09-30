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

source(here("src", "92209", "92209_clean.R"))

data92209 <- data92209[, -5]

# Transform Data -------------

data92209_longer <- pivot_longer(data92209,
  cols = !Jahr,
  names_to = "Bürgerrecht",
  values_to = "Anzahl"
)

# Diagramm plotten -----------

plot92209 <- ggplot(
  data = data92209_longer,
  aes(x = Jahr, y = Anzahl, fill = Bürgerrecht)
) +
  geom_area(alpha = 1) +
  scale_fill_manual(
    values = c("#6195CF", "#90C987", "#F7CB45"),
    labels = c(
      "Ausländische Staatsbürgerschaft",
      "Basler Bürgerrecht",
      "Bürgerrecht eines anderen\nSchweizer Kantons"
    )
  ) +
  scale_x_continuous(
    breaks = pretty_breaks(),
    guide = guide_axis(),
    expand = expansion(mult = c(0, 0.005))
  ) +
  scale_y_continuous(
    limits = c(0, 140000),
    breaks = pretty_breaks(),
    expand = expansion(mult = c(0, 0)),
    labels = ch_numbers
  ) +
  coord_cartesian(clip = "off") +
  theme_sgb_basis() +
  theme(
    legend.position = "none",
    plot.margin = margin(0.5, 1, 0, 0.5, "lines"),
    axis.text.y = element_text(
      margin = margin(r = 5),
      hjust = 1
    ),
    legend.key.height = unit(2.5, "mm"), # entspricht 2 mm
    legend.key.width = unit(5, "mm") # entspricht 4.5 mm
  )

# Write Info Page ------------

write_info_page(
  plot_obj = plot92209,
  plot_id = 92209,
  volume = 6,
  csv_suffix = 3
)

# Export ---------------------

export_plot(plot92209, 6, 120, 60, 45, 12,
  plot_suffix = 1,
  legend_suffix = 2
)
