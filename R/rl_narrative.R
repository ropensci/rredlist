#' Get species narrative information by taxon name, IUCN id, and region
#'
#' @export
#' @template commonargs
#' @template all
#' @template info
#' @examples \dontrun{
#' rl_narrative('Fratercula arctica')
#' rl_narrative('Fratercula arctica', region = 'europe')
#' rl_narrative(id = 12392)
#' rl_narrative(id = 22694927, region = 'europe')
#'
#' rl_narrative_('Fratercula arctica')
#' rl_narrative_('Fratercula arctica', region = 'europe')
#' }
rl_narrative <- function(name = NULL, id = NULL, region = NULL,
                         key = NULL, parse = TRUE, ...) {
  assert_is(parse, 'logical')
  rl_parse(rl_narrative_(name, id, region, key, ...), parse)
}

#' @export
#' @rdname rl_narrative
rl_narrative_ <- function(name = NULL, id = NULL, region = NULL,
                          key = NULL, ...) {
  assert_is(key, 'character')
  rr_GET(nir("species/narrative", "species/narrative/id",
             name, id, region), key, ...)
}
