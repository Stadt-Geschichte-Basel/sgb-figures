# Funktion, um auf x-/y-Achse jeweils alle ticks,
# aber nur jedes zweite Label anzuzeigen:

# Ziel: Achsenbeschriftungen entwirren

everysecond <- function(x){
  x <- sort(unique(x))
  x[seq(2, length(x), 2)] <- ""
  x
}

# Anwendung der folgenden Funktion in ggplot:
# scale_x_discrete(breaks = every_nth(n = 3))

# Alternative: 
# funktioniert offenbar noch nicht so wie gedacht
every_nth <- function(n) {
  return(function(x) {x[c(TRUE, rep(FALSE, n - 1))]})
}