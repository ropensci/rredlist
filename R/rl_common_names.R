#' Get species narrative information by taxon name or IUCN id
#'
#' @export
#' @param name (character) Binomial taxonomic name
#' @template all
#' @template info
#' @examples \dontrun{
#' rl_common_names('Loxodonta africana')
#' rl_common_names_('Loxodonta africana')
#' }
rl_common_names <- function(name = NULL, key = NULL, parse = TRUE, ...) {
  rl_parse(rl_common_names_(name, key, ...), parse)
}

#' @export
#' @rdname rl_common_names
rl_common_names_ <- function(name = NULL, key = NULL, ...) {
  rr_GET(file.path("species/common_names", name), key, ...)
}
