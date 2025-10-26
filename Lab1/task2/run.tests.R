# This script loads 'testthat' and runs the test file

# Step 1: Check if the 'testthat' package is installed
if (!requireNamespace("testthat", quietly = TRUE)) {
  
  # If 'testthat' is not installed, stop the script
  # and display a helpful message.
  stop(
    "The 'testthat' package is not installed.\n",
    "To run this script, please install 'testthat' first.\n\n",
    "Use this command in your R console:\n",
    "  install.packages(\"testthat\")\n"
  )
  
}

# Step 2: Load the library (we now know it exists)
library(testthat)

# Step 3: Run the tests from the specific file
# This command will display a nice, colorful report in the console
test_file("cross.prod.t.R")
