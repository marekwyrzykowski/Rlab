# task 1
# Load into memory the set of measurements from the simulation located in the file er_N1000_k8_O0.1_part1.txt
print("Task 1: Loading data from file")
data = read.table("er_N1000_k8_O0.1_part1.txt", header = TRUE)
print(head(data, 6))


# task 2
# Using the pipe operator and the group_by() and summarise() functions, calculate following quantities for each combination of rate, observers, method variables:
# -average precision,
# -quantile of order (alpha = 0.95) (the quantile() function) of the rank variable,
# -average time.
print("Task 2: Summarizing data")
library(dplyr)
summary_data = data %>%
  group_by(rate, observers, method) %>%
  summarise(
    prec.mean = mean(precision),
    css0.95 = quantile(rank, 0.95),
    time.mean = mean(time)
  )
print(summary_data)


# task 3
#  Using the data frame from previous task and the filter(), group_by(), summarise() and which.min() functions, see which method has the lowest average precision for BC observers.
print("Task 3: Finding method with lowest average precision for BC observers")
bc_lowest_precision = summary_data %>%
  filter(observers == "BC") %>%
  group_by(rate) %>%
  summarise(
    method.worst = method[which.min(prec.mean)],
    .groups = 'drop'
  )
print(bc_lowest_precision)


# task 4
# Transform the table from task 2 by changing it to a wide table. Let the columns contain the average precision for different cases from the method column (omit the css0.95 and time.mean columns for appropriate effect).
print("Task 4: Transforming data to wide format")
library(tidyr)
wide_data = summary_data %>%
  select(rate, observers, method, prec.mean) %>%
  pivot_wider(names_from = method, values_from = prec.mean)
print(wide_data)


# task 5
# Using the filter() function, select only variants with random observers from the table above.
print("Task 5: Filtering data for random observers")
random_observers_data = wide_data %>%
  filter(observers == "Random")
print(random_observers_data)
