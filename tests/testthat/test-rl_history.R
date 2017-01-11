context("rl_history functions")

test_that("high level works - parsing", {
  skip_on_cran()

  aa <- rl_history('Loxodonta africana')

  expect_is(aa, "list")
  expect_is(aa$name, "character")
  expect_is(aa$result, "data.frame")
  expect_true(any(grepl("Vulnerable", aa$result$category, ignore.case = TRUE)))
})

test_that("high level works - not parsing", {
  skip_on_cran()

  aa <- rl_history('Loxodonta africana', parse = FALSE)

  expect_is(aa, "list")
  expect_is(aa$name, "character")
  expect_is(aa$result, "list")
  expect_true(any(grepl("Vulnerable", vapply(aa$result, "[[", "", "category"), ignore.case = TRUE)))
})

test_that("high level works - by ID", {
  skip_on_cran()

  aa <- rl_history(id = 12392)

  expect_is(aa, "list")
  expect_is(aa$name, "character")
  expect_is(aa$result, "data.frame")
  expect_true(any(grepl("Vulnerable", aa$result$category, ignore.case = TRUE)))
})

test_that("high level works - region", {
  skip_on_cran()

  aa <- rl_history(id = 22823, region = 'europe')
  bb <- rl_history(id = 22823, region = 'mediterranean')

  expect_is(aa, "list")
  expect_named(aa, c('name', 'region_identifier', 'result'))
  expect_is(aa$name, "character")
  expect_is(aa$result, "data.frame")
  expect_gt(NROW(aa$result), 0)

  expect_is(bb, "list")
  expect_named(bb, c('name', 'region_identifier', 'result'))
  expect_is(bb$name, "character")
  expect_is(bb$result, "list")
  expect_equal(length(bb$result), 0)
})

test_that("low level works", {
  skip_on_cran()

  library("jsonlite")

  aa <- rl_history_('Ursus maritimus', region = 'europe')

  expect_is(aa, "character")
  expect_is(jsonlite::fromJSON(aa), "list")
})

test_that("fails well", {
  skip_on_cran()

  expect_error(rl_history(), "is not TRUE")
})
