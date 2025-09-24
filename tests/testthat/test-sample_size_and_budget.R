# Load the package
library(testthat)
library(studyplan)

test_that("calculate_sample_size returns a numeric value and handles invalid input", {
  # Test with valid inputs
  result <- calculate_sample_size(alpha = 0.05, power = 0.8, effect_size = 0.5, r_squared = 0.5)
  expect_type(result, "double")

  # Test for invalid alpha
  expect_error(
    calculate_sample_size(alpha = "invalid", power = 0.8, effect_size = 0.5, r_squared = 0.5),
    "alpha must be a single numeric value."
  )
  expect_error(
    calculate_sample_size(alpha = 1.1, power = 0.8, effect_size = 0.5, r_squared = 0.5),
    "Alpha must be between 0 and 1"
  )

  # Test for invalid power
  expect_error(
    calculate_sample_size(alpha = 0.05, power = "invalid", effect_size = 0.5, r_squared = 0.5),
    "power must be a single numeric value."
  )
  expect_error(
    calculate_sample_size(alpha = 0.05, power = 1.1, effect_size = 0.5, r_squared = 0.5),
    "Power must be between 0 and 1"
  )
})

test_that("evaluate_budget_scenarios returns a data frame and handles invalid input", {
  # Create a sample budget data frame
  budget_df <- data.frame(
    description = c("Scenario A", "Scenario B"),
    total_n = c(100, 150),
    mri_n = c(10, 20),
    cost_per_subject = c(500, 550),
    cost_per_mri = c(1000, 1100)
  )

  # Test with valid inputs
  result <- evaluate_budget_scenarios(budget_df)
  expect_s3_class(result, "data.frame")
  expect_true("total_cost" %in% names(result))

  # Test for invalid input
  expect_error(
    evaluate_budget_scenarios("not a data frame"),
    "df must be a data frame"
  )

  # Test for missing columns
  invalid_df <- data.frame(total_n = c(100, 150))
  expect_error(
    evaluate_budget_scenarios(invalid_df),
    "Data frame is missing required columns"
  )
})
