#' Links to further IUCN documentation for select rredlist functions
#'
#' Informational table listing functions that have further documentation on the IUCN site. Running `rl_metadata()` will return a data frame with links to these documents.
#' More information can be found at [the IUCN classification scheme page](https://www.iucnredlist.org/resources/classification-schemes)

rl_metadata <- function(){
  m <- read.table(file = "data-raw/metadata.txt", sep = ",", header = TRUE)
  DT::datatable(m, escape = FALSE)
}