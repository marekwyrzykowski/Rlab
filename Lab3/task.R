# Task 1: Generate (n=10^3) random numbers from the normal distribution with the mean (m=2) and the standard deviation (s=0.5) ((n), (m), (s) should be global variables which value can be modified in the script).
print("Task 1: Generating random numbers from the normal distribution")
n = 10^3
m = 2
s = 0.5
random_numbers = rnorm(n, mean = m, sd = s)

# Task 2: Then use the generated data to create a histogram and assign it to a new variable.
print("Task 2: Creating histogram of generated random numbers")
histogram_data = hist(random_numbers, plot = FALSE, breaks = 20)
print(histogram_data)

# Task 3: Make a scatter plot (discrete) of the empirical probability density function (this density can be obtained from the histogram object).
print("Task 3: Creating scatter plot of empirical probability density function")

x_theoretical = seq(min(histogram_data$breaks), max(histogram_data$breaks), length.out = 100)
y_theoretical = dnorm(x_theoretical, mean = m, sd = s)
max_y = max(histogram_data$density, y_theoretical)

###############
# Task 6 (1/2): Save the plot to the png file.
# Open the PNG device before plotting
print("Task 6 (1/2): Opening PNG device to save the plot")
png("empirical_vs_theoretical_density.png", width = 1920, height = 1080, res = 100)
###############

par(mar = c(5.1, 10.1, 4.1, 2.1))
plot(
  x = histogram_data$mids,
  y = histogram_data$density,
  xlab = "",
  ylab = "",
  main = "",
  ylim = c(0, max_y),
  pch = 19,
  col = "black",
  cex = 2,
  cex.axis = 2
)

# Task 4: Add a second series to the plot (a red line), which shows the precise (theoretical) values of probability density function of the normal distribution for the given parameters (m) and (s).
print("Task 4: Adding theoretical probability density function to the plot")
lines(
  x = x_theoretical,
  y = y_theoretical,
  col = "red",
  lwd = 2
)

# Task 5:  Rename the axis labels and add the legend according to the figure below. Make sure the red line does not extend from the chart (use ylim parameters and the max() function).
print("Task 5: Adding labels and legend to the plot")

title(
  main = "Empirical f(x) vs. Theoretical Density",
  xlab = "x",
  ylab = expression(f(x)),
  cex.lab = 2
)

legend(
  "topleft",
  legend = c("data", "fit"),
  col = c("black", "red"),
  pch = c(19, NA),
  lty = c(NA, 1),
  lwd = c(NA, 3),
  cex = 2
)

###############
# Task 6 (2/2): Close the file device.
dev.off()
print("Task 6 (2/2): Plot saved to file")
###############
