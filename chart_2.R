library(dplyr)
library(ggplot2)

prison_pop <- read_csv("https://raw.githubusercontent.com/melaniewalsh/Neat-Datasets/main/us-prison-pop.csv")
chart2_data <- prison_pop %>%
  filter(!is.na(total_prison_pop) & !is.na(female_prison_pop))

ggplot(data = chart2_data, aes(x = total_prison_pop, y = female_prison_pop)) +
  geom_point(color = "grey") +
  geom_smooth(method=lm, color= "blue",  se=FALSE) +
  labs(title = paste("Relationship Between Prison Population and Female",
                     "Prison Population"),
       x = "Total Prison Population",
       y = "Female Prison Population")