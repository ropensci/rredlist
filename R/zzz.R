ct <- function(l) Filter(Negate(is.null), l)

rredlist_ua <- function() {
  versions <- c(
    paste0("r-curl/", utils::packageVersion("curl")),
    paste0("crul/", utils::packageVersion("crul")),
    sprintf("rOpenSci(rredlist/%s)", utils::packageVersion("rredlist"))
  )
  paste0(versions, collapse = " ")
}

rr_GET <- function(path, key, ...){
  cli <- crul::HttpClient$new(
    url = file.path(rr_base(), path),
    opts = list(useragent = rredlist_ua())
  )
  temp <- cli$get(query = list(token = check_key(key)), ...)
  temp$raise_for_status()
  x <- temp$parse("UTF-8")
  err_catcher(x)
  return(x)
}

err_catcher <- function(x) {
  xx <- jsonlite::fromJSON(x)
  if (any(vapply(c("message", "error"), function(z) z %in% names(xx),
                 logical(1)))) {
    stop(xx[[1]], call. = FALSE)
  }
}

rl_parse <- function(x, parse) {
  jsonlite::fromJSON(x, parse)
}

check_key <- function(x){
  tmp <- if (is.null(x)) Sys.getenv("IUCN_REDLIST_KEY", "") else x
  if (tmp == "") {
    getOption("iucn_redlist_key", stop("need an API key for Red List data",
                                       call. = FALSE))
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

assert_not_na <- function(x) {
  if (!is.null(x)) {
    if (any(is.na(x))) {
      stop(deparse(substitute(x)), " must not be NA", call. = FALSE)
    }
  }
}

nir <- function(path_name, path_id, name = NULL, id = NULL, region = NULL) {

  # only one of name OR id
  stopifnot(xor(!is.null(name), !is.null(id)))

  # check types
  assert_is(name, 'character')
  assert_is(id, c('integer', 'numeric'))
  assert_is(region, 'character')

  # can't be NA
  assert_not_na(name)
  assert_not_na(id)
  assert_not_na(region)

  # check lengths - only length 1 allowed for all
  assert_n(name, 1)
  assert_n(id, 1)
  assert_n(region, 1)

  # construct path
  path <- if (!is.null(name)) {
    file.path(path_name, space(name))
  } else {
    file.path(path_id, id)
  }
  if (!is.null(region)) {
    path <- file.path(path, "region", space(region))
  }

  return(path)
}
