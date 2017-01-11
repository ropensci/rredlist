#' Get species habitats by taxon name, IUCN id, and region
#'
#' @export
#' @template commonargs
#' @template all
#' @template info
#' @examples \dontrun{
#' rl_habitats('Fratercula arctica')
#' rl_habitats('Fratercula arctica', region = 'europe')
#' rl_habitats(id = 12392)
#' rl_habitats(id = 22694927, region = 'europe')
#'
#' rl_habitats_('Fratercula arctica')
#' rl_habitats_(id = 12392)
#' }
rl_habitats <- function(name = NULL, id = NULL, region = NULL, key = NULL,
                        parse = TRUE, ...) {
  assert_is(parse, 'logical')
  rl_parse(rl_habitats_(name, id, region, key, ...), parse)
}

#' @export
#' @rdname rl_habitats
rl_habitats_ <- function(name = NULL, id = NULL, region = NULL,
                         key = NULL, ...) {
  assert_is(key, 'character')
  rr_GET(nir("habitats/species/name", "habitats/species/id",
         name, id, region), key, ...)
}
