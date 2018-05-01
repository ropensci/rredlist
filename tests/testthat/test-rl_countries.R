context("rl_countries functions")

test_that("high level works - parsing", {
  skip_on_cran()

  vcr::use_cassette("rl_countries", {
    aa <- rl_countries()

    expect_is(aa, "list")
    expect_type(aa$count, "integer")
    expect_is(aa$results, "data.frame")
    expect_true(any(grepl("Egypt", aa$results$country, ignore.case = TRUE)))
  })
})

test_that("high level works - not parsing", {
  skip_on_cran()

  vcr::use_cassette("rl_countries-not-parsing", {
    aa <- rl_countries(parse = FALSE)

    expect_is(aa, "list")
    expect_type(aa$count, "integer")
    expect_is(aa$results, "list")
    expect_true(any(grepl("Egypt", vapply(aa$results, "[[", "", "country"), ignore.case = TRUE)))
  })
})

test_that("low level works", {
  skip_on_cran()

  library("jsonlite")

  vcr::use_cassette("rl_countries_", {
    aa <- rl_countries_()

    expect_is(aa, "character")
    expect_is(jsonlite::fromJSON(aa), "list")
  })
})

test_that("fails well", {
  skip_on_cran()

  expect_error(rl_countries(key = 5), "key must be of class character")
  expect_error(rl_countries(key = matrix()), "key must be of class character")

  expect_error(rl_countries(parse = 5), "parse must be of class logical")
  expect_error(rl_countries(parse = matrix()), "parse must be of class logical")
})

