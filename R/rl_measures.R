#' Get species conservation measures by taxon name or IUCN id
#'
#' @export
#' @template commonargs
#' @template all
#' @template info
#' @examples \dontrun{
#' rl_measures('Fratercula arctica')
#' rl_measures('Fratercula arctica', region = 'europe')
#' rl_measures(id = 12392)
#' rl_measures(id = 22694927, region = 'europe')
#'
#' rl_measures_('Fratercula arctica')
#' rl_measures_(id = 22694927, region = 'europe')
#' }
rl_measures <- function(name = NULL, id = NULL, region = NULL, key = NULL, parse = TRUE, ...) {
  rl_parse(rl_measures_(name, id, region, key, ...), parse)
}

#' @export
#' @rdname rl_measures
rl_measures_ <- function(name = NULL, id = NULL, region = NULL, key = NULL, ...) {
  rr_GET(.measures(name, id, region), key, ...)
}

.measures <- function(name = NULL, id = NULL, region = NULL) {
  stopifnot(xor(!is.null(name), !is.null(id)))
  path <- if (!is.null(name)) {
    file.path("measures/species/name", name)
  } else {
    file.path("measures/species/id", id)
  }
  if (!is.null(region)) {
    path <- file.path(path, "region", region)
  }
  path
}
