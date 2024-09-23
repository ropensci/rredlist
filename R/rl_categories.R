#' Red List category assessment summary
#'
#' Return a list of the latest assessments for a given category (e.g., Not
#' Evaluated, Data Deficient, Least Concern, Near Threatened, Vulnerable,
#' Endangered, Critically Endangered, Extinct in the Wild and Extinct). This
#' endpoint returns categories for the current IUCN Red List Categories and
#' Criteria (v3.1) as well as older versions (i.e., v2.3). Note that a code may
#' not be unique across Categories and Criteria versions. Therefore, codes like
#' "EX" will return assessments for EX v3.1 and EX v2.3.
#'
#' @export
#' @param code (character) The code of the Red List category to look up. If not
#'   supplied, a list of all categories will be returned.
#' @template all
#' @template filters
#' @template info
#' @template page
#' @examples \dontrun{
#' # Get all Red List categories
#' rl_categories()
#' # Get assessments for the Vulnerable category
#' rl_categories("VU")
#' }
rl_categories <- function(code = NULL, key = NULL, parse = TRUE, all = TRUE,
                          page = 1, quiet = FALSE, ...) {
  assert_is(parse, "logical")
  assert_is(all, "logical")

  res <- rl_categories_(code, key, all, page, quiet, ...)
  if (all) {
    combine_assessments(res, parse)
  } else {
    rl_parse(res, parse)
  }
}

#' @export
#' @rdname rl_categories
rl_categories_ <- function(code = NULL, key = NULL, all = TRUE, page = 1,
                           quiet = FALSE, ...) {
  assert_is(key, "character")
  assert_is(code, "character")
  assert_is(page, c("integer", "numeric"))
  assert_n(page, 1)
  assert_is(all, "logical")
  assert_is(quiet, "logical")

  path <- paste("red_list_categories", code, sep = "/")

  if (all) {
    page_assessments(path, key, quiet, ...)
  } else {
    rr_GET(path, key, query = list(page = page), ...)
  }
}

#' Green Status assessment summary
#'
#' List all Green Status assessments.
#'
#' @export
#' @template all
#' @template curl
#' @template info
#' @examples \dontrun{
#' # Get list of Green Status assessments
#' rl_green()
#' }
rl_green <- function(key = NULL, parse = TRUE, ...) {
  assert_is(parse, "logical")

  rl_parse(rl_green_(key, ...), parse)
}

#' @export
#' @rdname rl_green
rl_green_ <- function(key = NULL, ...) {
  assert_is(key, "character")

  rr_GET("green_status/all", key, ...)
}
