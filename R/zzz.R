ct <- function(l) Filter(Negate(is.null), l)

rr_GET <- function(path, key, ...){
  cli <- crul::HttpClient$new(url = file.path(rr_base(), path), opts = list(...))
  temp <- cli$get(query = list(token = check_key(key)))
  temp$raise_for_status()
  x <- temp$parse("UTF-8")
  err_catcher(x)
  return(x)
}

err_catcher <- function(x) {
  xx <- jsonlite::fromJSON(x)
  if (any(vapply(c("message", "error"), function(z) z %in% names(xx), logical(1)))) {
    stop(xx[[1]], call. = FALSE)
  }
}

rl_parse <- function(x, parse) {
  jsonlite::fromJSON(x, parse)
}

check_key <- function(x){
  tmp <- if (is.null(x)) Sys.getenv("IUCN_REDLIST_KEY", "") else x
  if (tmp == "") {
    getOption("iucn_redlist_key", stop("need an API key for Red List data", call. = FALSE))
  } else {
    tmp
  }
}

rr_base <- function() "http://apiv3.iucnredlist.org/api/v3"

space <- function(x) gsub("\\s", "%20", x)

assert_is <- function(x, y) {
  if (!is.null(x)) {
    if (!class(x) %in% y) {
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
