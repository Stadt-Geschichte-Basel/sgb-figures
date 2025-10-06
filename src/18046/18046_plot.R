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

source(here("src", "18046", "18046_clean.R"))

# Transform Data -------------

# Jahr 1652 auf der x-Achse mit Label 1653
data18046 <- data18046 %>%
  mutate(Jahr = case_when(
    Jahr == 1652 ~ 1653,
    TRUE ~ Jahr
  ))

# Plot -----------------------

plot18046 <- ggplot(data = data18046, aes(x = Jahr)) +
  geom_line(aes(y = `Dinkel (in Viernzeln)`, color = "Dinkel (in Viernzeln)"), linewidth = 0.561) +
  geom_line(aes(y = `Roggen (in Viernzeln)`, color = "Roggen (in Viernzeln)"), linewidth = 0.561) +
  geom_line(aes(y = `Hafer (in Viernzeln)`, color = "Hafer (in Viernzeln)"), linewidth = 0.561) +

  # unsichtbares Element für zusätzlichen Text in der Legende
  geom_blank(aes(x = 1613, y = 0, color = "Ein 'Viernzel' entsprach\nzwei 'Säcken' à je 137 l.")) +
  scale_x_continuous(
    breaks = c(1613, 1623, 1633, 1643, 1653),
    guide = guide_axis(angle = 45), # zentriert Labels passend zu ticks
    expand = expansion(mult = c(0, 0))
  ) +
  xlab("Jahr") +
  scale_y_continuous(
    limits = c(min(data18046, na.rm = TRUE), 8000),
    breaks = seq(0, 8000, by = 1000),
    expand = expansion(mult = c(0, 0)),
    labels = ch_numbers
  ) +
  scale_color_manual(
    name = "",
    values = c(
      "Dinkel (in Viernzeln)" = "#6195CF",
      "Roggen (in Viernzeln)" = "#F7CB45",
      "Hafer (in Viernzeln)" = "#90C987",
      "Ein 'Viernzel' entsprach\nzwei 'Säcken' à je 137 l." = "transparent"
    ),
    breaks = c(
      "Dinkel (in Viernzeln)",
      "Roggen (in Viernzeln)",
      "Hafer (in Viernzeln)",
      "Ein 'Viernzel' entsprach\nzwei 'Säcken' à je 137 l."
    ),
    guide = guide_legend(override.aes = list(
      linetype = c(1, 1, 1, 0)
    ))
  ) +
  coord_cartesian(clip = "off") + # Cut-Off an den Rändern deaktivieren

  guides(color = guide_legend(keyheight = unit(4.8, "mm"))) + # results in ca. 3mm

  theme_sgb_basis() +
  theme(
    legend.position = "none",
    axis.text.y = element_text(
      margin = margin(r = 5),
      hjust = 1
    ),
    plot.margin = margin(0.5, 0.9, 0, 0, "lines")
  )

# Write Info Page ------------

write_info_page(
  plot_obj = plot18046,
  plot_id = 18046,
  volume = 4,
  csv_suffix = 3
)

# Export ---------------------

export_plot(plot18046, 4, 124, 68, 35, 20,
  plot_suffix = 1,
  legend_suffix = 2
)
