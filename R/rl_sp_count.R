#' Species count
#'
#' @export
#' @template all
#' @template info
#' @examples \dontrun{
#' rl_sp_count()
#' rl_sp_count_()
#' }
rl_sp_count <- function(key = NULL, parse = TRUE, ...) {
  rl_parse(rl_sp_count_(key, ...), parse)
}

#' @export
#' @rdname rl_sp_count
rl_sp_count_ <- function(key = NULL, ...) {
  rr_GET("speciescount", key, ...)
}
