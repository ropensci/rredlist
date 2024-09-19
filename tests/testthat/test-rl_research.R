context("rl_research functions")

test_that("high level works - parsing", {
  skip_on_cran()

  vcr::use_cassette("rl_research-def", {
    aa <- rl_research()
  })

  expect_is(aa, "list")
  expect_named(aa, c("research"))
  expect_is(aa$research, "data.frame")

  vcr::use_cassette("rl_research", {
    aa <- rl_research("4")
  })

  expect_is(aa, "list")
  expect_named(aa, c("research", "assessments", "filters"))
  expect_is(aa$research, "list")
  expect_is(aa$assessments, "data.frame")
})

test_that("high level works - not parsing", {
  skip_on_cran()

  vcr::use_cassette("rl_research-def-not-parsing", {
    aa <- rl_research(parse = FALSE)
  })

  expect_is(aa, "list")
  expect_named(aa, c("research"))
  expect_is(aa$research, "list")

  vcr::use_cassette("rl_research-not-parsing", {
    aa <- rl_research("4", parse = FALSE)
  })

  expect_is(aa, "list")
  expect_named(aa, c("research", "assessments", "filters"))
  expect_is(aa$research, "list")
  expect_is(aa$assessments, "list")
})

test_that("low level works", {
  skip_on_cran()

  library("jsonlite")

  vcr::use_cassette("rl_research_-def", {
    aa <- rl_research_()
  })

  aajson <- jsonlite::fromJSON(aa)

  expect_is(aa, "character")
  expect_is(aajson, "list")
  expect_named(aajson, c("research"))
  expect_is(aajson$research, "data.frame")

  vcr::use_cassette("rl_research_", {
    aa <- rl_research_("4", all = FALSE)
  })

  aajson <- jsonlite::fromJSON(aa)

  expect_is(aa, "character")
  expect_is(aajson, "list")
  expect_named(aajson, c("research", "assessments", "filters"))
})

test_that("fails well", {
  skip_on_cran()

  expect_error(rl_research(5), "code must be of class character")
  expect_error(rl_research(list()), "code must be of class character")

  expect_error(rl_research(key = 5), "key must be of class character")
  expect_error(rl_research(key = matrix()), "key must be of class character")

  expect_error(rl_research(parse = 5), "parse must be of class logical")
  expect_error(rl_research(parse = matrix()), "parse must be of class logical")

  expect_error(rl_research(page = "next"), "page must be of class integer")
  expect_error(rl_research(all = "yes"), "all must be of class logical")
  expect_error(rl_research(quiet = "no"), "quiet must be of class logical")

  # lengths
  expect_error(rl_research(page = 1:2), "page must be length 1")

})
