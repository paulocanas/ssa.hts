test_that("hankel_matrix works", {
  x <- 1:100
  L <- 12
  expect_equal(Rssa::hankel(x, L), hankel_matrix(x, L))
})
