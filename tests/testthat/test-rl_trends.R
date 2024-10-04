context("rl_pop_trends functions")

test_that("high level works - parsing", {
  skip_on_cran()

  vcr::use_cassette("rl_pop_trends-def", {
    aa <- rl_pop_trends()
  })

  expect_is(aa, "list")
  expect_named(aa, c("population_trends"))
  expect_is(aa$population_trends, "data.frame")

  vcr::use_cassette("rl_pop_trends", {
    aa <- rl_pop_trends("2", all = FALSE)
  })

  expect_is(aa, "list")
  expect_named(aa, c("population_trend", "assessments", "filters"))
  expect_is(aa$population_trend, "list")
  expect_is(aa$assessments, "data.frame")
})

test_that("high level works - not parsing", {
  skip_on_cran()

  vcr::use_cassette("rl_pop_trends-def-not-parsing", {
    aa <- rl_pop_trends(parse = FALSE)
  })

  expect_is(aa, "list")
  expect_named(aa, c("population_trends"))
  expect_is(aa$population_trends, "list")

  vcr::use_cassette("rl_pop_trends-not-parsing", {
    aa <- rl_pop_trends("2", parse = FALSE, all = FALSE)
  })

  expect_is(aa, "list")
  expect_named(aa, c("population_trend", "assessments", "filters"))
  expect_is(aa$population_trend, "list")
  expect_is(aa$assessments, "list")
})

test_that("low level works", {
  skip_on_cran()

  vcr::use_cassette("rl_pop_trends_-def", {
    aa <- rl_pop_trends_()
  })

  aajson <- jsonlite::fromJSON(aa)

  expect_is(aa, "character")
  expect_is(aajson, "list")
  expect_named(aajson, c("population_trends"))
  expect_is(aajson$population_trends, "data.frame")

  vcr::use_cassette("rl_pop_trends_", {
    aa <- rl_pop_trends_("2", all = FALSE)
  })

  aajson <- jsonlite::fromJSON(aa)

  expect_is(aa, "character")
  expect_is(aajson, "list")
  expect_named(aajson, c("population_trend", "assessments", "filters"))
})

test_that("fails well", {
  skip_on_cran()

  expect_error(rl_pop_trends(5), "code must be of class character")
  expect_error(rl_pop_trends(list()), "code must be of class character")

  expect_error(rl_pop_trends(key = 5), "key must be of class character")
  expect_error(rl_pop_trends(key = matrix()), "key must be of class character")

  expect_error(rl_pop_trends(parse = 5), "parse must be of class logical")
  expect_error(rl_pop_trends(parse = matrix()),
               "parse must be of class logical")

  expect_error(rl_pop_trends(page = "next"), "page must be of class integer")
  expect_error(rl_pop_trends(all = "yes"), "all must be of class logical")
  expect_error(rl_pop_trends(quiet = "no"), "quiet must be of class logical")

  # lengths
  expect_error(rl_pop_trends(page = 1:2), "page must be length 1")
})
