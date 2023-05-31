library(ggmap)
library(ggpubr)
library(ggsci)
library(ggthemes)
library(maps)
library(tidyverse)
library(viridis)


setwd("/Users/auderset/Documents/GitHub/R_teach_in")

gl_curated <- read_tsv("data/glottolog_curated.tsv")
glimpse(gl_curated)
summary(gl_curated)


hist_endangerment <- ggplot(data = gl_curated, aes(x = Endangerment)) +
  geom_histogram(stat = "count") +
  theme_bw()
hist_endangerment


gl_curated <- gl_curated %>%
  mutate(Endangerment = factor(Endangerment, levels = c("Not endangered", "Shifting", "Threatened", "Moribund", "Nearly extinct", "Extinct")))
glimpse(gl_curated)


hist_endangerment <- ggplot(data = gl_curated, aes(x = Endangerment, fill = Macroarea)) +
  geom_histogram(stat = "count") +
  scale_fill_viridis(discrete = TRUE) +
  labs(x = "Endangerment Status", y = "Number of Languages") +
  theme_bw()
hist_endangerment

ggsave(file = "endangerment_histogram.png", plot = hist_endangerment, device = "png", path = "plots/", width = 20, units = "cm", dpi = 300)


map_am <- get_stamenmap(bbox = c(left = -170, bottom = -57, right = -30, top = 71), zoom = 3, maptype = "toner-lite")

map_am_end <- ggmap(map_am) +
  geom_point(data = gl_curated, aes(x = Longitude, y = Latitude, color = Endangerment), size = 3) +
  scale_color_viridis(discrete = TRUE) +
  theme_map()
map_am_end

ggsave(file = "map_americas.png", plot = map_am_end, device = "png", path = "plots/", height = 20, units = "cm", dpi = 300)


araona_vowels <- read_tsv("data/araona_vowels.tsv")
glimpse(araona_vowels)

scatter_f <- ggplot(data = filter(araona_vowels, F1_Hz<1000), aes(x = F2_Hz, y = F1_Hz, color = Vowel, label = Vowel)) +
  geom_text() +
  scale_x_reverse() +
  scale_y_reverse() +
  scale_color_nejm() +
  theme_bw()
scatter_f


