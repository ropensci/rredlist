#' Search by taxon name or IUCN id
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
rl_search <- function(name = NULL, id = NULL, region = NULL, key = NULL, parse = TRUE, ...) {
  rl_parse(rl_search_(name, id, region, key, ...), parse)
}

#' @export
#' @rdname rl_search
rl_search_ <- function(name = NULL, id = NULL, region = NULL, key = NULL, ...) {
  rr_GET(.search(name, id, region), key, ...)
}

.search <- function(name = NULL, id = NULL, region = NULL) {
  stopifnot(xor(!is.null(name), !is.null(id)))
  path <- if (!is.null(name)) {
    file.path("species", name)
  } else {
    file.path("species/id", id)
  }
  if (!is.null(region)) {
    path <- file.path(path, "region", region)
  }
  path
}
