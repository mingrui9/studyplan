#' @importFrom stats qnorm
#' @title Calculate Required Sample Size for a Clinical Trial
#'
#' @description This function calculates the required sample size per group for a two-sample
#'   comparison (e.g., a t-test or ANCOVA) to achieve a desired level of statistical power.
#'   The formula adjusts for the variance explained by covariates ($R^2$).
#'
#' @param power The desired statistical power (e.g., 0.90 for 90%).
#' @param alpha The significance level (e.g., 0.05).
#' @param effect_size_d The standardized effect size (Cohen's d).
#' @param r_squared The expected $R^2$ value from the ANCOVA model, representing the
#'   proportion of variance explained by covariates.
#'
#' @return The required sample size per group (rounded up to the nearest integer).
#' @export
#'
#' @examples
#' # Calculate sample size for 90% power, 0.54 SD effect, and R^2=0.05
#' calculate_sample_size(
#'   power = 0.90,
#'   alpha = 0.05,
#'   effect_size_d = 0.54,
#'   r_squared = 0.05
#' )
calculate_sample_size <- function(power, alpha, effect_size_d, r_squared) {
  if (power <= 0 || power >= 1) stop("Power must be between 0 and 1.")
  if (alpha <= 0 || alpha >= 1) stop("Alpha must be between 0 and 1.")
  if (effect_size_d <= 0) stop("Effect size must be a positive value.")
  if (r_squared < 0 || r_squared >= 1) stop("R^2 must be between 0 and 1.")

  z_alpha_half <- qnorm(1 - alpha / 2)
  z_beta <- qnorm(power)

  n_per_group <- (2 * (z_alpha_half + z_beta)^2) / (effect_size_d^2 * (1 - r_squared))

  return(ceiling(n_per_group))
}
