#' Get species
#'
#' @export
#' @param page (integer/numeric) Page to get. Default: 1
#' @template all
#' @examples \dontrun{
#' rl_sp(page = 3)
#' }
rl_sp <- function(page, key = NULL, parse = TRUE, ...) {
  assert_is(parse, 'logical')
  rl_parse(rl_sp_(page, key, ...), parse)
}

#' @export
#' @rdname rl_sp
rl_sp_ <- function(page, key = NULL, ...) {
  assert_is(key, 'character')
  assert_is(page, c('integer', 'numeric'))
  assert_n(page, 1)
  rr_GET(file.path("species/page", page), key, ...)
}
