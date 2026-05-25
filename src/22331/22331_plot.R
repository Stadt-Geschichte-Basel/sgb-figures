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

source(here("src", "22331", "22331_clean.R"))

# Plot -----------------------

plot22331 <- ggplot(
  data22331,
  aes(x = Jahr, y = `Ausgaben pro 1000 Einwohner in CHF`)
) +
  geom_bar(aes(fill = "Ausgaben"), stat = "identity") +
  scale_fill_manual(
    values = c("Ausgaben" = "#6195CF"),
    labels = c("Staatsausgaben für Musik und Theater\npro 100'000 Einwohner:innen in CHF")
  ) +
  scale_x_continuous(
    breaks = c(1913, 1920, 1930, 1940, 1950, 1960, 1966),
    guide = guide_axis(angle = 0),
    expand = expansion(mult = c(0, 0))
  ) +
  scale_y_continuous(
    limits = c(0, 55000),
    breaks = seq(0, 55000, by = 5000),
    expand = expansion(mult = c(0, 0)),
    labels = ch_numbers
  ) +
  scale_color_identity(
    name = "",
    breaks = c("#6195CF"),
    labels = c("Staatsausgaben für Musik und Theater\npro 100'000 Einwohner:innen in CHF"),
    guide = "legend"
  ) +
  coord_cartesian(clip = "off") +
  theme_sgb_basis() +
  theme(
    legend.position = "none",
    axis.ticks.x = element_blank(),
    axis.text.y = element_text(
      margin = margin(r = 5),
      hjust = 1
    ),
    legend.key.height = unit(2.05, "mm"), # entspricht 1.64mm
    legend.key.width = unit(4.8, "mm"), # entspricht 4mm
    legend.key.justification = "top",
    plot.margin = margin(0.5, 0.2, 0, 0, "lines")
  )

# Write Info Page ------------

write_info_page(
  plot_obj = plot22331,
  plot_id = 22331,
  volume = 7,
  csv_suffix = 3
)

# Export ---------------------

export_plot(plot22331, 7, 112, 66, 50, 7,
  plot_suffix = 1,
  legend_suffix = 2
)
