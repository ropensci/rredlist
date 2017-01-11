#' Get species conservation measures by taxon name, IUCN id, and region
#'
#' @export
#' @template commonargs
#' @template all
#' @template info
#' @examples \dontrun{
#' rl_measures('Fratercula arctica')
#' rl_measures('Fratercula arctica', region = 'europe')
#' rl_measures(id = 12392)
#' rl_measures(id = 22694927, region = 'europe')
#'
#' rl_measures_('Fratercula arctica')
#' rl_measures_(id = 22694927, region = 'europe')
#' }
rl_measures <- function(name = NULL, id = NULL, region = NULL,
                        key = NULL, parse = TRUE, ...) {
  assert_is(parse, 'logical')
  rl_parse(rl_measures_(name, id, region, key, ...), parse)
}

#' @export
#' @rdname rl_measures
rl_measures_ <- function(name = NULL, id = NULL, region = NULL,
                         key = NULL, ...) {
  assert_is(key, 'character')
  rr_GET(nir("measures/species/name", "measures/species/id",
             name, id, region), key, ...)
}
