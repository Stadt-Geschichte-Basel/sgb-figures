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

#data81313 <- readr::read_csv(here("Band8", "81313", "81313_Data_processed.csv"))
source(here("src", "81313", "81313_clean.R"))

# Transform Data ------------------

data81313_longer <- data81313 %>%
  pivot_longer(cols = -Nationalität,
               names_to = "Jahr",
               values_to = "Anzahl",
               names_prefix = "'",
               names_transform = list(Jahr = as.numeric)) %>%
  mutate(Jahr = gsub("'", "", Jahr)) %>%
  mutate(Jahr = as.numeric(Jahr))

# Plot -----------------------

plot81313 <- ggplot(data81313_longer, aes(x = Jahr, y = Anzahl,
                                          fill = Nationalität)) +
  
  geom_area(alpha = 1) +
  
  scale_x_continuous(
    breaks = pretty_breaks(),
    guide = guide_axis(),
    expand = expansion(mult = c(0, 0.005))
  ) +
  
  scale_y_continuous(
    limits = c(0, 80000),
    breaks = seq(0, 80000, 20000),
    expand = expansion(mult = c(0, 0)),
    labels = ch_numbers
  ) +
  
  scale_fill_manual(values = c("Italien" = "#90C987",
                               "Spanien" = "#882E72",
                               "Portugal" = "#CAACCB",
                               "Türkei" = "#DC050C",
                               "Ehemaliges Jugoslawien" = "#F7F056",
                               "Deutschland" = "#F7CB45",
                               "Frankreich" = "#6195CF",
                               "Übriges Ausland" = "#7BAFDE")) +
    
  coord_cartesian(clip = "off") + 
  
  theme_sgb_basis() +
  theme(
    legend.position = "none",
    legend.key.width = unit(5, "mm"), # resultiert in 4 mm
    legend.key.height = unit(2.5, "mm"), # resultiert in 2 mm
    axis.text.y = element_text(margin = margin(r = 5),
                               hjust = 1),
    plot.margin = margin(0.5,0.9,0,0, "lines")
  )

# Export -----------------------

export_plot(plot81313, 8, 140, 70, 38, 21)