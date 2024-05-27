library(dplyr)
library(ggplot2)

trend_data_gender_race <- prison_pop %>%
  filter(year >= 1990) %>%
  group_by(year) %>%
  summarise(
    black_male_prison_pop = sum(black_male_prison_pop, na.rm = TRUE),
    black_female_prison_pop = sum(black_female_prison_pop, na.rm = TRUE),
    white_male_prison_pop = sum(white_male_prison_pop, na.rm = TRUE),
    white_female_prison_pop = sum(white_female_prison_pop, na.rm = TRUE),
    latinx_male_prison_pop = sum(latinx_male_prison_pop, na.rm = TRUE),
    latinx_female_prison_pop = sum(latinx_female_prison_pop, na.rm = TRUE)
  ) %>%
  pivot_longer(cols = c(black_male_prison_pop, black_female_prison_pop, white_male_prison_pop, white_female_prison_pop, latinx_male_prison_pop, latinx_female_prison_pop), names_to = "group", values_to = "prison_pop")

trend_data_gender_race <- trend_data_gender_race %>%
  separate(group, into = c("race", "gender"), sep = "_", extra = "merge")

ggplot(trend_data_gender_race, aes(x = year, y = prison_pop, color = interaction(race, gender), group = interaction(race, gender))) +
  geom_line(size = 1) +
  labs(
    title = "Trends in U.S. Prison Populations by Race and Gender (1990 - Present)",
    x = "Year",
    y = "Prison Population",
    color = "Race and Gender"
  ) +
  theme_minimal()
