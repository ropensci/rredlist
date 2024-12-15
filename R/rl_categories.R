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
#' @family threats
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
  assert_n(code, 1)
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

#' IUCN Red List color scales
#'
#' ggplot2 color scales using the colors for the IUCN Red List threat categories, as
#' documented in [this
#' chart](https://nc.iucnredlist.org/redlist/resources/files/1646067752-FINAL_IUCN_Red_List_colour_chart.pdf).
#'
#' @param aesthetics Character string or vector of character strings listing the
#'   name(s) of the aesthetic(s) that this scale works with. This can be useful,
#'   for example, to apply color settings to the `color` and `fill` aesthetics
#'   at the same time, via `aesthetics = c("color", "fill")`.
#' @param ... Arguments passed on to [ggplot2::discrete_scale] (except for
#'   `na.value` which is already set according to the IUCN standard of
#'   `#C1B5A5`)
#' @rdname scale_iucn
#' @export
#' @examplesIf require(ggplot2)
#' library(ggplot2)
#' categories <- c("NE", "DD", "LC", "NT", "VU", "EN", "CR", "RE", "EW", "EX")
#' df <- data.frame(
#'   x = runif(1000, 0, 10), y = runif(1000, 0, 10),
#'   color = sample(categories, 1000, TRUE), shape = 21
#' )
#' ggplot(df) +
#'   geom_point(aes(x = x, y = y, fill = color), shape = 21) +
#'   scale_fill_iucn(name = "IUCN Category") +
#'   theme_classic()
scale_color_iucn <- function(...) {
  scale_discrete_iucn("color", ...)
}

#' @export
#' @rdname scale_iucn
#' @usage NULL
scale_colour_iucn <- scale_color_iucn

#' @rdname scale_iucn
#' @export
scale_fill_iucn <- function(...) {
  scale_discrete_iucn("fill", ...)
}

#' @export
#' @rdname scale_iucn
#' @importFrom rlang check_installed
scale_discrete_iucn <- function(aesthetics, ...) {
  check_installed("ggplot2", reason = "to use `scale_discrete_iucn()`")
  values <- c(
    "NE" = "#FFFFFF",
    "DD" = "#D1D1C6",
    "LC" = "#60C659",
    "NT" = "#CCE226",
    "VU" = "#F9E814",
    "EN" = "#FC7F3F",
    "CR" = "#D81E05",
    "RE" = "#9B4F96",
    "EW" = "#542344",
    "EX" = "#000000"
  )
  pal <- function(n) {
    if (n > length(values)) {
      cli::cli_abort("Insufficient values in manual scale. {n} needed but only
                     {length(values)} provided.")
    }
    values
  }

  ggplot2::discrete_scale(aesthetics, palette = pal, breaks = names(values),
                          na.value = "#C1B5A5", ...)
}

#' Green Status assessment summary
#'
#' List all Green Status assessments.
#'
#' @export
#' @template all
#' @template curl
#' @template info
#' @family groups
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
