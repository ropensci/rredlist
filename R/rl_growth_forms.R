#' Get plant species growth forms by taxon name, IUCN id, and region
#'
#' @export
#' @template commonargs
#' @template all
#' @template info
#' @examples \dontrun{
#' rl_growth_forms('Quercus robur')
#' rl_growth_forms('Quercus robur', region = 'europe')
#' rl_growth_forms(id = 63532)
#' rl_growth_forms(id = 63532, region = 'europe')
#'
#' rl_growth_forms('Mucuna bracteata')
#' rl_growth_forms('Abarema villifera')
#' rl_growth_forms('Adansonia perrieri')
#' rl_growth_forms('Adenostemma harlingii')
#'
#' rl_growth_forms_('Quercus robur')
#' rl_growth_forms_(id = 63532, region = 'europe')
#' }
rl_growth_forms <- function(name = NULL, id = NULL, region = NULL,
                        key = NULL, parse = TRUE, ...) {
  assert_is(parse, 'logical')
  rl_parse(rl_growth_forms_(name, id, region, key, ...), parse)
}

#' @export
#' @rdname rl_growth_forms
rl_growth_forms_ <- function(name = NULL, id = NULL, region = NULL,
                         key = NULL, ...) {
  assert_is(key, 'character')
  rr_GET(nir("growth_forms/species/name", "growth_forms/species/id",
             name, id, region), key, ...)
}
