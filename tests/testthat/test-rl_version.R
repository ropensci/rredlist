context("rl_version functions")

test_that("rl_version works", {
  skip_on_cran()

  vcr::use_cassette("rl_version", {
    aa <- rl_version()

    expect_is(aa, "character")
    expect_match(aa, "[0-9]{4}-[0-9]")
  })
})

test_that("rl_version curl options work", {
  skip_on_cran()

  expect_error(rl_version(timeout_ms = 1), "Timeout was reached")
})
