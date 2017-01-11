#' Get citations by taxon name, IUCN id, and region
#'
#' @export
#' @template commonargs
#' @template all
#' @template info
#' @examples \dontrun{
#' rl_sp_citation('Balaena mysticetus')
#' rl_sp_citation('Balaena mysticetus', region = 'europe')
#' rl_sp_citation(id = 12392)
#'
#' rl_sp_citation(id = 2467, region = 'europe')
#' rl_sp_citation(id = 2467, region = 'europe', parse = FALSE)
#' rl_sp_citation_(id = 2467, region = 'europe')
#' }
rl_sp_citation <- function(name = NULL, id = NULL, region = NULL,
                           key = NULL, parse = TRUE, ...) {
  assert_is(parse, 'logical')
  rl_parse(rl_sp_citation_(name, id, region, key, ...), parse)
}

#' @export
#' @rdname rl_sp_citation
rl_sp_citation_ <- function(name = NULL, id = NULL, region = NULL,
                            key = NULL, ...) {
  assert_is(key, 'character')
  rr_GET(nir("species/citation", "species/citation/id",
             name, id, region), key, ...)
}
