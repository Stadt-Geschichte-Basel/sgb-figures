# Funktion, um gewünschtes Nummernformat
# mit Tausendertrennzeichen erst ab x >= 9999 zu erzeugen:

# unter 9999: "1000"
# über 9999: "12 000"

# zB für y-axis labels in ggplot

ch_numbers <- function(y) {
  out <- prettyNum(y, big.interval = 3L, big.mark = " ", scientific = FALSE)

  ifelse (y <= 9999, y, out)
}

# Funktion, um ein Sechstelgeviert als Tausendertrennzeichen
# zu nutzen. Bereitet bisher Schwierigkeiten bzgl. des PDF-Exports

ch_numbers_sechstelgeviert <- function(y) {
  out <- prettyNum(y, big.interval = 3L, big.mark = "\U2006", scientific = FALSE)
  
  ifelse (y <= 9999, y, out)
}