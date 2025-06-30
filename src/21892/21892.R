# Abb. 21892
# öffentliches Staatspersonal
# Umbruch, S. 96

# Packages -------------------

library(here)
library(ggplot2)
library(ggpubr)
library(reshape2)
library(readxl)
library(dplyr)
library(scales)

# Daten einlesen --------

data21892 <- read_excel(here("Band7/21892/21892_Data_raw.xlsx"))

data21892 <- data21892[,6:7]
data21892 <- data21892[-1,]

colnames(data21892) <- c("Jahr", "Öffentliches Personal pro 1000 EW")

data21892 <- data21892 %>% mutate_if(is.character, as.numeric)

write.csv(data21892, here("Band7/21892/21892_Data_processed.csv"))

# Diagramm plotten -----------

plot21892 <- ggplot(data = data21892, aes(x = Jahr)) +
  
  # Graph hinzufügen
  geom_line(aes(y = `Öffentliches Personal pro 1000 EW`,
                color = "#6195CF"),
                linewidth = 0.561) +

  # Label-Formatierung für die x-Achse
  scale_x_continuous(
    # nach Absprache: Start bei 1912 passend zum Zeitrahmen des Buchs
    breaks = c(1912, 1920, 1930, 1940, 1950, 1963),
    limits = c(1912, 1963),
    guide = guide_axis(angle = 0), # zentriert Labels passend zu ticks
    expand = expansion(mult = c(0, 0)),
  ) +
  xlab("Jahr") +
  
  # A Label-Formatierung für die y-Achse
  #scale_y_continuous(
  #  limits = c(0, 50),
  #  breaks = seq(0, 50, by = 10),
  #  expand = expansion(mult = c(0, 0)),
  #  labels = comma_format(big.mark = " "),
  #) +
  
  # B Label-Formatierung für die y-Achse
  # ALTERNATIVE Achse, bisschen effekthascherende Darstellung
  # so wie in Umbruch 3 mit Achsenkreuz bei y = 20 
  scale_y_continuous(
    limits = c(25, 50),
    breaks = seq(0, 50, by = 5),
    expand = expansion(mult = c(0, 0)),
    labels = comma_format(big.mark = " "),
  ) +
  
  # y-Achsenbeschriftung als Titel hinzufügen
  ylab("") +
  ggtitle("") +
  
  # Legende hinzufügen
  scale_color_identity(
    breaks = c("#6195CF"),
    labels = c("Öffentliches Personal pro 1000 Einwohner:innen"),
    guide = "legend"
  ) +
  
  # Formatierung der Plot-Ausgabe
  coord_cartesian(clip = "off") + # Cut-Off an den Rändern deaktivieren
  
  theme(
    plot.title = element_text(color = "black", size = 6.5),
    plot.title.position = "plot", # Beschriftung an Plot-Grenzen ausrichten
    
    axis.title.x = element_blank(),
    axis.title.y = element_text(color = "black", angle = 0, size = 6.5),

    axis.text.x = element_text(size = 6.5, color = "black"),
    axis.text.y = element_text(size = 6.5, color = "black"),
    
    axis.line.x.bottom = element_line(color = "black", linewidth = 0.14),
    axis.line.y = element_line(color = "black", linewidth = 0.14),

    axis.ticks.x = element_line(color = "black", linewidth = 0.14),
    axis.ticks.y = element_line(color = "black", linewidth = 0.14),
    
    # Grid Lines formatieren
    panel.grid.major.y = element_line(color = "black", linewidth = 0.14),
    panel.grid.major.x = element_blank(),
    
    # Hintergrundfarben auf Transparenz
    panel.background = element_rect(fill = "transparent", color = NA),
    plot.background = element_rect(fill = "transparent"),
    
    # Legende formatieren
    legend.key = element_rect(fill = "transparent", colour = NA),
    legend.direction = "vertical",
    legend.key.width = unit(5, "mm"), # resultiert in 4 mm
    
    legend.title = element_blank(),
    legend.text = element_text(color = "black", size = 6.5),
    
    # "none" oder "right", none für Export ohne Legende (s.u.)
    legend.position = "none"
  )

plot21892


# Plot exportieren -----------

ggsave(
  plot = plot21892,
  filename = here("Band7/21892/21892_Plot_OutputR.pdf"),
  bg = "transparent",
  #width = 68.5, height = 41.4, units = "mm"
  # Masse von icona, Platz für insg. zwei Grafiken dieser Grösse
  # jeweils +4 wegen Export und PDF-Cropping
  width = 72.5, height = 45.4, units = "mm"
)

# Legende extrahieren --------

# Anmerkung: im Buch gibt es eine Legende für 21892 und 21912 zusammen,
# die separat erstellt ist (ggfs. Legende aber auch überflüssig hier)

legende21892 <- get_legend(plot21892)

as_ggplot(legende21892)

ggsave(legende21892,
       filename = here("Band7/21892/21892_Legende_OutputR.pdf"),
       bg = "transparent"
)