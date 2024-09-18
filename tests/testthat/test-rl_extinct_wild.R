context("rl_extinct_wild functions")

test_that("high level works - parsing", {
  skip_on_cran()

  vcr::use_cassette("rl_extinct_wild", {
    aa <- rl_extinct_wild(all = FALSE)
  })

  expect_is(aa, "list")
  expect_named(aa, c("assessments"))
  expect_is(aa$assessments, "data.frame")
})

test_that("high level works - not parsing", {
  skip_on_cran()

  vcr::use_cassette("rl_extinct_wild-not-parsing", {
    aa <- rl_extinct_wild(all = FALSE, parse = FALSE)
  })

  expect_is(aa, "list")
  expect_named(aa, c("assessments"))
  expect_is(aa$assessments, "list")
})

test_that("low level works", {
  skip_on_cran()

  library("jsonlite")

  vcr::use_cassette("rl_extinct_wild_", {
    aa <- rl_extinct_wild_(all = FALSE)
  })

  aajson <- jsonlite::fromJSON(aa)

  expect_is(aa, "character")
  expect_is(aajson, "list")
  expect_named(aajson, c("assessments"))
  expect_is(aajson$assessments, "data.frame")
})

test_that("fails well", {
  skip_on_cran()

  expect_error(rl_extinct_wild(key = 5), "key must be of class character")
  expect_error(rl_extinct_wild(key = matrix()), "key must be of class character")

  expect_error(rl_extinct_wild(parse = 5), "parse must be of class logical")
  expect_error(rl_extinct_wild(parse = matrix()), "parse must be of class logical")

  expect_error(rl_extinct_wild(page = "next"), "page must be of class integer")
  expect_error(rl_extinct_wild(all = "yes"), "all must be of class logical")
  expect_error(rl_extinct_wild(quiet = "no"), "quiet must be of class logical")

  # lengths
  expect_error(rl_extinct_wild(page = 1:2), "page must be length 1")
})
