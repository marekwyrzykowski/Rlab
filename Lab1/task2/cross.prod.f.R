# Task 2. Write a function cross.prod(x,y) that will perform
# the cross product of two three-element vectors.

cross.prod = function(x, y) {
    # Input length validation
    if (length(x) != 3 || length(y) != 3) {
        stop(structure(
          list(message = "Vectors must be of length 3."),
          class = c("InvalidLengthError", "error", "condition")
        ))
    }

    # Input type validation
    if (!is.numeric(x) || !is.numeric(y)) {
        stop(structure(
          list(message = "Vectors must be numeric."),
          class = c("InvalidTypeError", "error", "condition")
        ))
    }

    # Additional check to ensure inputs are vectors and do not contain NA
    if (!is.vector(x) || !is.vector(y)) {
        stop(structure(
          list(message = "Inputs must be vectors."),
          class = c("InvalidTypeError", "error", "condition")
        ))
    }

    # Check for NA values
    if (any(is.na(x)) || any(is.na(y))) {
        stop(structure(
          list(message = "Vectors cannot contain NA values."),
          class = c("InvalidTypeError", "error", "condition")
        ))
    }

    z = numeric(3)
    
    z[1] = x[2] * y[3] - x[3] * y[2]
    z[2] = x[3] * y[1] - x[1] * y[3]
    z[3] = x[1] * y[2] - x[2] * y[1]
    
    return(z)
}
