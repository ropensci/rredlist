#' Get species synonym information by taxonomic name
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
  assert_is(parse, 'logical')
  rl_parse(rl_synonyms_(name, key, ...), parse)
}

#' @export
#' @rdname rl_synonyms
rl_synonyms_ <- function(name = NULL, key = NULL, ...) {
  assert_is(key, 'character')
  assert_is(name, 'character')
  assert_n(name, 1)
  rr_GET(file.path("species/synonym", space(name)), key, ...)
}
