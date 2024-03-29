% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/hankel_matrix.R
\name{hankel_matrix}
\alias{hankel_matrix}
\title{Transform a vector/univariate time series in an hankel matrix}
\usage{
hankel_matrix(y, L)
}
\arguments{
\item{y}{A vector or a time series}

\item{L}{A number.}
}
\value{
An hankel matrix.
}
\description{
Transform a vector/univariate time series in an hankel matrix
}
\examples{
y <- datasets::AirPassengers
L <- 12
hankel_matrix(y, L)
}
