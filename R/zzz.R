#' Filter a string to non-null elements
#' @param l A list.
#' @noRd
#' @return A list.
ct <- function(l) Filter(Negate(is.null), l)

#' Get user agent info
#' @noRd
#' @return A string indicating the package version numbers for the curl, crul,
#'   and rredlist R packages.
#' @importFrom utils packageVersion
rredlist_ua <- function() {
  versions <- c(
    paste0("r-curl/", packageVersion("curl")),
    paste0("crul/", packageVersion("crul")),
    sprintf("rOpenSci(rredlist/%s)", packageVersion("rredlist"))
  )
  paste0(versions, collapse = " ")
}

#' Build and make a GET query of the IUCN API
#'
#' @param path (character) The full API endpoint.
#' @param key (character) An IUCN API token. See [rl_use_iucn()].
#' @param query (list) A list of parameters to include in the GET query.
#' @param ... [Curl options][curl::curl_options()] passed to the GET request via
#'   [HttpClient][crul::HttpClient()].
#'
#' @noRd
#' @return The raw crul response object.
#' @importFrom crul HttpClient
rr_GET_raw <- function(path, key = NULL, query = list(), ...) {
  # Extract secret API query arguments
  args <- list(...)
  query$latest <- args$latest
  query$scope_code <- args$scope_code
  query$year_published <- args$year_published

  check_internet()
  cli <- HttpClient$new(
    url = paste(rr_base(), space(path), sep = "/"),
    opts = list(useragent = rredlist_ua()),
    headers = list(Authorization = check_key(key))
  )
  cli$get(query = ct(query), ...)
}

#' Handle a GET query of the IUCN API
#'
#' @param path (character) The full API endpoint.
#' @param key (character) An IUCN API token. See [rl_use_iucn()].
#' @param query (list) A list of parameters to include in the GET query.
#' @param ... [Curl options][curl::curl_options()] passed to the GET request via
#'   [HttpClient][crul::HttpClient()].
#'
#' @noRd
#' @return The response of the query as a JSON string.
#' @importFrom crul HttpClient
rr_GET <- function(path, key = NULL, query = list(), ...) {
  res <- rr_GET_raw(path, key, query, ...)
  status_catcher(res)
  x <- res$parse("UTF-8")
  return(x)
}

#' Check that the user has internet
#'
#' @return If the user has internet, nothing is returned. If the user does not
#'   have internet, an error is thrown.
#' @noRd
#' @importFrom curl nslookup
check_internet <- function() {
  # check for internet with DNS lookup
  if (is.null(nslookup("google.com", error = FALSE))) {
    stop("An internet connection is required to access the IUCN API.")
  }
}

