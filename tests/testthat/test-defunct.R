test_that("defunct functions works", {
  lifecycle::expect_defunct(rl_common_names())
  lifecycle::expect_defunct(rl_common_names_())
  lifecycle::expect_defunct(rl_history())
  lifecycle::expect_defunct(rl_history_())
  lifecycle::expect_defunct(rl_measures())
  lifecycle::expect_defunct(rl_measures_())
  lifecycle::expect_defunct(rl_narrative())
  lifecycle::expect_defunct(rl_narrative_())
  lifecycle::expect_defunct(rl_occ_country())
  lifecycle::expect_defunct(rl_occ_country_())
  lifecycle::expect_defunct(rl_regions())
  lifecycle::expect_defunct(rl_regions_())
  lifecycle::expect_defunct(rl_search())
  lifecycle::expect_defunct(rl_search_())
  lifecycle::expect_defunct(rl_sp())
  lifecycle::expect_defunct(rl_sp_())
  lifecycle::expect_defunct(rl_sp_category())
  lifecycle::expect_defunct(rl_sp_category_())
  lifecycle::expect_defunct(rl_sp_citation())
  lifecycle::expect_defunct(rl_sp_citation_())
  lifecycle::expect_defunct(rl_sp_country())
  lifecycle::expect_defunct(rl_sp_country_())
  lifecycle::expect_defunct(rl_synonyms())
  lifecycle::expect_defunct(rl_synonyms_())
})
