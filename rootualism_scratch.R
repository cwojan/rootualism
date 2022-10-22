## rootualism scratch

library(ggplot2)
library(tidyverse)

size <- 20

garden <- tibble(tile = factor(rep(c("air", "ground"), each = size)),
                 x = rep(1:5, 8),
                 y = rep(8:1, each = 5))

plant <- tibble(growth = c("root", "shoot"),
                type = c("root", "leaf"),
                loc = "core",
                x = c(3,3),
                y = c(4,5))

plant <- plant %>%
  bind_rows(tibble(growth = rep("shoot", 4),
                   type = "leaf",
                   x = c(1,2,4,5),
                   y = 5))


plant <- plant %>%
  mutate(fx = factor(x, levels = c("1", "2", "3", "4", "5")))

ggplot() +
  geom_tile(data = garden,
            aes(x = x, y = y, fill = tile),
            color = "black", alpha = 0.7) +
  geom_tile(data = filter(plant, loc == "core"),
            aes(x = x, y = y, fill = growth),
            width = 0.5) +
  geom_tile(data = plant,
            aes(x = x, y = y, fill = growth),
            height = 0.2) +
  coord_fixed(xlim = c(0,6), ylim = c(0,9), expand = FALSE) +
  scale_fill_manual(values = c("skyblue", "tan3", "tan4", "darkgreen"), guide = "none") +
  theme_void()
  
ggplot(data = tibble(x = 1, y = 1), aes(x =x, y=y)) +  
  geom_point(shape = "\u00A9", size = 10) 
