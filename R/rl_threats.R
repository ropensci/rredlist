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
  rr_GET(.threats(name, id, region), key, ...)
}

.threats <- function(name = NULL, id = NULL, region = NULL) {
  stopifnot(xor(!is.null(name), !is.null(id)))
  assert_is(name, 'character')
  assert_is(id, c('integer', 'numeric'))
  assert_is(region, 'character')
  assert_n(name, 1)
  assert_n(id, 1)
  assert_n(region, 1)
  path <- if (!is.null(name)) {
    file.path("threats/species/name", space(name))
  } else {
    file.path("threats/species/id", id)
  }
  if (!is.null(region)) {
    path <- file.path(path, "region", space(region))
  }
  path
}
