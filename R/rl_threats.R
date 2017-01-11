#' Get species threats by taxon name, IUCN id, and region
#'
#' @export
#' @template commonargs
#' @template all
#' @template info
#' @examples \dontrun{
#' rl_threats('Fratercula arctica')
#' rl_threats('Fratercula arctica', region = 'europe')
#' rl_threats(id = 12392)
#' rl_threats(id = 22694927, region = 'europe')
#' rl_threats_('Fratercula arctica')
#'
#' rl_threats(id = 62290750)
#' }
rl_threats <- function(name = NULL, id = NULL, region = NULL, key = NULL,
                       parse = TRUE, ...) {
  assert_is(parse, 'logical')
  rl_parse(rl_threats_(name, id, region, key, ...), parse)
}

#' @export
#' @rdname rl_threats
rl_threats_ <- function(name = NULL, id = NULL, region = NULL,
                        key = NULL, ...) {
  assert_is(key, 'character')
  rr_GET(nir("threats/species/name", "threats/species/id",
             name, id, region), key, ...)
}
