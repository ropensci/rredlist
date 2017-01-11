#' Get countries
#'
#' @export
#' @template all
#' @template info
#' @examples \dontrun{
#' rl_countries()
#' rl_countries_()
#' }
rl_countries <- function(key = NULL, parse = TRUE, ...) {
  assert_is(parse, 'logical')
  rl_parse(rl_countries_(key, ...), parse)
}

#' @export
#' @rdname rl_countries
rl_countries_ <- function(key = NULL, ...) {
  assert_is(key, 'character')
  rr_GET("country/list", key, ...)
}
