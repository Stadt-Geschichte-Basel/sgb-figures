typeline <- function(msg) {
  if (interactive()) {
    readline(msg)
  } else {
    cat(msg)
    readLines("stdin", n = 1)
  }
}

txt <- typeline("Bitte ID des Plots eingeben (z.B. 39017 für abb39017): ")

path <- here::here("src", txt, paste0(txt, "_plot.R"))

source(path)
