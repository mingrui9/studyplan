#' Evaluate Budget Scenarios
#'
#' This function takes a data frame of budget scenarios and calculates the total cost for each scenario.
#' It checks for invalid inputs and missing columns.
#'
#' @param df A data frame with columns `total_n`, `mri_n`, `cost_per_subject`, and `cost_per_mri`.
#'
#' @return A data frame with a new column `total_cost` added.
#' @export
#'
#' @examples
#' budget_scenarios <- data.frame(
#'   total_n = c(100, 150),
#'   mri_n = c(10, 20),
#'   cost_per_subject = c(500, 550),
#'   cost_per_mri = c(1000, 1100)
#' )
#' evaluate_budget_scenarios(budget_scenarios)

evaluate_budget_scenarios <- function(df) {
  # Check if df is a data frame
  if (!is.data.frame(df)) {
    stop("df must be a data frame.")
  }

  # Check for required columns
  required_columns <- c("total_n", "mri_n", "cost_per_subject", "cost_per_mri")
  if (!all(required_columns %in% names(df))) {
    stop("Data frame is missing required columns: ", paste(setdiff(required_columns, names(df)), collapse = ", "))
  }

  # Calculate total cost for each scenario
  df$total_cost <- (df$total_n * df$cost_per_subject) + (df$mri_n * df$cost_per_mri)

  return(df)
}
