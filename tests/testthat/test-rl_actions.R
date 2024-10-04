context("rl_actions functions")

test_that("high level works - parsing", {
  skip_on_cran()

  vcr::use_cassette("rl_actions-def", {
    aa <- rl_actions()
  })

  expect_is(aa, "list")
  expect_named(aa, c("conservation_actions"))
  expect_is(aa$conservation_action, "data.frame")

  vcr::use_cassette("rl_actions", {
    aa <- rl_actions("6_5")
  })

  expect_is(aa, "list")
  expect_named(aa, c("conservation_action", "assessments", "filters"))
  expect_is(aa$conservation_action, "list")
  expect_is(aa$assessments, "data.frame")
})

test_that("high level works - not parsing", {
  skip_on_cran()

  vcr::use_cassette("rl_actions-def-not-parsing", {
    aa <- rl_actions(parse = FALSE)
  })

  expect_is(aa, "list")
  expect_named(aa, c("conservation_actions"))
  expect_is(aa$conservation_action, "list")

  vcr::use_cassette("rl_actions-not-parsing", {
    aa <- rl_actions("6_5", parse = FALSE)
  })

  expect_is(aa, "list")
  expect_named(aa, c("conservation_action", "assessments", "filters"))
  expect_is(aa$conservation_action, "list")
  expect_is(aa$assessments, "list")
})

test_that("low level works", {
  skip_on_cran()

  vcr::use_cassette("rl_actions_-def", {
    aa <- rl_actions_()
  })

  aajson <- jsonlite::fromJSON(aa)

  expect_is(aa, "character")
  expect_is(aajson, "list")
  expect_named(aajson, c("conservation_actions"))
  expect_is(aajson$conservation_action, "data.frame")

  vcr::use_cassette("rl_actions_", {
    aa <- rl_actions_("6_5", all = FALSE)
  })

  aajson <- jsonlite::fromJSON(aa)

  expect_is(aa, "character")
  expect_is(aajson, "list")
  expect_named(aajson, c("conservation_action", "assessments", "filters"))
})

test_that("fails well", {
  skip_on_cran()

  expect_error(rl_actions(5), "code must be of class character")
  expect_error(rl_actions(list()), "code must be of class character")

  expect_error(rl_actions(key = 5), "key must be of class character")
  expect_error(rl_actions(key = matrix()), "key must be of class character")

  expect_error(rl_actions(parse = 5), "parse must be of class logical")
  expect_error(rl_actions(parse = matrix()), "parse must be of class logical")

  expect_error(rl_actions(page = "next"), "page must be of class integer")
  expect_error(rl_actions(all = "yes"), "all must be of class logical")
  expect_error(rl_actions(quiet = "no"), "quiet must be of class logical")

  # lengths
  expect_error(rl_actions(page = 1:2), "page must be length 1")

})
