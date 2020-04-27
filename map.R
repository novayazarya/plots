library(dplyr)
library(readxl)
library(openxlsx)
library(eurostat)
library(mapproj)
library(ggplot2)

dat = read.xlsx("~/Study/R/map.xlsx")

maps_europe <- get_eurostat_geospatial(output_class = "df", resolution = "20", 
                                         nuts_level = "all", year = "2013") %>% 
  subset(LEVL_CODE > 0)

maps_europe <- left_join(dat, maps_europe, by = "geo")
temp <- ggplot(maps_europe, aes(x = long, y = lat, group = group)) +
  geom_polygon(data = maps_europe, aes(fill = av), color = "slategray", size = .1) +
  labs(title = "Parliamentary election voter turnout by NUTS 1-3 regions",
       subtitle = "Data from GPS (Falk, 2018)",
       fill = "Voter turnount, %") +
  theme_bw() +
  coord_map(xlim = c(-12, 44), ylim = c(35, 67))+
  scale_fill_gradient(low = "white", high = "steelblue3", na.value = "grey90")

# png(file="av_NUTS.png", width = 800, height = 750)

