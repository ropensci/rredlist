context("rl_countries functions")

test_that("high level works - parsing", {
  skip_on_cran()

  vcr::use_cassette("rl_countries-def", {
    aa <- rl_countries()
  })

  expect_is(aa, "list")
  expect_named(aa, c("countries"))
  expect_is(aa$countries, "data.frame")

  vcr::use_cassette("rl_countries", {
    aa <- rl_countries("VA")
  })

  expect_is(aa, "list")
  expect_named(aa, c("country", "assessments", "filters"))
  expect_is(aa$country, "list")
  expect_is(aa$assessments, "data.frame")
})

test_that("high level works - not parsing", {
  skip_on_cran()

  vcr::use_cassette("rl_countries-def-not-parsing", {
    aa <- rl_countries(parse = FALSE)
  })

  expect_is(aa, "list")
  expect_named(aa, c("countries"))
  expect_is(aa$countries, "list")

  vcr::use_cassette("rl_countries-not-parsing", {
    aa <- rl_countries("VA", parse = FALSE)
  })

  expect_is(aa, "list")
  expect_named(aa, c("country", "assessments", "filters"))
  expect_is(aa$country, "list")
  expect_is(aa$assessments, "list")
})

test_that("low level works", {
  skip_on_cran()

  vcr::use_cassette("rl_countries_-def", {
    aa <- rl_countries_()
  })

  aajson <- jsonlite::fromJSON(aa)

  expect_is(aa, "character")
  expect_is(aajson, "list")
  expect_named(aajson, c("countries"))
  expect_is(aajson$countries, "data.frame")

  vcr::use_cassette("rl_countries_", {
    aa <- rl_countries_("VA", all = FALSE)
  })

  aajson <- jsonlite::fromJSON(aa)

  expect_is(aa, "character")
  expect_is(aajson, "list")
  expect_named(aajson, c("country", "assessments", "filters"))
})

test_that("fails well", {
  skip_on_cran()

  expect_error(rl_countries(5), "code must be of class character")
  expect_error(rl_countries(list()), "code must be of class character")

  expect_error(rl_countries(key = 5), "key must be of class character")
  expect_error(rl_countries(key = matrix()), "key must be of class character")

  expect_error(rl_countries(parse = 5), "parse must be of class logical")
  expect_error(rl_countries(parse = matrix()), "parse must be of class logical")

  expect_error(rl_countries(page = "next"), "page must be of class integer")
  expect_error(rl_countries(all = "yes"), "all must be of class logical")
  expect_error(rl_countries(quiet = "no"), "quiet must be of class logical")

  # lengths
  expect_error(rl_countries(page = 1:2), "page must be length 1")

})
