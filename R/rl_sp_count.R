#' Get total species count of taxa in the Red List
#'
#' @export
#' @template all
#' @template info
#' @examples \dontrun{
#' rl_sp_count()
#' rl_sp_count_()
#' }
rl_sp_count <- function(key = NULL, parse = TRUE, ...) {
  assert_is(parse, 'logical')
  rl_parse(rl_sp_count_(key, ...), parse)
}

#' @export
#' @rdname rl_sp_count
rl_sp_count_ <- function(key = NULL, ...) {
  assert_is(key, 'character')
  rr_GET("speciescount", key, ...)
}
