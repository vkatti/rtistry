library(tidyverse)

petal_rows <- 6

generate_num_petals <- function(n) {
  stopifnot("petal_rows must be 3 or more" = n>=3)
  x = numeric(n)
  x[1:2] = c(5,8)
  for(i in 3:n) x[i] = x[i-1] + x[i-2]
  return(x)
}

num_petals <- generate_num_petals(petal_rows)

petal_sizes <- seq(0.25, 1.0 , length.out = length(num_petals))
petal_offsets <- seq(0.1, 0.25, length.out = length(num_petals))

doubler <- function(z) z*2L

create_tibble <- function(a, b, c) {
  tibble(x = seq(0,100,length.out=doubler(a)+1),
         y = c(rep(c(b-c,b),a),b-c),
         group = glue::glue("Group{100-a}"))
}

flower1 <- pmap_dfr(list(rev(num_petals), rev(petal_sizes), petal_offsets), create_tibble)

ggplot(data = flower1, mapping = aes(x=x,y=y, group = group, fill = group
                                     #, alpha=group
                                     )) +
  geom_path(color="black", linewidth=2)+
  geom_polygon() +
  scale_fill_manual(values = colorRampPalette(c("red4","yellow"))(length(num_petals)))+
  #scale_alpha_discrete(seq(1,0.6, length.out = 16)) +
  scale_y_continuous(limits = c(0,1))+
  coord_polar() +
  theme_void() +
  theme(legend.position = "none", 
        panel.background = element_rect(fill = "black"),
        plot.background = element_rect(fill = "black"),
        ) +
  NULL



