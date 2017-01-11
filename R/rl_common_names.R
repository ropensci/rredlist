#' Get common names for a given taxonomic name
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
  assert_is(parse, 'logical')
  rl_parse(rl_common_names_(name, key, ...), parse)
}

#' @export
#' @rdname rl_common_names
rl_common_names_ <- function(name = NULL, key = NULL, ...) {
  assert_is(key, 'character')
  assert_is(name, 'character')
  assert_n(name, 1)
  rr_GET(file.path("species/common_names", space(name)), key, ...)
}
