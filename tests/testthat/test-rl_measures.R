context("rl_measures functions")

test_that("high level works - parsing", {
  skip_on_cran()

  aa <- rl_measures('Fratercula arctica')

  expect_is(aa, "list")
  expect_named(aa, c("name", "result"))
  expect_is(aa$name, "character")
  expect_is(aa$result, "data.frame")
  expect_named(aa$result, c("code", "title"))
})

test_that("high level works - not parsing", {
  skip_on_cran()

  aa <- rl_measures('Fratercula arctica', parse = FALSE)

  expect_is(aa, "list")
  expect_named(aa, c("name", "result"))
  expect_is(aa$name, "character")
  expect_is(aa$result, "list")
  expect_named(aa$result[[1]], c("code", "title"))
})

test_that("low level works", {
  skip_on_cran()

  library("jsonlite")

  aa <- rl_measures_('Fratercula arctica')
  aajson <- jsonlite::fromJSON(aa)

  expect_is(aa, "character")
  expect_is(aajson, "list")
  expect_named(aajson, c("name", "result"))
})

test_that("no results", {
  skip_on_cran()

  aa <- rl_measures('Loxodonta asdfadf')

  expect_is(aa, "list")
  expect_is(aa$result, "list")
  expect_equal(length(aa$result), 0)
})
