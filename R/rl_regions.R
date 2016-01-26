#' Get regions
#'
#' @export
#' @template all
#' @template info
#' @examples \dontrun{
#' rl_regions()
#' rl_regions(parse = FALSE)
#' rl_regions_()
#' }
rl_regions <- function(key = NULL, parse = TRUE, ...) {
  rl_parse(rl_regions_(key, ...), parse)
}

#' @export
#' @rdname rl_regions
rl_regions_ <- function(key = NULL, ...) {
  rr_GET("region/list", key, ...)
}
