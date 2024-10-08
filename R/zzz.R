ct <- function(l) Filter(Negate(is.null), l)

#' @importFrom utils packageVersion
rredlist_ua <- function() {
  versions <- c(
    paste0("r-curl/", packageVersion("curl")),
    paste0("crul/", packageVersion("crul")),
    sprintf("rOpenSci(rredlist/%s)", packageVersion("rredlist"))
  )
  paste0(versions, collapse = " ")
}

#' @importFrom crul HttpClient
rr_GET <- function(path, key = NULL, query = list(), ...) {
  # Extract secret API query arguments
  args <- list(...)
  query$latest <- args$latest
  query$scope_code <- args$scope_code
  query$year_published <- args$year_published

  cli <- HttpClient$new(
    url = paste(rr_base(), space(path), sep = "/"),
    opts = list(useragent = rredlist_ua()),
    headers = list(Authorization = check_key(key))
  )
  temp <- cli$get(query = ct(query), ...)
  if (temp$status_code >= 300) {
    if (temp$status_code == 401) {
      stop("Token not valid! (HTTP 401)", call. = FALSE)
    } else if (temp$status_code == 404) {
      stop("No results returned for query. (HTTP 404)", call. = FALSE)
    } else {
      temp$raise_for_status()
    }
  }
  x <- temp$parse("UTF-8")
  err_catcher(x)
  return(x)
}

#' @importFrom jsonlite fromJSON
err_catcher <- function(x) {
  xx <- fromJSON(x)
  if (any(vapply(c("message", "error"), function(z) z %in% names(xx),
                 logical(1)))) {
    stop(xx[[1]], call. = FALSE)
  }
}

#' @importFrom jsonlite fromJSON
rl_parse <- function(x, parse) {
  fromJSON(x, parse)
}

check_key <- function(x) {
  tmp <- if (is.null(x)) Sys.getenv("IUCN_REDLIST_KEY", "") else x
  if (tmp == "") {
    getOption("iucn_redlist_key", stop("need an API key for Red List data",
                                       call. = FALSE))
  } else {
    tmp
  }
}

rr_base <- function() "https://api.iucnredlist.org/api/v4"

space <- function(x) gsub("\\s", "%20", x)

assert_is <- function(x, y) {
  if (!is.null(x)) {
    if (!inherits(x, y)) {
      stop(deparse(substitute(x)), " must be of class ",
           paste0(y, collapse = ", "), call. = FALSE)
    }
  }
}

assert_n <- function(x, n) {
  if (!is.null(x)) {
    if (!length(x) == n) {
      stop(deparse(substitute(x)), " must be length ", n, call. = FALSE)
    }
  }
}

assert_not_na <- function(x) {
  if (!is.null(x)) {
    if (any(is.na(x))) {
      stop(deparse(substitute(x)), " must not be NA", call. = FALSE)
    }
  }
}

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

#' @importFrom jsonlite fromJSON
page_assessments <- function(path, key, quiet, ...) {
  out <- list()
  done <- FALSE
  page <- 1
  while (!done) {
    tmp <- rr_GET(path, key, query = list(page = page), ...)
    if (length(fromJSON(tmp, FALSE)$assessments) == 0) {
      if (page == 1) out <- tmp else if (page == 2) out <- out[[1]]
      done <- TRUE
    } else {
      if (!quiet) cat(".")
      out[[page]] <- tmp
      page <- page + 1
    }
  }
  if (!quiet && page > 1) cat("\n")
  return(out)
}
