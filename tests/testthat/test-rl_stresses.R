context("rl_stresses functions")

test_that("high level works - parsing", {
  skip_on_cran()

  vcr::use_cassette("rl_stresses-def", {
    aa <- rl_stresses()
  })

  expect_is(aa, "list")
  expect_named(aa, c("stresses"))
  expect_is(aa$stresses, "data.frame")

  vcr::use_cassette("rl_stresses", {
    aa <- rl_stresses("2_3_4")
  })

  expect_is(aa, "list")
  expect_named(aa, c("stress", "assessments", "filters"))
  expect_is(aa$stress, "list")
  expect_is(aa$assessments, "data.frame")
})

test_that("high level works - not parsing", {
  skip_on_cran()

  vcr::use_cassette("rl_stresses-def-not-parsing", {
    aa <- rl_stresses(parse = FALSE)
  })

  expect_is(aa, "list")
  expect_named(aa, c("stresses"))
  expect_is(aa$stresses, "list")

  vcr::use_cassette("rl_stresses-not-parsing", {
    aa <- rl_stresses("2_3_4", parse = FALSE)
  })

  expect_is(aa, "list")
  expect_named(aa, c("stress", "assessments", "filters"))
  expect_is(aa$stress, "list")
  expect_is(aa$assessments, "list")
})

test_that("low level works", {
  skip_on_cran()

  vcr::use_cassette("rl_stresses_-def", {
    aa <- rl_stresses_()
  })

  aajson <- jsonlite::fromJSON(aa)

  expect_is(aa, "character")
  expect_is(aajson, "list")
  expect_named(aajson, c("stresses"))
  expect_is(aajson$stresses, "data.frame")

  vcr::use_cassette("rl_stresses_", {
    aa <- rl_stresses_("2_3_4", all = FALSE)
  })

  aajson <- jsonlite::fromJSON(aa)

  expect_is(aa, "character")
  expect_is(aajson, "list")
  expect_named(aajson, c("stress", "assessments", "filters"))
})

test_that("fails well", {
  skip_on_cran()

  expect_error(rl_stresses(5), "code must be of class character")
  expect_error(rl_stresses(list()), "code must be of class character")

  expect_error(rl_stresses(key = 5), "key must be of class character")
  expect_error(rl_stresses(key = matrix()), "key must be of class character")

  expect_error(rl_stresses(parse = 5), "parse must be of class logical")
  expect_error(rl_stresses(parse = matrix()), "parse must be of class logical")

  expect_error(rl_stresses(page = "next"), "page must be of class integer")
  expect_error(rl_stresses(all = "yes"), "all must be of class logical")
  expect_error(rl_stresses(quiet = "no"), "quiet must be of class logical")

  # lengths
  expect_error(rl_stresses(page = 1:2), "page must be length 1")
})
