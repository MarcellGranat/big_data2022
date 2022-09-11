life_exp <- read_csv("https://stats.oecd.org/sdmx-json/data/DP_LIVE/.LIFEEXP.../OECD?contentType=csv&detail=code&separator=comma&csv-lang=en") %>%
  filter(SUBJECT == "TOT") %>%
  select(LOCATION, TIME, life_exp = Value)

fertility <- read_csv("https://stats.oecd.org/sdmx-json/data/DP_LIVE/.FERTILITY.../OECD?contentType=csv&detail=code&separator=comma&csv-lang=en") %>%
  select(LOCATION, TIME, fertility = Value)

population <- read_csv("https://stats.oecd.org/sdmx-json/data/DP_LIVE/.POP.../OECD?contentType=csv&detail=code&separator=comma&csv-lang=en") %>%
  filter(MEASURE == "MLN_PER", SUBJECT == "TOT") %>%
  select(LOCATION, TIME, population = Value)

demography_df <- life_exp %>%
  inner_join(fertility) %>%
  inner_join(population) %>%
  filter(TIME >= 1980)

library(gganimate)

p <- demography_df %>%
  drop_na() %>%
  mutate(
    n = n(),
    l = LOCATION,
    l = ifelse(population > 3e1, l, NA),
    TIME = as.integer(TIME)
  ) %>%
  ggplot() +
  aes(life_exp, fertility) +
  geom_point(aes(size = population), shape = 21, color = "black",
             fill = "#378C95", alpha = .6, show.legend = FALSE) +
  geom_text(aes(label = l)) +
  scale_size(range = c(5, 30)) +
  theme_minimal() +
  theme(
    axis.title = element_text(size = 14),
    axis.text = element_text(size = 12)
  ) +
  labs(y = "Fertility rate", x = "Life expectancy at birth", title = "{frame_time}") +
  gganimate::transition_time(TIME) +
  shadow_wake(wake_length = 0.1, alpha = FALSE, exclude_layer = 2)


animate(p + enter_fade() + exit_shrink(), fps = 50, nframes = 250, device = "svg")

anim_save(filename = "demography.gif")
