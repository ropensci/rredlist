context("rl_key functions")

test_that("rl_key produces expected URL and message", {
  suppressMessages(expect_equal(rl_use_iucn(),
                                "https://api.iucnredlist.org/users/sign_up"))
  expect_message(rl_use_iucn(), "After getting your key set")
})
