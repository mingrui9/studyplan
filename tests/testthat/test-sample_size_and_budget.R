# Load the package
library(testthat)
library(studyplan)

test_that("calculate_sample_size returns a numeric value", {
  result <- calculate_sample_size(alpha = 0.05, power = 0.8, effect_size = 0.5, r_squared = 0.5)
  expect_type(result, "double")
})

test_that("calculate_sample_size handles invalid input", {
  # The test now expects the correct error message from the function
  expect_error(
    calculate_sample_size(alpha = "invalid", power = 0.8, effect_size = 0.5, r_squared = 0.5),
    "Alpha must be between 0 and 1"
  )
})
