context("rl_comp_groups functions")

test_that("high level works - parsing", {
  skip_on_cran()

  vcr::use_cassette("rl_comp_groups-def", {
    aa <- rl_comp_groups()
  })

  expect_is(aa, "list")
  expect_named(aa, c("comprehensive_group"))
  expect_is(aa$comprehensive_group, "data.frame")

  vcr::use_cassette("rl_comp_groups", {
    aa <- rl_comp_groups("seasnakes")
  })

  expect_is(aa, "list")
  expect_named(aa, c("comprehensive_group", "assessments", "filters"))
  expect_is(aa$comprehensive_group, "list")
  expect_is(aa$assessments, "data.frame")
})

test_that("high level works - not parsing", {
  skip_on_cran()

  vcr::use_cassette("rl_comp_groups-def-not-parsing", {
    aa <- rl_comp_groups(parse = FALSE)
  })

  expect_is(aa, "list")
  expect_named(aa, c("comprehensive_group"))
  expect_is(aa$comprehensive_group, "list")

  vcr::use_cassette("rl_comp_groups-not-parsing", {
    aa <- rl_comp_groups("seasnakes", parse = FALSE)
  })

  expect_is(aa, "list")
  expect_named(aa, c("comprehensive_group", "assessments", "filters"))
  expect_is(aa$comprehensive_group, "list")
  expect_is(aa$assessments, "list")
})

test_that("low level works", {
  skip_on_cran()

  library("jsonlite")

  vcr::use_cassette("rl_comp_groups_-def", {
    aa <- rl_comp_groups_()
  })

  aajson <- jsonlite::fromJSON(aa)

  expect_is(aa, "character")
  expect_is(aajson, "list")
  expect_named(aajson, c("comprehensive_group"))
  expect_is(aajson$comprehensive_group, "data.frame")

  vcr::use_cassette("rl_comp_groups_", {
    aa <- rl_comp_groups_("seasnakes", all = FALSE)
  })

  aajson <- jsonlite::fromJSON(aa)

  expect_is(aa, "character")
  expect_is(aajson, "list")
  expect_named(aajson, c("comprehensive_group", "assessments", "filters"))
})

test_that("fails well", {
  skip_on_cran()

  expect_error(rl_comp_groups(5), "name must be of class character")
  expect_error(rl_comp_groups(list()), "name must be of class character")

  expect_error(rl_comp_groups(key = 5), "key must be of class character")
  expect_error(rl_comp_groups(key = matrix()), "key must be of class character")

  expect_error(rl_comp_groups(parse = 5), "parse must be of class logical")
  expect_error(rl_comp_groups(parse = matrix()),
               "parse must be of class logical")

  expect_error(rl_comp_groups(page = "next"), "page must be of class integer")
  expect_error(rl_comp_groups(all = "yes"), "all must be of class logical")
  expect_error(rl_comp_groups(quiet = "no"), "quiet must be of class logical")

  # lengths
  expect_error(rl_comp_groups(page = 1:2), "page must be length 1")

})
