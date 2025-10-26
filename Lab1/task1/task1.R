# Task 1. How to write numbers divisible by 3 without
# using the ifelse() statement or any other loops,
# using only indexing and which() functions?
# Use vector x <- 1:10 for testing.

x = 1:10
x[which(x %% 3 == 0)]
