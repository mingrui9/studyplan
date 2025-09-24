#' Calculate Sample Size for ANCOVA
#'
#' This function calculates the required sample size per group for a two-sample
#' comparison with a continuous outcome, adjusting for covariates.
#'
#' @param alpha The significance level, typically 0.05.
#' @param power The desired statistical power, e.g., 0.8 for 80%.
#' @param effect_size_d The standardized effect size (Cohen's d) you wish to detect.
#' @param r_squared The proportion of variance in the outcome explained by the covariates.
#'
#' @return The required sample size per group.
#' @export
#' @importFrom stats qnorm
#'
#' @examples
#' calculate_sample_size(alpha = 0.05, power = 0.8, effect_size_d = 0.5, r_squared = 0.2)
calculate_sample_size <- function(alpha, power, effect_size_d, r_squared) {
  # Validate inputs
  if (!is.numeric(alpha) || length(alpha) != 1) {
    stop("alpha must be a single numeric value.")
  }
  if (alpha <= 0 || alpha >= 1) {
    stop("Alpha must be between 0 and 1.")
  }
  if (!is.numeric(power) || length(power) != 1) {
    stop("power must be a single numeric value.")
  }
  if (power <= 0 || power >= 1) {
    stop("Power must be between 0 and 1.")
  }
  if (!is.numeric(effect_size_d) || length(effect_size_d) != 1) {
    stop("effect_size_d must be a single numeric value.")
  }
  if (!is.numeric(r_squared) || length(r_squared) != 1) {
    stop("r_squared must be a single numeric value.")
  }

  # Z-scores for alpha and beta
  z_alpha <- qnorm(1 - alpha / 2)
  z_beta <- qnorm(power)

  # Calculate sample size per group
  n_per_group <- (2 * (z_alpha + z_beta)^2) / (effect_size_d^2 * (1 - r_squared))

  return(ceiling(n_per_group))
}

