context("package fails well")

test_that("fails well on bad key", {
  skip_on_cran()

  expect_error(rl_common_names('Loxodonta africana', key = "adfds"),
               "Token not valid")
  expect_error(rl_common_names_('Loxodonta africana', key = "adfds"),
               "Token not valid")
})

test_that("fails well when correct parameters not given", {
  skip_on_cran()

  expect_error(rl_search(), "is not TRUE")
  expect_error(rl_search_(), "is not TRUE")
})

test_that("fails well when an invalid region passed", {
  skip_on_cran()

  # results in an `error` slot, which we catch

  expect_error(rl_habitats(id = 22694927, region = 34234),
               "Region not found.")
  expect_error(rl_habitats_(id = 22694927, region = 34234),
               "Region not found.")

  expect_error(rl_search(id = 22694927, region = '3wer'),
               "Region not found.")
  expect_error(rl_search_(id = 22694927, region = '3wer'),
               "Region not found.")

  expect_error(rl_measures(id = 22694927, region = '3wer'),
               "Region not found.")
  expect_error(rl_measures_(id = 22694927, region = '3wer'),
               "Region not found.")
})
