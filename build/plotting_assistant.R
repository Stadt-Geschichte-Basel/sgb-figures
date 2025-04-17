typeline <- function(msg) {
  if (interactive()) {
    txt <- readline(msg)
  } else {
    cat(msg);
    txt <- readLines("stdin", n = 1)
  }
  return(txt)
}

txt <- typeline("Please enter the plot ID (e.g. 39017 for abb39017): ")

path <- here::here("src", txt, paste0(txt, "_plot.R"))

source(path)