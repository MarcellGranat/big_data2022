library(stats)

library(xaringanthemer)
library(knitr)
library(granatlib)
library(emo)
library(magrittr)
library(tidyverse)
library(patchwork)

if (pandoc_from() == "markdown") {
  ggdark::invert_geom_defaults()
  theme_set(
    theme_minimal() +
      theme(
        legend.position = "bottom"
      )
  )

  ggdark::invert_geom_defaults()
} else {
  theme_set(
    ggdark::dark_theme_minimal() +
      theme(
        legend.position = "bottom",
        panel.background = element_rect(fill = "#161616"),
        plot.background = element_rect(fill = "#161616"),
        legend.background = element_rect(fill = "#161616"),
        legend.key = element_rect(fill = "#161616"),
        panel.grid = element_line(color = "gray20"),
      )
  )
}
