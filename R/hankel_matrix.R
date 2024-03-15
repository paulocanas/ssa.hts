
#' Transform a vector/univariate time series in an hankel matrix
#'
#' @param y A vector or a time series
#' @param L A number.
#'
#' @return An hankel matrix.
#' @export
#'
#' @examples
#' y <- datasets::AirPassengers
#' L <- 12
#' hankel_matrix(y, L)
hankel_matrix <- function(y, L) {     # y is a vector and L is the window length
  n <- length(y)                      # Length of the vector
  m <- n - L + 1                      # Number of columns of the hankel matrix
  H <- matrix(0, nrow = L, ncol = m)  # Create a matrix of zeros
  for (i in 1:L) {
    for (j in 1:m) {
      H[i, j] <- y[i + j - 1]
    }
  }
  return(H)                           # Return the hankel matrix
}

# Teste the function
# y <- 1:100                          # for a simple vector
# L <- 12
# hankel_matrix(y, L)

# Test the function
# y <- datasets::AirPassengers                    # For a time series
# L <- 12
# hankel_matrix(AirPassengers, L)





#' Transform a hankel matrix in a vector
#'
#' @param H A hankel matrix.
#'
#' @return A vector.
#' @export
#'
#' @examples
#' y <- datasets::AirPassengers
#' L <- 12
#' H <- hankel_matrix(y, L)
#' hankel_vector(H)
hankel_vector <- function(H) {  # H is a hankel matrix
  L <- nrow(H)
  m <- ncol(H)
  y <- numeric(L + m - 1)     # Create a vector of zeros
  for (i in 1:L) {
    y[i] <- H[i, 1]           # Fill the vector with the first column of the hankel matrix
  }
  for (i in 2:m) {
    y[L + i - 1] <- H[L, i]   # Fill the vector with the last row of the hankel matrix
  }
  return(y)                   # Return the vector
}





# Path: hankel.R





