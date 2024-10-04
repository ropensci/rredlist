context("rl_green functions")

test_that("high level works - parsing", {
  skip_on_cran()

  vcr::use_cassette("rl_green", {
    aa <- rl_green()
  })

  expect_is(aa, "list")
  expect_named(aa, c("assessments"))
  expect_is(aa$assessments, "data.frame")
})

test_that("high level works - not parsing", {
  skip_on_cran()

  vcr::use_cassette("rl_green-not-parsing", {
    aa <- rl_green(parse = FALSE)
  })

  expect_is(aa, "list")
  expect_named(aa, c("assessments"))
  expect_is(aa$assessments, "list")
})

test_that("low level works", {
  skip_on_cran()

  vcr::use_cassette("rl_green_", {
    aa <- rl_green_()
  })

  aajson <- jsonlite::fromJSON(aa)

  expect_is(aa, "character")
  expect_is(aajson, "list")
  expect_named(aajson, c("assessments"))
  expect_is(aajson$assessments, "data.frame")
})

test_that("fails well", {
  skip_on_cran()

  expect_error(rl_green(key = 5), "key must be of class character")
  expect_error(rl_green(key = matrix()), "key must be of class character")

  expect_error(rl_green(parse = 5), "parse must be of class logical")
  expect_error(rl_green(parse = matrix()), "parse must be of class logical")
})
