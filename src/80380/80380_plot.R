# Packages -------------------

library(here)
library(ggplot2)
library(tidyr)
library(scales)
library(dplyr)

# Functions ------------------

source(here("src", "Funktionen", "Format_Theme.R"))
source(here("src", "Funktionen", "Format_Tausendertrennzeichen.R"))
source(here("src", "Funktionen", "Format_Achsenbeschriftung.R"))
source(here("src", "Funktionen", "Export_Plot.R"))

# Read Data ------------------

source(here("src", "80380", "80380_clean.R"))

# Transform Data -------------

colnames(data80380) <- c("Tageszeitungen\n(total verkaufte Auflage Print,\nexkl. Gratisauflage)",
                         1966, 1971, 1972, 1973, 1975, 1978, 1984, 1985, 1990, 1991, 1992, 1996, 2002, 2008, 2014, 2020)

## fix cutoff
data80380$`Tageszeitungen\n(total verkaufte Auflage Print,\nexkl. Gratisauflage)`[4] <- "Basellandschaftliche Zeitung\n(ab 2019 bz – Zeitung für die Region Basel)"

data_long <- data80380 %>%
  pivot_longer(cols = -`Tageszeitungen\n(total verkaufte Auflage Print,\nexkl. Gratisauflage)`,
               names_to = "Jahr",
               values_to = "Auflage",
               names_prefix = "'",
               names_transform = list(Jahr = as.numeric)) %>%
  mutate(Jahr = gsub("'", "", Jahr)) %>%
  mutate(Jahr = as.numeric(Jahr))

# Create Plot ------------------

plot80380 <- ggplot(data_long, aes(x = Jahr, y = Auflage,
                                  color = `Tageszeitungen\n(total verkaufte Auflage Print,\nexkl. Gratisauflage)`,
                                  group = `Tageszeitungen\n(total verkaufte Auflage Print,\nexkl. Gratisauflage)`)) +
  geom_line(data = na.omit(data_long),
            linewidth = 0.561) +
            
  geom_point() +

  scale_x_continuous(
    breaks = pretty_breaks(),
    guide = guide_axis(),
    expand = expansion(mult = c(0, 0.005))
  ) +
  
  scale_y_continuous(
    limits = c(0, 120000),
    breaks = pretty_breaks(),
    expand = expansion(mult = c(0, 0)),
    labels = ch_numbers
  ) +
  
  scale_color_manual(values = c("AZ Abend-Zeitung (Daten nur bis 1984)" = "#CAACCB",
                                "Basellandschaftliche Zeitung\n(ab 2019 bz – Zeitung für die Region Basel)" = "#6195CF",
                                "Basler Nachrichten" = "#4EB265",
                                "Basler Volksblatt (ab 1982 Nordschweiz)" = "#EE8026",
                                "Basler Zeitung" = "#A5170E",
                                "National-Zeitung" = "#F7CB45")) +
  
  coord_cartesian(clip = "off") +
  
  guides(color = guide_legend(keyheight = unit(4.8, "mm"))) + # results in ca. 3mm
    
  theme_sgb_basis() +
  theme(
    legend.position = "none",
    axis.text.y = element_text(margin = margin(r = 5),
                               hjust = 1),
    plot.margin = margin(0.5,0.9,0,0, "lines")
  )

# Export ---------------------

export_plot(plot80380, 8, 120, 63, 57, 28)