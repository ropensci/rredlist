# set up vcr
library("vcr")
invisible(vcr::vcr_configure(
    dir = "../fixtures/vcr_cassettes",
    filter_sensitive_data = list("<<rredlist_api_token>>" = Sys.getenv('IUCN_REDLIST_KEY'))
))
