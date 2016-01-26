context("rl_sp_category functions")

test_that("high level works - parsing", {
  skip_on_cran()

  aa <- rl_sp_category('VU')

  expect_is(aa, "list")
  expect_named(aa, c("count", "category", "result"))
  expect_is(aa$count, "integer")
  expect_is(aa$category, "character")
  expect_equal(aa$category, "VU")
  expect_is(aa$result, "data.frame")
  expect_named(aa$result,
               c('taxonid', 'scientific_name', 'subspecies', 'rank', 'subpopulation'))
})

test_that("high level works - not parsing", {
  skip_on_cran()

  aa <- rl_sp_category('VU', parse = FALSE)

  expect_is(aa, "list")
  expect_named(aa, c("count", "category", "result"))
  expect_is(aa$count, "integer")
  expect_is(aa$category, "character")
  expect_equal(aa$category, "VU")
  expect_is(aa$result, "list")
  expect_named(aa$result[[1]],
               c('taxonid', 'scientific_name', 'subspecies', 'rank', 'subpopulation'))
})

test_that("low level works", {
  skip_on_cran()

  library("jsonlite")

  aa <- rl_sp_category_('VU')
  aajson <- jsonlite::fromJSON(aa)

  expect_is(aa, "character")
  expect_is(aajson, "list")
  expect_named(aajson, c("count", "category", "result"))
})

test_that("no results", {
  skip_on_cran()

  aa <- rl_sp_category('asdfad')

  expect_is(aa, "list")
  expect_is(aa$result, "list")
  expect_equal(length(aa$result), 0)
})
