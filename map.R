library(dplyr)
library(ggplot2)
library(readr)
library(maps)

prison_pop <- read_csv("https://raw.githubusercontent.com/melaniewalsh/Neat-Datasets/main/us-prison-pop.csv")

state_prison_pop <- prison_pop %>%
  group_by(state) %>%
  summarise(total_prison_pop = sum(total_prison_pop, na.rm = TRUE))

states_map <- map_data("state")

state_prison_pop$state <- tolower(state.name[match(state_prison_pop$state, state.abb)])

map_data_prison <- merge(states_map, state_prison_pop, by.x = "region", by.y = "state", all.x = TRUE)

ggplot(data = map_data_prison, aes(x = long, y = lat, group = group, fill = total_prison_pop)) +
  geom_polygon(color = "white") +
  scale_fill_continuous(name = "Total Prison Population", low = "lightblue", high = "darkblue") +
  labs(
    title = "Geographic Distribution of Prison Population by State",
    x = "",
    y = ""
  ) +
  coord_map() +
  theme_minimal()
