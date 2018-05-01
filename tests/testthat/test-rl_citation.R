context("rl_citation functions")

test_that("rl_citation works", {
  skip_on_cran()

  vcr::use_cassette("rl_citation", {
    aa <- rl_citation()
  })

  expect_is(aa, "character")
  expect_match(aa, "IUCN")
  expect_match(aa, "www.iucnredlist.org")
})

test_that("rl_citation curl options work", {
  skip_on_cran()

  expect_error(rl_citation(timeout_ms = 1), "Timeout was reached")
})
