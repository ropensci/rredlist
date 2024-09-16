#' Country assessment summary
#'
#' Returns a collection of assessments for a given country code
#'
#' @export
#' @param code (character) The ISO alpha-2 code of the country to look up. If
#'   not supplied, a list of all countries will be returned.
#' @template all
#' @template info_new
#' @template page
#' @family geo
#' @examples \dontrun{
#' # Get list of all countries
#' rl_countries()
#' # Get assessments for Madagascar
#' rl_countries("MG")
#' }
rl_countries <- function(code = NULL, key = NULL, parse = TRUE, all = TRUE,
                         page = 1, quiet = FALSE,...) {
  assert_is(parse, 'logical')
  assert_is(all, 'logical')

  res <- rl_countries_(code, key, all, page, quiet, ...)
  if (all) {
    combine_assessments(res, parse)
  } else {
    rl_parse(res, parse)
  }
}

#' @export
#' @rdname rl_countries
rl_countries_ <- function(code = NULL, key = NULL, all = TRUE, page = 1,
                          quiet = FALSE, ...) {
  assert_is(key, 'character')
  assert_is(code, 'character')
  assert_is(page, c('integer', 'numeric'))
  assert_n(page, 1)
  assert_is(all, 'logical')
  assert_is(quiet, 'logical')

  path <- paste("countries", code, sep = "/")

  if (all) {
    page_assessments(path, key, quiet, ...)
  } else {
    rr_GET(path, key, query = list(page = page), ...)
  }
}
