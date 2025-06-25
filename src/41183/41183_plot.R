# Packages -------------------

library(here)
library(ggplot2)
library(tidyr)
library(scales)
library(dplyr)
library(zoo)

# Functions ------------------

source(here("src", "Funktionen", "Format_Theme.R"))
source(here("src", "Funktionen", "Format_Tausendertrennzeichen.R"))
source(here("src", "Funktionen", "Format_Achsenbeschriftung.R"))
source(here("src", "Funktionen", "Export_Plot.R"))

# Read Data ------------------

#data41183 <- readr::read_csv(here("Band3", "41183", "41183_Data.csv"))
source(here("src", "41183", "41183_clean.R"))

# Transform Data ------------------

# gleitende Durchschnitte
data41183 <- data41183 %>%
  mutate(BS_Roggen_glD = rollmean(`Basel: Roggen (hl in fl)`,
                                  k = 3, fill = "extend", align = "right"),
         Str_Roggen_glD = rollmean(`Strasbourg: Roggen (hl in fl)`,
                                   k = 3, fill = "extend", align = "right"),
         Str_Weizen_glD = rollmean(`Strasbourg: Weizen (hl in fl)`,
                                   k = 3, fill = "extend", align = "right"),
         Nürn_Roggen_glD = rollmean(`Nürnberg: Roggen (hl in fl)`,
                                    k = 3, fill = "extend", align = "right"),
         Köln_RoggenWeizen_glD = rollmean(`Köln: Roggen oder Weizen (hl in fl)`,
                                          k = 3, fill = "extend", align = "right"))

# Plot -----------------------

plot41183 <- ggplot(data = data41183, aes(x = Jahr)) +
  
  geom_line(aes(x = Jahr, y = BS_Roggen_glD, colour = "grün"),
            data = data41183,
            linewidth = 0.561) +
  
  geom_line(aes(x = Jahr, y = Str_Roggen_glD, colour = "blau13_1"),
            data = data41183,
            linewidth = 0.561) +
  
  geom_line(aes(x = Jahr, y = Str_Weizen_glD, colour = "blau13_2"),
            data = data41183,
            linewidth = 0.561,
            linetype = "dashed") +
  
  geom_line(aes(x = Jahr, y = Nürn_Roggen_glD, colour = "lila8"),
            data = data41183,
            linewidth = 0.561) +
  
  geom_line(aes(x = Jahr, y = Köln_RoggenWeizen_glD, colour = "gelb19"),
            data = data41183,
            linewidth = 0.561) +
  
  # unsichtbares Element für zusätzlichen Text in der Legende
  geom_blank(aes(x = 1440, y = 0, color = "text_note")) +
  
  scale_colour_manual("",
                      values = c("grün" = "#5f9883", # Basel
                                 "blau13_1" = "#6195CF", # Strassburg
                                 "blau13_2" = "#6195CF", # Strassburg
                                 "lila8" =  "#994F88", # Nürnberg
                                 "gelb19" = "#F7CB45", # Köln
                                 "text_note" = "transparent"), # Notiz unter der Legende
                        
                      labels = c("grün" = "Basel: Roggen",
                                 "blau13_1" = "Strassburg: Roggen",
                                 "blau13_2" = "Strassburg: Weizen",
                                 "lila8" = "Nürnberg: Roggen",
                                 "gelb19" = "Köln: Roggen oder Weizen",
                                 "text_note" = "Alle Preise pro hl in fl."),
                      
                      breaks = c("grün", "blau13_1", "blau13_2", "lila8", "gelb19", "text_note"),
                      
                      guide = guide_legend(override.aes = list(linetype = c("solid",
                                                                            "solid",
                                                                            "dashed",
                                                                            "solid",
                                                                            "solid",
                                                                            "blank")))) +

  scale_x_continuous(
    breaks = seq(1440, 1500, 5),
    guide = guide_axis(angle = 0),
    expand = expansion(mult = c(0, 0))
  ) +

  scale_y_continuous(
    limits = c(0, 1),
    breaks = seq(0, 1, by = 0.25),
    expand = expansion(mult = c(0, 0)),
    labels = ch_numbers
  ) +
  
  coord_cartesian(clip = "off") +
  
  theme_sgb_basis() +
  theme(legend.position = "none",
        axis.text.y = element_text(margin = margin(r = 5),
                                   hjust = 1),
        plot.margin = margin(0.5,1.2,0,0.5, "lines"))

# Export -----------------------

export_plot(plot41183, 3, 155, 66, 44, 35.5)