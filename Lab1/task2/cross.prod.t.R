# if not installed, run first: install.packages("testthat")
library(testthat)

# load the function to be tested
source("cross.prod.f.R")

# Test 1: Valid case - "happy path"
test_that("Correct cross product (axes i, j -> k)", {
  x = c(1, 0, 0)
  y = c(0, 1, 0)
  
  # Expected result is vector (0, 0, 1)
  expected_result = c(0, 0, 1)

  # 'expect_equal' is the equivalent of 'assert result == expected_result'
  expect_equal(cross.prod(x, y), expected_result)
})

# Test 2: Another valid case
test_that("Correct cross product (vectors 1,2,3 and 4,5,6)", {
  x = c(1, 2, 3)
  y = c(4, 5, 6)
  
  # Expected result is vector (-3, 6, -3)
  # z[1] = 2*6 - 3*5 = 12 - 15 = -3
  # z[2] = 3*4 - 1*6 = 12 - 6 = 6
  # z[3] = 1*5 - 2*4 = 5 - 8 = -3
  expected_result = c(-3, 6, -3)

  expect_equal(cross.prod(x, y), expected_result)
})

# Test 3: Testing errors for wrong vector length
test_that("Error for vectors of wrong length", {
  x_ok = c(1, 2, 3)
  y_wrong = c(1, 2)

  # 'expect_error' is the equivalent of 'pytest.raises'
  # We check if the code throws an error of a *specific* class
  expect_error(cross.prod(x_ok, y_wrong), class = "InvalidLengthError")
  expect_error(cross.prod(y_wrong, x_ok), class = "InvalidLengthError")
})

# Test 4: Testing errors for wrong data type (text)
test_that("Error for non-numeric data (text)", {
  x_ok = c(1, 2, 3)
  y_wrong = c("a", "b", "c")

  expect_error(cross.prod(x_ok, y_wrong), class = "InvalidTypeError")
})

# Test 5: Testing errors for wrong data type (NA)
test_that("Error for non-numeric data (NA)", {
  x_ok = c(1, 2, 3)
  y_wrong = c(1, 2, NA)

  expect_error(cross.prod(x_ok, y_wrong), class = "InvalidTypeError")
})

# Test 6: Testing errors for wrong data type (NULL)
test_that("Error for non-numeric data (NULL)", {
  x_ok = c(1, 2, 3)
  y_wrong = NULL

  # NULL has length 0, so it will be caught by length validation
  expect_error(cross.prod(x_ok, y_wrong), class = "InvalidLengthError")
})

# Test 7: Check calculations for negative values
test_that("Correct product for negative values", {
  x = c(-1, 2, -3)
  y = c(4, -5, 6)

  # Expected result:
  # z[1] = 2*6 - (-3)*(-5) = 12 - 15 = -3
  # z[2] = (-3)*4 - (-1)*6 = -12 - (-6) = -6
  # z[3] = (-1)*(-5) - 2*4 = 5 - 8 = -3
  expected_result = c(-3, -6, -3)
  
  expect_equal(cross.prod(x, y), expected_result)
})

# Test 8: Check for complex (imaginary) numbers
test_that("Error for complex numbers", {
  x_ok = c(1, 2, 3)
  y_complex = c(1+1i, 2, 3) # is.numeric(1+1i) returns FALSE

  # The function's 'is.numeric' check should catch this.
  expect_error(cross.prod(x_ok, y_complex), class = "InvalidTypeError")
  expect_error(cross.prod(y_complex, x_ok), class = "InvalidTypeError")
})

# Test 9: Check calculations involving Infinity
test_that("Correctly handles Inf and NaN results", {
  x = c(Inf, Inf, 1)
  y = c(1, 1, 1)

  # Expected result:
  # z[1] = Inf*1 - 1*1 = Inf - 1 = Inf
  # z[2] = 1*1 - Inf*1 = 1 - Inf = -Inf
  # z[3] = Inf*1 - Inf*1 = Inf - Inf = NaN
  expected_result = c(Inf, -Inf, NaN)
  
  # The function should not error, but return Inf/NaN
  expect_equal(cross.prod(x, y), expected_result)
})

# Test 10: Check calculations for floating-point precision
test_that("Correct product for floating-point precision", {
  x = c(0.1, 0.2, 0.3)
  y = c(0.4, 0.5, 0.6)

  # Expected result:
  # z[1] = 0.2*0.6 - 0.3*0.5 = 0.12 - 0.15 = -0.03
  # z[2] = 0.3*0.4 - 0.1*0.6 = 0.12 - 0.06 = 0.06
  # z[3] = 0.1*0.5 - 0.2*0.4 = 0.05 - 0.08 = -0.03
  expected_result = c(-0.03, 0.06, -0.03)

  expect_equal(cross.prod(x, y), expected_result)
})

# Test 11: Testing errors for NaN values
test_that("Error for NaN (Not a Number) values", {
  v_ok = c(1, 2, 3)
  v_nan = c(1, NaN, 3)
  
  # We must add an anyNA() check in the function
  # to catch NA and NaN.
  expect_error(cross.prod(v_ok, v_nan), class = "InvalidTypeError")
})
