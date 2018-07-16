context("test-rl_key")

test_that("rl_key produces expected URL and message", {
  expect_equal(rl_use_iucn(), "http://apiv3.iucnredlist.org/api/v3/token")
  expect_message(rl_use_iucn(), "After getting your key set")
})
