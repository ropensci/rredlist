#' Get species narrative information by taxon name or IUCN id
#'
#' @export
#' @param name (character) Binomial taxonomic name
#' @template all
#' @template info
#' @examples \dontrun{
#' rl_synonyms('Loxodonta africana')
#' rl_synonyms('Loxodonta africana', parse = FALSE)
#' rl_synonyms_('Loxodonta africana')
#' }
rl_synonyms <- function(name = NULL, key = NULL, parse = TRUE, ...) {
  rl_parse(rl_synonyms_(name, key, ...), parse)
}

#' @export
#' @rdname rl_synonyms
rl_synonyms_ <- function(name = NULL, key = NULL, ...) {
  rr_GET(file.path("species/synonym", name), key, ...)
}
