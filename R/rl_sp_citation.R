#' Get citations
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
rl_sp_citation <- function(name = NULL, id = NULL, region = NULL, key = NULL, parse = TRUE, ...) {
  rl_parse(rl_sp_citation_(name, id, region, key, ...), parse)
}

#' @export
#' @rdname rl_sp_citation
rl_sp_citation_ <- function(name = NULL, id = NULL, region = NULL, key = NULL, ...) {
  rr_GET(.sp_citation(name, id, region), key, ...)
}

.sp_citation <- function(name = NULL, id = NULL, region = NULL) {
  stopifnot(xor(!is.null(name), !is.null(id)))
  path <- if (!is.null(name)) {
    file.path("species/citation", name)
  } else {
    file.path("species/citation/id", id)
  }
  if (!is.null(region)) {
    path <- file.path(path, "region", region)
  }
  path
}
