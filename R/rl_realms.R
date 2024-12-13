#' Biogeographical realm assessment summary
#'
#' Get an assessment summary for a particular biogeographical realm (e.g.,
#' Neotropical or Palearctic).
#'
#' @export
#' @param code (character) The code of the biogeographical realm to look up. If
#'   not supplied, a list of all biogeographical realms will be returned.
#' @template all
#' @template filters
#' @template info
#' @template page
#' @family geo
#' @examples \dontrun{
#' # Get a list of all biogeographical realms
#' rl_realms()
#' # Get assessment summary for the Afrotropical biogeographical realm
#' rl_realms(code = "0")
#' }
rl_realms <- function(code = NULL, key = NULL, parse = TRUE, all = TRUE,
                      page = 1, quiet = FALSE, ...) {
  assert_is(parse, "logical")
  assert_is(all, "logical")

  res <- rl_realms_(code, key, all, page, quiet, ...)
  if (all) {
    combine_assessments(res, parse)
  } else {
    rl_parse(res, parse)
  }
}

#' @export
#' @rdname rl_realms
rl_realms_ <- function(code = NULL, key = NULL, all = TRUE, page = 1,
                       quiet = FALSE, ...) {
  assert_is(key, "character")
  assert_is(code, "character")
  assert_n(code, 1)
  assert_is(page, c("integer", "numeric"))
  assert_n(page, 1)
  assert_is(all, "logical")
  assert_is(quiet, "logical")

  path <- paste("biogeographical_realms", code, sep = "/")

  if (all) {
    page_assessments(path, key, quiet, ...)
  } else {
    rr_GET(path, key, query = list(page = page), ...)
  }
}

#' Scope assessment summary
#'
#' Return assessments for a given geographical assessment scope (e.g., Global,
#' Mediterranean). This is similar to the `region` argument of the old Red List
#' API and old versions of rredlist.
#'
#' @export
#' @param code (character) The code of the scope to look up. If not supplied, a
#'   list of all scopes will be returned.
#' @template all
#' @template filters
#' @template info
#' @template page
#' @family geo
#' @examples \dontrun{
#' # Get a list of all scopes
#' rl_scopes()
#' # Get assessment summary for the Gulf of Mexico scope
#' rl_scopes(code = "45433062")
#' }
rl_scopes <- function(code = NULL, key = NULL, parse = TRUE, all = TRUE,
                      page = 1, quiet = FALSE, ...) {
  assert_is(parse, "logical")
  assert_is(all, "logical")

  res <- rl_scopes_(code, key, all, page, quiet, ...)
  if (all) {
    combine_assessments(res, parse)
  } else {
    rl_parse(res, parse)
  }
}

#' @export
#' @rdname rl_scopes
rl_scopes_ <- function(code = NULL, key = NULL, all = TRUE, page = 1,
                       quiet = FALSE, ...) {
  assert_is(key, "character")
  assert_is(code, "character")
  assert_n(code, 1)
  assert_is(page, c("integer", "numeric"))
  assert_n(page, 1)
  assert_is(all, "logical")
  assert_is(quiet, "logical")

  path <- paste("scopes", code, sep = "/")

  if (all) {
    page_assessments(path, key, quiet, ...)
  } else {
    rr_GET(path, key, query = list(page = page), ...)
  }
}

#' FAO marine fishing region assessment summary
#'
#' Return assessments for a given marine fishing region as defined by the Food
#' and Agriculture Organization (FAO) of the United Nations (e.g., Pacific -
#' northwest, Arctic Sea). More details are available here:
#' <https://www.fao.org/fishery/en/area>.
#'
#' @export
#' @param code (character) The code of the FAO region to look up. If not
#'   supplied, a list of all FAO regions will be returned.
#' @template all
#' @template filters
#' @template info
#' @template page
#' @family geo
#' @examples \dontrun{
#' # Get a list of all scopes
#' rl_faos()
#' # Get assessment summary for the Arctic Sea FAO region
#' rl_faos(code = "18")
#' }
rl_faos <- function(code = NULL, key = NULL, parse = TRUE, all = TRUE,
                    page = 1, quiet = FALSE, ...) {
  assert_is(parse, "logical")
  assert_is(all, "logical")

  res <- rl_faos_(code, key, all, page, quiet, ...)
  if (all) {
    combine_assessments(res, parse)
  } else {
    rl_parse(res, parse)
  }
}

#' @export
#' @rdname rl_faos
rl_faos_ <- function(code = NULL, key = NULL, all = TRUE, page = 1,
                     quiet = FALSE, ...) {
  assert_is(key, "character")
  assert_is(code, "character")
  assert_n(code, 1)
  assert_is(page, c("integer", "numeric"))
  assert_n(page, 1)
  assert_is(all, "logical")
  assert_is(quiet, "logical")

  path <- paste("faos", code, sep = "/")

  if (all) {
    page_assessments(path, key, quiet, ...)
  } else {
    rr_GET(path, key, query = list(page = page), ...)
  }
}
