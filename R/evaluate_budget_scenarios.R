#' @title Evaluate Clinical Trial Budget Scenarios
#'
#' @description This function evaluates different study configurations based on a fixed budget
#'   and a range of total sample sizes. It calculates the number of participants
#'   that can be included in an expensive subgroup (e.g., with MRIs) for each scenario.
#'
#' @param total_budget The total budget for the study.
#' @param cost_base The base cost per participant (e.g., for standard visits).
#' @param cost_mri The cost for a participant with the expensive subgroup (e.g., with MRI visits).
#' @param n_start The starting total sample size for the evaluation range.
#' @param n_end The ending total sample size for the evaluation range.
#' @param step The step size for the total sample size.
#'
#' @return A data frame containing the total sample size ($N$), the number of
#'   participants with MRIs (\eqn{N_{MRI}}), and the total cost for each scenario.
#' @export
#'
#' @examples
#' # Evaluate scenarios for a $1M budget, assuming a 0.54 SD effect size
#' evaluate_budget_scenarios(
#'   total_budget = 1000000,
#'   cost_base = 5000,
#'   cost_mri = 15000,
#'   n_start = 100,
#'   n_end = 200,
#'   step = 10
#' )
evaluate_budget_scenarios <- function(total_budget, cost_base, cost_mri, n_start, n_end, step) {
  if (total_budget <= 0) stop("Total budget must be a positive value.")
  if (cost_base <= 0) stop("Base cost must be a positive value.")
  if (cost_mri <= cost_base) stop("MRI cost must be greater than base cost.")

  n_total_range <- seq(n_start, n_end, by = step)
  scenarios <- data.frame(
    Total_N = integer(),
    MRI_Subgroup = integer(),
    Total_Cost = numeric()
  )

  for (n_total in n_total_range) {
    n_mri <- (total_budget - (n_total * cost_base)) / (cost_mri - cost_base)

    # Only include scenarios with a valid number of MRI participants
    if (n_mri >= 0 && n_mri %% 1 == 0) {
      total_cost <- (n_total - n_mri) * cost_base + n_mri * cost_mri
      scenarios <- rbind(scenarios, data.frame(
        Total_N = n_total,
        MRI_Subgroup = n_mri,
        Total_Cost = total_cost
      ))
    }
  }

  return(scenarios)
}
