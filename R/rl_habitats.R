#' Habitat assessment summary
#'
#' Return the latest assessments for a given habitat (e.g., Forest - Temperate
#' or Marine Intertidal). These habitat codes correspond to the IUCN Red List
#' Habitats Classification Scheme (v3.1).
#'
#' @export
#' @param code (character) The code of the habitat to look up. If not supplied,
#'   a list of all habitats will be returned.
#' @template all
#' @template info
#' @template page
#' @family habitat
#' @examples \dontrun{
#' # Get list of all habitats
#' rl_habitats()
#' # Get assessments for Marine Intertidal habitat
#' rl_habitats("12")
#' }
rl_habitats <- function(code = NULL, key = NULL, parse = TRUE, all = TRUE,
                        page = 1, quiet = FALSE, ...) {
  assert_is(parse, "logical")
  assert_is(all, "logical")

  res <- rl_habitats_(code, key, all, page, quiet, ...)
  if (all) {
    combine_assessments(res, parse)
  } else {
    rl_parse(res, parse)
  }
}

#' @export
#' @rdname rl_habitats
rl_habitats_ <- function(code = NULL, key = NULL, all = TRUE, page = 1,
                         quiet = FALSE, ...) {
  assert_is(key, "character")
  assert_is(code, "character")
  assert_is(page, c("integer", "numeric"))
  assert_n(page, 1)
  assert_is(all, "logical")
  assert_is(quiet, "logical")

  path <- paste("habitats", code, sep = "/")

  if (all) {
    page_assessments(path, key, quiet, ...)
  } else {
    rr_GET(path, key, query = list(page = page), ...)
  }
}

#' System assessment summary
#'
#' Return the latest assessments for a given system (e.g., terrestrial,
#' freshwater or marine).
#'
#' @export
#' @param code (character) The code of the system to look up. If not supplied, a
#'   list of all systems will be returned.
#' @template all
#' @template info
#' @template page
#' @family habitat
#' @examples \dontrun{
#' # Get list of all systems
#' rl_systems()
#' # Get assessment summary for marine system
#' rl_systems("2")
#' }
rl_systems <- function(code = NULL, key = NULL, parse = TRUE, all = TRUE,
                       page = 1, quiet = FALSE, ...) {
  assert_is(parse, "logical")
  assert_is(all, "logical")

  res <- rl_systems_(code, key, all, page, quiet, ...)
  if (all) {
    combine_assessments(res, parse)
  } else {
    rl_parse(res, parse)
  }
}

#' @export
#' @rdname rl_systems
rl_systems_ <- function(code = NULL, key = NULL, all = TRUE, page = 1,
                        quiet = FALSE, ...) {
  assert_is(key, "character")
  assert_is(code, "character")
  assert_is(page, c("integer", "numeric"))
  assert_n(page, 1)
  assert_is(all, "logical")
  assert_is(quiet, "logical")

  path <- paste("systems", code, sep = "/")

  if (all) {
    page_assessments(path, key, quiet, ...)
  } else {
    rr_GET(path, key, query = list(page = page), ...)
  }
}
