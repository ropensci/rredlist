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
  rr_GET(nir("species/countries/name", "species/countries/id",
             name, id, region), key, ...)
}
