#' Get country occurrence by species name or ID
#'
#' @export
#' @template commonargs
#' @template all
#' @template info
#' @examples \dontrun{
#' rl_occ_country('Loxodonta africana')
#' rl_occ_country('Fratercula arctica', region = 'europe')
#' rl_occ_country(id = 12392)
#' rl_occ_country(id = 22694927, region = 'europe')
#'
#' rl_occ_country('Fratercula arctica', parse = FALSE)
#' rl_occ_country_('Fratercula arctica')
#' rl_occ_country_('Fratercula arctica', region = 'europe')
#' }
rl_occ_country <- function(name = NULL, id = NULL, region = NULL,
                           key = NULL, parse = TRUE, ...) {
  assert_is(parse, 'logical')
  rl_parse(rl_occ_country_(name, id, region, key, ...), parse)
}

#' @export
#' @rdname rl_search
rl_occ_country_ <- function(name = NULL, id = NULL, region = NULL,
                            key = NULL, ...) {
  assert_is(key, 'character')
  rr_GET(.occ_country(name, id, region), key, ...)
}

.occ_country <- function(name = NULL, id = NULL, region = NULL) {
  stopifnot(xor(!is.null(name), !is.null(id)))
  assert_is(name, 'character')
  assert_is(id, c('integer', 'numeric'))
  assert_is(region, 'character')
  assert_n(name, 1)
  assert_n(id, 1)
  assert_n(region, 1)
  path <- if (!is.null(name)) {
    file.path("species/countries/name", space(name))
  } else {
    file.path("species/countries/id", id)
  }
  if (!is.null(region)) {
    path <- file.path(path, "region", space(region))
  }
  path
}