#' Catch status code errors
#' @param res An [crul::HttpResponse] object as returned by
#'   [crul::HttpClient()].
#' @return If no status code errors are found, nothing is returned. If status
#'   code errors are found, an error is thrown.
#' @noRd
status_catcher <- function(res) {
  if (res$status_code >= 300) {
    if (res$status_code == 401) {
      stop("Token not valid! (HTTP 401)", call. = FALSE)
    } else if (res$status_code == 404) {
      stop("No results returned for query. (HTTP 404)", call. = FALSE)
    } else if (res$status_code >= 500) {
      stop("The IUCN API is not currently available. Please try your query again
           later.", call. = FALSE)
    } else {
      res$raise_for_status()
    }
  }
}

#' Parse a JSON string to a list
#'
#' @param x (character) A JSON string.
#' @param parse (logical) Whether to parse sub-elements of the list to lists
#'   (`FALSE`) or, where possible, to data.frames (`TRUE`). Default:
#'   `TRUE`.
#'
#' @return A list.
#' @noRd
#' @importFrom jsonlite fromJSON
rl_parse <- function(x, parse) {
  fromJSON(x, parse)
}

#' Retrieve a stored API key, if needed
#'
#' @param x (character) An API key as a string. Can also be `NULL`, in which
#'   case the API key will be retrieved from the environmental variable or R
#'   option (in that order).
#'
#' @return A string. If no API key is found, an error is thrown.
#' @noRd
check_key <- function(x) {
  tmp <- if (is.null(x)) Sys.getenv("IUCN_REDLIST_KEY", "") else x
  if (tmp == "") {
    getOption("iucn_redlist_key", stop("need an API key for Red List data",
                                       call. = FALSE))
  } else {
    tmp
  }
}

#' Parse a JSON string to a list
#'
#' @return The base URL for the IUCN API
#' @noRd
rr_base <- function() "https://api.iucnredlist.org/api/v4"

space <- function(x) gsub("\\s", "%20", x)

#' Check that a value inherits the desired class
#'
#' @param x The value to be checked.
#' @param y (character) The name of a class.
#'
#' @return If the check fails, an error is thrown, otherwise, nothing is
#'   returned.
#' @noRd
assert_is <- function(x, y) {
  if (!is.null(x)) {
    if (!inherits(x, y)) {
      stop(deparse(substitute(x)), " must be of class ",
           paste0(y, collapse = ", "), call. = FALSE)
    }
  }
}

#' Check that a value has a desired length
#'
#' @param x The value to be checked.
#' @param n (numeric) The desired length.
#'
#' @return If the check fails, an error is thrown, otherwise, nothing is
#'   returned.
#' @noRd
assert_n <- function(x, n) {
  if (!is.null(x)) {
    if (!length(x) == n) {
      stop(deparse(substitute(x)), " must be length ", n, call. = FALSE)
    }
  }
}

#' Check that a value is not NA
#'
#' @param x The value to be checked.
#'
#' @return If the check fails, an error is thrown, otherwise, nothing is
#'   returned.
#' @noRd
assert_not_na <- function(x) {
  if (!is.null(x)) {
    if (any(is.na(x))) {
      stop(deparse(substitute(x)), " must not be NA", call. = FALSE)
    }
  }
}

#' Combine assessments from multiple pages of a single query
#'
#' @param res A list where each element represents the assessments from a single
#'   page of a multi-page query (such as the output of `page_assessments()`).
#' @param parse (logical) Whether to parse and combine the assessments into a
#'   data.frame (`TRUE`) or keep them as lists (`FALSE`). Default:
#'   `TRUE`.
#' @noRd
#' @return If `parse` is `TRUE`, a data.frame, otherwise, a list.
combine_assessments <- function(res, parse) {
  if (length(res) <= 1) return(rl_parse(res, parse))
  lst <- lapply(res, rl_parse, parse = parse)
  tmp <- lst[[1]]
  assessments <- lapply(lst, "[[", "assessments")
  if (parse) {
    tmp$assessments <- do.call(rbind, assessments)
  } else {
    tmp$assessments <- do.call(c, assessments)
  }
  return(tmp)
}

#' Page through assessments
#'
#' @param path (character) The full API endpoint.
#' @param key (character) An IUCN API token. See [rl_use_iucn()].
#' @param quiet (logical) Whether to suppress progress for multi-page downloads
#'   or not. Default: `FALSE` (that is, give progress). Ignored if `all =
#'   FALSE`.
#' @param ... [Curl options][curl::curl_options()] passed to the GET request via
#'   [HttpClient][crul::HttpClient()].
#'
#' @return A list with each element representing the response of one page of
#'   results.
#' @noRd
#' @importFrom cli cli_progress_bar cli_progress_update cli_progress_done
page_assessments <- function(path, key, quiet, ...) {
  out <- list()
  res <- rr_GET_raw(path, key, query = list(page = 1), ...)
  status_catcher(res)
  total_pages <- as.integer(res$response_headers$`total-pages`)
  if (length(total_pages) == 0) total_pages <- 1
  if (!quiet) cli_progress_bar("Paging assessments", total = total_pages)
  tmp <- res$parse("UTF-8")
  if (total_pages == 1) {
    out <- tmp
  } else {
    out[[1]] <- tmp
    if (!quiet) cli_progress_update()
    for (page in 2:total_pages) {
      tmp <- rr_GET(path, key, query = list(page = page), ...)
      out[[page]] <- tmp
      if (!quiet) cli_progress_update()
    }
  }
  if (!quiet) cli_progress_done()
  return(out)
}
