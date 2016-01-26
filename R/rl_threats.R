#' Get species threats by taxon name or IUCN id
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
#' }
rl_threats <- function(name = NULL, id = NULL, region = NULL, key = NULL, parse = TRUE, ...) {
  rl_parse(rl_threats_(name, id, region, key, ...), parse)
}

#' @export
#' @rdname rl_threats
rl_threats_ <- function(name = NULL, id = NULL, region = NULL, key = NULL, ...) {
  rr_GET(.threats(name, id, region), key, ...)
}

.threats <- function(name = NULL, id = NULL, region = NULL) {
  stopifnot(xor(!is.null(name), !is.null(id)))
  path <- if (!is.null(name)) {
    file.path("threats/species/name", name)
  } else {
    file.path("threats/species/id", id)
  }
  if (!is.null(region)) {
    path <- file.path(path, "region", region)
  }
  path
}
