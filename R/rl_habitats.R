#' Get species habitats by taxon name or IUCN id
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
rl_habitats <- function(name = NULL, id = NULL, region = NULL, key = NULL, parse = TRUE, ...) {
  rl_parse(rl_habitats_(name, id, region, key, ...), parse)
}

#' @export
#' @rdname rl_habitats
rl_habitats_ <- function(name = NULL, id = NULL, region = NULL, key = NULL, ...) {
  rr_GET(.habitats(name, id, region), key, ...)
}

.habitats <- function(name = NULL, id = NULL, region = NULL) {
  stopifnot(xor(!is.null(name), !is.null(id)))
  path <- if (!is.null(name)) {
    file.path("habitats/species/name", name)
  } else {
    file.path("habitats/species/id", id)
  }
  if (!is.null(region)) {
    path <- file.path(path, "region", region)
  }
  path
}
