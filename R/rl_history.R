#' Get historical assessments by taxon name, IUCN id, and region
#'
#' @export
#' @template commonargs
#' @template all
#' @template info
#' @examples \dontrun{
#' rl_history('Loxodonta africana')
#' rl_history('Ursus maritimus', region = 'europe')
#' rl_history(id = 12392)
#' rl_history(id = 22823, region = 'europe')
#'
#' rl_history_('Loxodonta africana')
#' rl_history_(id = 12392)
#' }
rl_history <- function(name = NULL, id = NULL, region = NULL,
                       key = NULL, parse = TRUE, ...) {
  assert_is(parse, 'logical')
  rl_parse(rl_history_(name, id, region, key, ...), parse)
}

#' @export
#' @rdname rl_habitats
rl_history_ <- function(name = NULL, id = NULL, region = NULL,
                        key = NULL, ...) {
  assert_is(key, 'character')
  rr_GET(nir("species/history/name", "species/history/id",
             name, id, region), key, ...)
}
