# set up vcr
library("vcr")

vcr_dir <- vcr::vcr_test_path("fixtures")

if (!nzchar(Sys.getenv("IUCN_REDLIST_KEY"))) {
  if (dir.exists(vcr_dir)) {
    Sys.setenv("IUCN_REDLIST_KEY" = "foobar")
  } else {
    stop("No API key nor cassettes, tests cannot be run.",
         call. = FALSE)
  }
}

invisible(vcr::vcr_configure(
  dir = vcr_dir,
  filter_sensitive_data = list("<<rredlist_api_token>>" =
                                 Sys.getenv("IUCN_REDLIST_KEY")),
  filter_request_headers = list(Authorization = "My bearer token is safe")
))

# load other needed packages
library("jsonlite")
library("webmockr")
