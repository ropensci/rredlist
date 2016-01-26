context("rl_threats functions")

test_that("high level works - parsing", {
  skip_on_cran()

  aa <- rl_threats('Fratercula arctica')

  expect_is(aa, "list")
  expect_named(aa, c("name", "result"))
  expect_is(aa$name, "character")
  expect_is(aa$result, "data.frame")
  expect_named(aa$result[,1:3], c("code", "title", "timing"))
})

test_that("high level works - not parsing", {
  skip_on_cran()

  aa <- rl_threats('Fratercula arctica', parse = FALSE)

  expect_is(aa, "list")
  expect_named(aa, c("name", "result"))
  expect_is(aa$name, "character")
  expect_is(aa$result, "list")
  expect_named(aa$result[[1]][1:3], c("code", "title", "timing"))
})

test_that("low level works", {
  skip_on_cran()

  library("jsonlite")

  aa <- rl_threats_('Fratercula arctica')
  aajson <- jsonlite::fromJSON(aa)

  expect_is(aa, "character")
  expect_is(aajson, "list")
  expect_named(aajson, c("name", "result"))
})

test_that("no results", {
  skip_on_cran()

  aa <- rl_threats('Loxodonta asdfadf')

  expect_is(aa, "list")
  expect_is(aa$result, "list")
  expect_equal(length(aa$result), 0)
})
