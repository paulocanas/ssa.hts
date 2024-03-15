test_that("ssa.fit works", {
  s<- ssa(AirPassengers[1:20], L=10, groups=5)
  s1<- Rssa::ssa(AirPassengers[1:20], L=10)
  r1<- Rssa::reconstruct(s1, L=10, groups=list(1:5))
  expect_equal(s$approximation, r1$F1)
  expect_equal(s$residual, residuals(r1))
})
