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

source(here("src", "22355", "22355_clean.R"))

# Transform Data -------------

# Manipulation von 1960 als 1959 und 1964 als 1962, damit gleiche Abstände im Plot erzielt werden
# Label bleibt bei Original-Daten
data22355$Jahr[17] <- 1959
data22355$Jahr[18] <- 1962

data22355_longer <- data22355 %>%
  pivot_longer(cols = -Jahr,
               names_to = "Partei",
               values_to = "Grossratsmandate")

party_colors <- c(
  "Partei der Arbeit" = "#8C2736",
  "Sozialdemokratische Partei" = "#F0554D",
  "Landesring der Unabhängigen" = "#1BAA6E",
  "Vereinigung Evangelischer Wähler" = "#DEAA28",
  "Kath. und Christlich-soziale Volkspartei" = "#D6862B",
  "Radikaldemokratische Partei" = "#3872B5",
  "Liberaldemokratische Bürgerpartei" = "#618DEA",
  "Bürger- und Gewerbepartei" = "#4B8A3E",
  "Andere Parteien" = "#777777"
)

data22355_longer$Partei <- factor(data22355_longer$Partei,
                                  levels = c(
                                    "Partei der Arbeit",
                                    "Sozialdemokratische Partei",
                                    "Landesring der Unabhängigen",
                                    "Vereinigung Evangelischer Wähler",
                                    "Kath. und Christlich-soziale Volkspartei",
                                    "Radikaldemokratische Partei",
                                    "Liberaldemokratische Bürgerpartei",
                                    "Bürger- und Gewerbepartei",
                                    "Andere Parteien"
                                  ))

# Plot -----------------------

plot22355 <- ggplot(data22355_longer,
                    aes(x = Jahr,
                        y = Grossratsmandate,
                        fill = Partei)
                        ) +

  geom_bar(stat = "identity", position = "stack") +
  
  scale_fill_manual(values = party_colors,
                    labels = c("KP und PdA", "SP", "LdU", "EVP und VEW", "KVP", "RDP", "LP und LDP", "BGP und NVP", "Andere")) +
  
  scale_x_continuous(
    breaks = data22355$Jahr,
    labels = c("1911", "1914", "1917", "1920", "1923", "1926", "1929", "1932", "1935", "1938", "1941", "1944", "1947", "1950", "1953", "1956", "1960", "1964"),
    guide = guide_axis(angle = 45),
    expand = expansion(mult = c(0, 0))
  ) +
  
  scale_y_continuous(
    breaks = seq(10, 130, by = 20),
    labels = waiver(),
    expand = expansion(mult = c(0, 0))
  ) +
  
  guides(fill = guide_legend(ncol = 2)) +
  
  coord_cartesian(clip = "off") + 
  
  theme_sgb_basis() +
  theme(
    legend.position = "none",
    legend.key.width = unit(5, "mm"), # resultiert in 4 mm
    legend.key.height = unit(2.5, "mm"), # resultiert in 2 mm
    axis.ticks.x = element_blank(),
    axis.text.y = element_text(margin = margin(r = 5),
                               hjust = 1),
    plot.margin = margin(0.5,0.2,0,0, "lines")
  )

# Export ---------------------

export_plot(plot22355, 7, 111, 76, 50, 15)