context("rl_use_and_trade functions")

test_that("high level works - parsing", {
  skip_on_cran()

  vcr::use_cassette("rl_use_and_trade-def", {
    aa <- rl_use_and_trade()
  })

  expect_is(aa, "list")
  expect_named(aa, c("use_and_trade"))
  expect_is(aa$use_and_trade, "data.frame")

  vcr::use_cassette("rl_use_and_trade", {
    aa <- rl_use_and_trade("4")
  })

  expect_is(aa, "list")
  expect_named(aa, c("use_and_trade", "assessments", "filters"))
  expect_is(aa$use_and_trade, "list")
  expect_is(aa$assessments, "data.frame")
})

test_that("high level works - not parsing", {
  skip_on_cran()

  vcr::use_cassette("rl_use_and_trade-def-not-parsing", {
    aa <- rl_use_and_trade(parse = FALSE)
  })

  expect_is(aa, "list")
  expect_named(aa, c("use_and_trade"))
  expect_is(aa$use_and_trade, "list")

  vcr::use_cassette("rl_use_and_trade-not-parsing", {
    aa <- rl_use_and_trade("4", parse = FALSE)
  })

  expect_is(aa, "list")
  expect_named(aa, c("use_and_trade", "assessments", "filters"))
  expect_is(aa$use_and_trade, "list")
  expect_is(aa$assessments, "list")
})

test_that("low level works", {
  skip_on_cran()

  vcr::use_cassette("rl_use_and_trade_-def", {
    aa <- rl_use_and_trade_()
  })

  aajson <- jsonlite::fromJSON(aa)

  expect_is(aa, "character")
  expect_is(aajson, "list")
  expect_named(aajson, c("use_and_trade"))
  expect_is(aajson$use_and_trade, "data.frame")

  vcr::use_cassette("rl_use_and_trade_", {
    aa <- rl_use_and_trade_("4", all = FALSE)
  })

  aajson <- jsonlite::fromJSON(aa)

  expect_is(aa, "character")
  expect_is(aajson, "list")
  expect_named(aajson, c("use_and_trade", "assessments", "filters"))
})

test_that("fails well", {
  skip_on_cran()

  expect_error(rl_use_and_trade(5), "code must be of class character")
  expect_error(rl_use_and_trade(list()), "code must be of class character")

  expect_error(rl_use_and_trade(key = 5), "key must be of class character")
  expect_error(rl_use_and_trade(key = matrix()),
               "key must be of class character")

  expect_error(rl_use_and_trade(parse = 5), "parse must be of class logical")
  expect_error(rl_use_and_trade(parse = matrix()),
               "parse must be of class logical")

  expect_error(rl_use_and_trade(page = "next"), "page must be of class integer")
  expect_error(rl_use_and_trade(all = "yes"), "all must be of class logical")
  expect_error(rl_use_and_trade(quiet = "no"), "quiet must be of class logical")

  # lengths
  expect_error(rl_use_and_trade(page = 1:2), "page must be length 1")
})
