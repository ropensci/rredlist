#' Get species
#'
#' @export
#' @param page (interger) Page to get. Default: 1
#' @template all
#' @examples \dontrun{
#' rl_sp(page = 3)
#' }
rl_sp <- function(page, key = NULL, parse = TRUE, ...) {
  rl_parse(rl_sp_(page, key, ...), parse)
}

#' @export
#' @rdname rl_sp
rl_sp_ <- function(page, key = NULL, ...) {
  rr_GET(file.path("species/page", page), key, ...)
}
