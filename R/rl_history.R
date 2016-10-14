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
rl_history <- function(name = NULL, id = NULL, region = NULL, key = NULL, parse = TRUE, ...) {
  rl_parse(rl_history_(name, id, region, key, ...), parse)
}

#' @export
#' @rdname rl_habitats
rl_history_ <- function(name = NULL, id = NULL, region = NULL, key = NULL, ...) {
  rr_GET(.history(name, id, region), key, ...)
}

.history <- function(name = NULL, id = NULL, region = NULL) {
  stopifnot(xor(!is.null(name), !is.null(id)))
  path <- if (!is.null(name)) {
    file.path("species/history/name", space(name))
  } else {
    file.path("species/history/id", id)
  }
  if (!is.null(region)) {
    path <- file.path(path, "region", space(region))
  }
  path
}
