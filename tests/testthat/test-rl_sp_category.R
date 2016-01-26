context("rl_sp_category functions")

test_that("high level works - parsing", {
  skip_on_cran()

  aa <- rl_sp_category('VU')

  expect_is(aa, "list")
  expect_named(aa, c("name", "count", "result"))
  expect_is(aa$name, "character")
  expect_is(aa$count, "integer")
  expect_is(aa$result, "data.frame")
  expect_named(aa$result,
               c('accepted_id', 'accepted_name', 'authority', 'synonym', 'syn_authority'))
})

test_that("high level works - not parsing", {
  skip_on_cran()

  aa <- rl_sp_category('Loxodonta africana', parse = FALSE)

  expect_is(aa, "list")
  expect_named(aa, c("name", "count", "result"))
  expect_is(aa$name, "character")
  expect_is(aa$count, "integer")
  expect_is(aa$result, "list")
  expect_named(aa$result[[1]],
               c('accepted_id', 'accepted_name', 'authority', 'synonym', 'syn_authority'))
})

test_that("low level works", {
  skip_on_cran()

  library("jsonlite")

  aa <- rl_sp_category_('Loxodonta africana')
  aajson <- jsonlite::fromJSON(aa)

  expect_is(aa, "character")
  expect_is(aajson, "list")
  expect_named(aajson, c("name", "count", "result"))
})

test_that("no results", {
  skip_on_cran()

  aa <- rl_sp_category('Loxodonta asdfadf')

  expect_is(aa, "list")
  expect_is(aa$result, "list")
  expect_equal(length(aa$result), 0)
})
