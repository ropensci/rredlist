context("package fails well")

test_that("fails well on bad key", {
  skip_on_cran()

  expect_error(rl_common_names('Loxodonta africana', key = "adfds"),
               "Token not valid")
  expect_error(rl_common_names_('Loxodonta africana', key = "adfds"),
               "Token not valid")
  # expect_is(aa$name, "character")
  # expect_is(aa$result, "data.frame")
  # expect_true(any(grepl("elephant", aa$result$taxonname, ignore.case = TRUE)))
})
