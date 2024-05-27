library(dplyr)

# 1. Average total prison population across all counties
average_total_prison_pop <- prison_pop %>%
  summarise(avg_total_prison_pop = mean(total_prison_pop, na.rm = TRUE))

# 2. Highest white prison population
highest_white_prison_pop <- prison_pop %>%
  filter(white_prison_pop == max(white_prison_pop, na.rm = TRUE)) %>%
  select(white_prison_pop)

# 3.Lowest White prison population
lowest_white_prison_pop <- prison_pop %>%
  filter(white_prison_pop == min(white_prison_pop, na.rm = TRUE)) %>%
  select(white_prison_pop)

# 4. Average of change in the total prison population over the past 5 years
change_over_time <- prison_pop %>%
  group_by(year) %>%
  summarise(avg_prison_pop = mean(total_prison_pop, na.rm = TRUE)) %>%
  mutate(change = avg_prison_pop - lag(avg_prison_pop)) 

recent_change <- change_over_time %>%
  filter(year %in% (max(year) - 4):max(year))

# Calculate the average change over the past 10 years
average_recent_change <- recent_change %>%
  summarise(avg_change = mean(change, na.rm = TRUE))



# 5. Average male prison population
average_male_prison_pop <- prison_pop %>%
  summarise(avg_male_prison_pop = mean(male_prison_pop, na.rm = TRUE))

# Print the summary values
average_total_prison_pop
highest_white_prison_pop
lowest_white_prison_pop
average_recent_change
average_male_prison_pop

