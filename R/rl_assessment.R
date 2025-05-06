#' Retrieve an assessment
#'
#' Get the full details for a single IUCN Red List assessment.
#'
#' @export
#' @param id (integer) The unique identifier of the assessment.
#' @template all
#' @template curl
#' @template info
#' @examples \dontrun{
#' # Get assessment details for Fratercula arctica
#' ex1 <- rl_assessment(id = 166290968)
#' ex1$red_list_category$code
#' ex1$systems
#' }
rl_assessment <- function(id, key = NULL, parse = TRUE, ...) {
  assert_is(parse, "logical")

  rl_parse(rl_assessment_(id, key, ...), parse)
}

#' @export
#' @rdname rl_assessment
rl_assessment_ <- function(id, key = NULL, ...) {
  assert_is(key, "character")
  assert_is(id, c("integer", "numeric"))
  assert_n(id, 1)

  rr_GET(paste0("assessment/", id), key, ...)
}

#' Retrieve a list of assessments
#'
#' Get the full details for a list of IUCN Red List assessments. This is a
#' wrapper for [rl_assessment()] that allows you to retrieve multiple
#' assessments at once.
#'
#' @param ids (integer) A vector of unique identifiers of the assessments.
#' @param key (character) An IUCN API token. See [rl_use_iucn()].
#' @param quiet (logical) If \code{TRUE}, suppresses the progress bar.
#' @param wait_time (numeric) The number of seconds to wait between queries. The
#'   default is 0.5 seconds, which is recommended by IUCN to avoid timeouts.
#' @template curl
#' @export
#' @return A list with each element representing the response of
#'   [rl_assessment()].
#'
#' @examples \dontrun{
#' # Get assessment details for multiple assessments
#' ex1 <- rl_assessment_list(ids = c(166290968, 136250858))
#' }
#' @importFrom cli cli_alert_success cli_alert_warning cli_progress_bar
#' @importFrom cli cli_progress_update cli_progress_done
rl_assessment_list <- function(ids, key = NULL, wait_time = 0.5, quiet = FALSE,
                               ...) {
  assert_is(key, "character")
  assert_is(ids, c("integer", "numeric"))
  assert_is(wait_time, c("integer", "numeric"))
  assert_is(quiet, "logical")
  if (wait_time < 0.5) {
    cli_alert_warning(paste("Waiting for", wait_time, "seconds between API",
                            "calls."))
    cli_alert_warning(paste("This is a short wait time and could result in",
                            "your API token being rate limited."))
    cli_alert_warning(paste("IUCN recommends wait times >=0.5 seconds between",
                            "calls to maintain service reliability."))
  } else {
    cli_alert_success(paste("Waiting for", wait_time, "second(s) between",
                            "API calls."))
  }
  if (!quiet) {
    prog_id <- cli_progress_bar(
      "Querying assessments", total = length(ids), clear = FALSE,
      format = paste0("{cli::pb_name} ({cli::pb_current}/{cli::pb_total}) | ",
                      "{cli::pb_bar} {cli::pb_percent} | ETA: {cli::pb_eta}"))
  }
  lst <- lapply(ids,
                function(id) {
                  Sys.sleep(wait_time)
                  tryCatch({
                    rl_assessment(id, key = key, ...)
                  }, error = function(e) {
                    cli_alert_warning(
                      paste(
                        "Couldn't find an IUCN assessment with {.field ID}",
                        "{.val {id}}."
                      )
                    )
                    return(NULL)
                  }, finally = if (!quiet) cli_progress_update(id = prog_id))
                }
  )
  if (!quiet) cli_progress_done(id = prog_id)
  return(lst)
}

