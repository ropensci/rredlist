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
  rr_GET(.sp_citation(name, id, region), key, ...)
}

.sp_citation <- function(name = NULL, id = NULL, region = NULL) {
  stopifnot(xor(!is.null(name), !is.null(id)))
  assert_is(name, 'character')
  assert_is(id, c('integer', 'numeric'))
  assert_is(region, 'character')
  assert_n(name, 1)
  assert_n(id, 1)
  assert_n(region, 1)
  path <- if (!is.null(name)) {
    file.path("species/citation", space(name))
  } else {
    file.path("species/citation/id", id)
  }
  if (!is.null(region)) {
    path <- file.path(path, "region", space(region))
  }
  path
}
