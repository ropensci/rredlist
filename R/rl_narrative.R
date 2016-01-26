#' Get species narrative information by taxon name or IUCN id
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
rl_narrative <- function(name = NULL, id = NULL, region = NULL, key = NULL, parse = TRUE, ...) {
  rl_parse(rl_narrative_(name, id, region, key, ...), parse)
}

#' @export
#' @rdname rl_narrative
rl_narrative_ <- function(name = NULL, id = NULL, region = NULL, key = NULL, ...) {
  rr_GET(.narrative(name, id, region), key, ...)
}

.narrative <- function(name = NULL, id = NULL, region = NULL) {
  stopifnot(xor(!is.null(name), !is.null(id)))
  path <- if (!is.null(name)) {
    file.path("species/narrative", name)
  } else {
    file.path("species/narrative/id", id)
  }
  if (!is.null(region)) {
    path <- file.path(path, "region", region)
  }
  path
}