#' Extract an assessment element
#'
#' Extract a given element from each of a list of assessments, such as the
#' output of [rl_assessment_list()]. This is useful for extracting specific
#' details from the assessments, such as taxonomy (`el_name = "taxon"`),
#' synonyms (`el_name = "taxon__synonyms"`), habitats (`el_name = "habitats"`),
#' or the red list category (`el_name = "red_list_category"`).
#'
#' @details The following top-level element names can be extracted as of
#'   `r Sys.Date()`:
#'   \itemize{
#'     `r get_assessment_elements()`
#'   }
#'
#'   Note that there are also sublevels of the assessment hierarchy, but they
#'   would be unwieldy to display here. A complete and up-to-date list can be
#'   found by inspecting the return of an [rl_assessment()] call.
#'
#' @param lst (list) A list of assessments, as returned by
#'   [rl_assessment_list()]. If `lst` contains any `NULL` elements, they will be
#'   removed.
#' @param el_name (character) The name of the element to extract from each
#'   assessment. Supports multilevel extraction using "__" as the separator. For
#'   example, to extract the synonyms table, you could use "taxon__synonyms".
#' @param format (character) The format of the output. Either "list" or "df"
#'   (for a data.frame).
#' @param flatten (logical) If `TRUE`, the output will be flattened to a
#'   data.frame. Note that this may not work for all elements, especially
#'   complex multilevel list elements. Only used when `format = "df"`. The
#'   `dplyr`, `tidyr`, and `tibble` packages are required to use this feature.
#'   Note that fields with no data across all assessments may be lost.
#' @return
#'   A list or data.frame containing the extracted element from each
#'   assessment.
#' @export
#' @importFrom rlang check_installed expr
#' @importFrom cli cli_abort
#' @examples \dontrun{
#' lst <- rl_assessment_list(ids = c(166290968, 136250858))
#' # get complex elements as a list
#' ex1 <- rl_assessment_extract(lst, "taxon")
#' # get simple elements as a data.frame
#' ex2 <- rl_assessment_extract(lst, "red_list_category__code", format = "df")
#' # get complex elements as a data.frame
#' ex3 <- rl_assessment_extract(lst, "threats", format = "df")
#' # get the same elements flattened to a single data.frame
#' ex4 <- rl_assessment_extract(lst, "threats", format = "df", flatten = TRUE)
#' # get subelements flattened to a data.frame
#' ex5 <- rl_assessment_extract(lst, "taxon__order_name", format = "df",
#'                              flatten = TRUE)
#' }
rl_assessment_extract <- function(lst, el_name, format = c("list", "df"),
                                  flatten = FALSE) {
  assert_is(lst, "list")
  assert_is(el_name, "character")
  assert_is(format, "character")
  assert_is(flatten, "logical")
  format <- match.arg(format)
  # filter out NULL elements
  lst <- Filter(Negate(is.null), lst)
  # get assessment ids for later
  ids <- vapply(lst, function(x) x$assessment_id, FUN.VALUE = integer(1))
  # extract levels of extraction
  el_name_spl <- strsplit(el_name, "__")[[1]]

  # perform multi-level extraction
  for (el in el_name_spl) {
    # check if element exists
    if (!any(sapply(lst, function(x) el %in% names(x)))) {
      cli_abort(
        paste("Element {.val {el}} not found in any of the assessments.")
      )
    }
    lst <- lapply(lst, function(x) x[[el]])
  }

  # put output in requested format
  if (format == "list") {
    names(lst) <- as.character(ids)
    return(lst)
  } else {
    if (flatten) {
      check_installed(c("dplyr", "tibble", "tidyr"),
                      reason = "to use `flatten = TRUE`")
      tryCatch({
        for (i in seq_along(lst)) {
          if (is.list(lst[[i]]) && !is.data.frame(lst[[i]])) {
            # need to handle all sorts of formats, otherwise would use as_tibble
            lst[[i]] <- tidyr::pivot_wider(tibble::enframe(lst[[i]]),
                                           names_from = "name",
                                           values_from = "value")
          } else {
            lst[[i]] <- as.data.frame(lst[[i]])
          }
          # if there is only one column, rename it to the element name
          if (ncol(lst[[i]]) == 1) {
            colnames(lst[[i]]) <- el
          }
          if (nrow(lst[[i]]) > 0) {
            lst[[i]]$assessment_id <- ids[i]
          }
        }
        df <- dplyr::bind_rows(lst)
      },
      error = function(e) {
        cli_abort(
          paste("Error flattening the {.val {el_name}} element to a",
                "data.frame. Try setting {.code flatten = FALSE} or extracting",
                "a lower level element of the assessments."),
          call = expr(rl_assessment_extract())
        )
      })

      # move assessment_id to first column
      df <- df[, c("assessment_id", setdiff(names(df), "assessment_id"))]
    } else {
      df <- data.frame(assessment_id = ids)
      df[[el]] <- lst
    }
    # unlist columns that are simple vectors
    for (col in colnames(df)) {
      if (is.list(df[[col]]) && all(sapply(df[[col]], Negate(is.list)))) {
        df[[col]] <- unlist(df[[col]], use.names = FALSE)
      }
    }
    return(df)
  }
}

get_assessment_elements <- function() {
  element_names <- names(rl_assessment(id = 166290968))
  return(paste0("\\item ", sort(element_names), collapse = "\n"))
}
