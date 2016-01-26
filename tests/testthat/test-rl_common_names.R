context("rl_common_names functions")

test_that("high level works - parsing", {
  skip_on_cran()

  aa <- rl_common_names('Loxodonta africana')

  expect_is(aa, "list")
  expect_is(aa$name, "character")
  expect_is(aa$result, "data.frame")
  expect_true(any(grepl("elephant", aa$result$taxonname, ignore.case = TRUE)))
})

test_that("high level works - not parsing", {
  skip_on_cran()

  aa <- rl_common_names('Loxodonta africana', parse = FALSE)

  expect_is(aa, "list")
  expect_is(aa$name, "character")
  expect_is(aa$result, "list")
  expect_true(any(grepl("elephant", vapply(aa$result, "[[", "", "taxonname"), ignore.case = TRUE)))
})

test_that("low level works", {
  skip_on_cran()

  library("jsonlite")

  aa <- rl_common_names_('Loxodonta africana')

  expect_is(aa, "character")
  expect_is(jsonlite::fromJSON(aa), "list")
})


test_that("no results", {
  skip_on_cran()

  aa <- rl_common_names('Loxodonta asdfadf')

  expect_is(aa, "list")
  expect_is(aa$result, "list")
  expect_equal(length(aa$result), 0)
})
