library(tidyverse)
library(glue)
library(png)
library(grid)

sunset_colors <- c("#FDE59D","#FF7449","#BC5748")
sand_colors <- c("#321801","black")
sea_col_dark <- c("#763827")
sea_col_light <- c("#964939","#F06F4B")

sunset_gradient <- colorRampPalette(sunset_colors)(701)
sea_gradient <- colorRampPalette(sea_col_light)(301)
sand_gradient <- colorRampPalette(sand_colors)(51)

sky <- tibble(x = 0, xend = 1000,
             y = 300:1000, yend = y,
             color = rev(sunset_gradient),
             group = glue("group{y}"))

sea <- tibble(x = 0, xend = 1000,
              y = 0:300, yend = y,
              color = rev(sea_gradient))

sand <- tibble(x = 0, xend = 1000,
              y = 0:50, yend = y,
              color = rev(sand_gradient))

umb_stick <- tibble(x = 700,xend=700, y=10, yend=750, color = "black")

set.seed(1234)
umbrella <- tibble(x = 700, y = 750, xend = sample(400:1000,500), yend = sample(450:550,500, replace = TRUE))

mom <- readPNG("2022-07-11_ColvaBeachSunset/mom2.png")
chairs <- readPNG("2022-07-11_ColvaBeachSunset/chairs2.png")

ggplot() +
  geom_segment(data = sky, aes(x = x, y = y, xend = xend, yend=yend), 
               color = sky$color, linewidth=5) +
  geom_segment(data = sea, aes(x = x, y = y, xend = xend, yend=yend), 
               color = sea$color, linewidth=5) +
  geom_segment(data = sand, aes(x = x, y = y, xend = xend, yend=yend), 
               color = sand$color, linewidth=5) +
  geom_segment(data = umb_stick, aes(x = x, y = y, xend = xend, yend=yend), 
               color = umb_stick$color, linewidth=5, lineend = "round") +
  geom_segment(data = umbrella, aes(x = x, y = y, xend = xend, yend=yend), 
               color = "black", linewidth=2, lineend = "round") +
  annotation_custom(rasterGrob(mom, height = 0.4, width=0.10), ymin = -450, xmin=-700) +
  annotation_custom(rasterGrob(chairs, height = 0.2, width=0.6), ymin = -715, xmin=350) +
  #coord_equal(xlim=c(0,1000),ylim=c(0,1000)) +
  theme_void()
