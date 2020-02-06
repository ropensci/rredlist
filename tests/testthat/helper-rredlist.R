# set up vcr
library("vcr")
invisible(vcr::vcr_configure(
    dir = "../fixtures",
    filter_sensitive_data = list("<<rredlist_api_token>>" = Sys.getenv('IUCN_REDLIST_KEY'))
))

if (!nzchar(Sys.getenv("IUCN_REDLIST_KEY"))) {
  if (dir.exists(vcr::vcr_configuration()$dir)) {
    Sys.setenv("IUCN_REDLIST_KEY" = "foobar")
  } else {
    stop("No API key nor cassettes, tests cannot be run.")
  }
}

