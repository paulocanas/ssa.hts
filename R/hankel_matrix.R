
#' Transform a vector/univariate time series in an hankel matrix
#'
#' @param x A vector or a time series
#' @param L A number.
#'
#' @return An hankel matrix.
#' @export
#'
#' @examples
#' x <- datasets::AirPassengers
#' L <- 12
#' hankel_matrix(x, L)
hankel_matrix <- function(x, L) {     # x is a vector and L is the window length
  n <- length(x)                      # Length of the vector
  m <- n - L + 1                      # Number of columns of the hankel matrix
  H <- matrix(0, nrow = L, ncol = m)  # Create a matrix of zeros
  for (i in 1:L) {
    for (j in 1:m) {
      H[i, j] <- x[i + j - 1]
    }
  }
  return(H)                           # Return the hankel matrix
}

# Teste the function
# x <- 1:100                          # for a simple vector
# L <- 12
# hankel_matrix(x, L)

# Test the function
# x <- datasets::AirPassengers                    # For a time series
# L <- 12
# hankel_matrix(AirPassengers, L)





# Transform a hankel matrix in a vector
hankel_vector <- function(H) {  # H is a hankel matrix
  L <- nrow(H)
  m <- ncol(H)
  x <- numeric(L + m - 1)     # Create a vector of zeros
  for (i in 1:L) {
    x[i] <- H[i, 1]           # Fill the vector with the first column of the hankel matrix
  }
  for (i in 2:m) {
    x[L + i - 1] <- H[L, i]   # Fill the vector with the last row of the hankel matrix
  }
  return(x)                   # Return the vector
}

# Teste the function
# H <- hankel_matrix(x, L)
# hankel_vector(H)



# Path: hankel.R





