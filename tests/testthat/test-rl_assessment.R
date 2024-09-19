context("rl_assessment functions")

test_that("high level works - parsing", {
  skip_on_cran()

  vcr::use_cassette("rl_assessment", {
    aa <- rl_assessment(166290968)
  })

  expect_is(aa, "list")
  expect_is(aa$taxon, "list")
  expect_is(aa$habitats, "data.frame")
})

test_that("high level works - not parsing", {
  skip_on_cran()

  vcr::use_cassette("rl_assessment-not-parsing", {
    aa <- rl_assessment(166290968, parse = FALSE)
  })

  expect_is(aa, "list")
  expect_is(aa$taxon, "list")
  expect_is(aa$habitats, "list")
})

test_that("low level works", {
  skip_on_cran()

  library("jsonlite")

  vcr::use_cassette("rl_assessment_", {
    aa <- rl_assessment_(166290968)
  })

  aajson <- jsonlite::fromJSON(aa)

  expect_is(aa, "character")
  expect_is(aajson, "list")
  expect_is(aajson$taxon, "list")
  expect_is(aajson$habitats, "data.frame")
})

test_that("fails well", {
  skip_on_cran()

  expect_error(rl_assessment(), "is missing, with no default")

  expect_error(rl_assessment(166290968, key = 5),
               "key must be of class character")
  expect_error(rl_assessment(166290968, key = matrix()),
               "key must be of class character")

  expect_error(rl_assessment(166290968, parse = 5),
               "parse must be of class logical")
  expect_error(rl_assessment(166290968, parse = matrix()),
               "parse must be of class logical")
})
