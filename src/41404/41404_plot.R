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

source(here("src", "41404", "41404_clean.R"))

# Transform Data -------------

data41404_korrektionen <- subset(
  data41404,
  !(is.na(Gewässerkorrektionen))
)

# Plot -----------------------

plot41404 <- ggplot(
  data = data41404,
  aes(x = Jahr)
) +
  geom_segment(
    data = data41404_korrektionen,
    aes(
      x = Jahr, y = 0,
      xend = Jahr, yend = max(`Q [m3/s]`),
      color = "Korrekturen"
    ),
    linewidth = 0.8415
  ) +
  geom_line(
    aes(y = `gleitender 100 jähriger MW`, color = "MW_100"),
    linewidth = 0.561
  ) +
  geom_segment(
    aes(
      x = Jahr, y = 0,
      xend = Jahr, yend = `Q [m3/s]`,
      color = "Q_m3s"
    ),
    linewidth = 0.185,
    alpha = 0.8
  ) +
  scale_x_continuous(
    breaks = seq(1300, 2021, by = 50),
    guide = guide_axis(angle = 0),
    expand = expansion(mult = c(0, 0))
  ) +
  scale_y_continuous(
    limits = c(0, 8000),
    breaks = seq(0, 8000, by = 2000),
    expand = expansion(mult = c(0, 0)),
    labels = ch_numbers
  ) +
  scale_color_manual(
    name = "",
    values = c(
      "Korrekturen" = "#F7CB45",
      "MW_100" = "#A5170E",
      "Q_m3s" = "#777777"
    ),
    breaks = c(
      "MW_100",
      "Q_m3s",
      "Korrekturen"
    ),
    labels = c(
      "100-jähriges gleitendes Hochwasserabflussmittel  \n der rekonstruierten sowie aller gemessenen  \n Jahresabflussmaxima",
      bquote("Abflussmenge Q in" ~ m^3 / s),
      "Gewässerkorrektionen:  \n ab 1714: Kanderkorrektion  \n ab 1878: Juragewässerkorrektion"
    ),
    guide = guide_legend(
      override.aes = list(
        linewidth = c(0.561, 0.185, 0.8415),
        alpha = c(1, 0.8, 1)
      ),
      ncol = 1
    )
  ) +
  coord_cartesian(clip = "off") +
  theme_sgb_basis() +
  theme(
    legend.position = "none",
    axis.text.y = element_text(
      margin = margin(r = 5),
      hjust = 1
    ),
    plot.margin = margin(0.5, 0.5, 0, 0.3, "lines")
  )

# Write Info Page ------------

write_info_page(
  plot_obj = plot41404,
  plot_id = 41404,
  volume = 3,
  csv_suffix = 3
)

# Export ---------------------

export_plot(plot41404, 3, 140, 55.6, 65, 23,
  plot_suffix = 1,
  legend_suffix = 2
)
