#' Search by taxon name, IUCN id, and region
#'
#' @export
#' @template commonargs
#' @template all
#' @template info
#' @examples \dontrun{
#' rl_search('Fratercula arctica')
#' rl_search('Fratercula arctica', region = 'europe')
#' rl_search(id = 12392)
#' rl_search(id = 22694927, region = 'europe')
#'
#' rl_search('Fratercula arctica', parse = FALSE)
#' rl_search_('Fratercula arctica')
#' rl_search_('Fratercula arctica', region = 'europe')
#' }
rl_search <- function(name = NULL, id = NULL, region = NULL,
                      key = NULL, parse = TRUE, ...) {
  assert_is(parse, 'logical')
  rl_parse(rl_search_(name, id, region, key, ...), parse)
}

#' @export
#' @rdname rl_search
rl_search_ <- function(name = NULL, id = NULL, region = NULL,
                       key = NULL, ...) {
  assert_is(key, 'character')
  rr_GET(nir("species", "species/id",
             name, id, region), key, ...)
}
