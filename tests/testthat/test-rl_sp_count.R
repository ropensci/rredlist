context("rl_sp_count functions")

test_that("high level functions", {
  skip_on_cran()

  vcr::use_cassette("rl_sp_count", {
    aa <- rl_sp_count()
  })
  expect_is(aa, "integer")

})

test_that("low level works", {
  skip_on_cran()

  vcr::use_cassette("rl_sp_count_", {
    aa <- rl_sp_count_()
  })

  aajson <- jsonlite::fromJSON(aa)

  expect_is(aa, "character")
  expect_is(aajson, "list")
  expect_is(aajson$count, "integer")
})

test_that("fails well", {
  skip_on_cran()

  expect_error(rl_sp_count(key = 5), "key must be of class character")
  expect_error(rl_sp_count(key = matrix()), "key must be of class character")
})
