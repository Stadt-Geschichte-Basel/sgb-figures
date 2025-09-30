# Funktion, um auf x-/y-Achse jeweils alle ticks,
# aber nur jedes zweite Label anzuzeigen:

# Ziel: Achsenbeschriftungen entwirren

everysecond <- function(x) {
  x <- sort(unique(x))
  x[seq(2, length(x), 2)] <- ""
  x
}