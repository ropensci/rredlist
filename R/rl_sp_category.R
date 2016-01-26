#' Get species by category
#'
#' @export
#' @param category (character) 2 letter category code
#' @template all
#' @examples \dontrun{
#' rl_sp_category('VU')
#' rl_sp_category('EN')
#' rl_sp_category('EX')
#' rl_sp_category('EX', parse = FALSE)
#' rl_sp_category_('EX')
#' }
rl_sp_category <- function(category, key = NULL, parse = TRUE, ...) {
  rl_parse(rl_sp_category_(category, key, ...), parse)
}

#' @export
#' @rdname rl_sp_category
rl_sp_category_ <- function(category, key = NULL, parse = TRUE, ...) {
  rr_GET(file.path("species/category", category), key, ...)
}
