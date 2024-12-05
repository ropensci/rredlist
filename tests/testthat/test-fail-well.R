context("package fails well")

test_that("fails well when API is down", {
  skip_on_cran()
  webmockr::enable()
  stub <- webmockr::stub_request("get", paste0(rr_base(),
                                               "/taxa/scientific_name?",
                                               "genus_name=Loxodonta&",
                                               "species_name=africana"))
  webmockr::to_return(stub, status = 503)
  expect_error(rl_species("Loxodonta", "africana"),
               "The IUCN API is not currently available")
  webmockr::disable()
})

test_that("fails well on bad key", {
  skip_on_cran()

  vcr::use_cassette("rl_species-badkey", {
    expect_error(rl_species("Loxodonta", "africana", key = "adfds"),
                 "Token not valid!")
  })
  vcr::use_cassette("rl_species_-badkey", {
    expect_error(rl_species_("Loxodonta", "africana", key = "adfds"),
                 "Token not valid")
  })
})

test_that("fails well on bad query", {
  skip_on_cran()

  vcr::use_cassette("rl_species-badquery", {
    expect_error(rl_species("Loxodonta", "africanum"),
                 "No results returned for query")
  })
  vcr::use_cassette("rl_species_-badquery", {
    expect_error(rl_species_("Loxodonta", "africanum"),
                 "No results returned for query")
  })
})

test_that("fails well for other status codes", {
  skip_on_cran()
  webmockr::enable()
  stub <- webmockr::stub_request("get", paste0(rr_base(),
                                               "/taxa/scientific_name?",
                                               "genus_name=Loxodonta&",
                                               "species_name=africana"))
  webmockr::to_return(stub, status = 418)
  expect_error(rl_species("Loxodonta", "africana"),
               "I'm a teapot")
  webmockr::disable()
})

test_that("fails well when correct parameters not given", {
  skip_on_cran()

  expect_error(rl_species(), "is missing, with no default")
  expect_error(rl_species_(), "is missing, with no default")
})
