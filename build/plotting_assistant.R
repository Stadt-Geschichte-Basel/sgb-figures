typeline <- function(msg) {
  if (interactive()) {
    txt <- readline(msg)
  } else {
    cat(msg)
    txt <- readLines("stdin", n = 1)
  }
  return(txt)
}

txt <- typeline("Bitte ID des Plots eingeben (z.B. 39017 für abb39017): ")

path <- here::here("src", txt, paste0(txt, "_plot.R"))

source(path)
