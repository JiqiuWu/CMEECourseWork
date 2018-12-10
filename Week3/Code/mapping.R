library(ggplot2)
library(maps)

MyData <- load("../data/GPDDFiltered.RData")
MyData_1 <- gpdd[,]

map(database = "world")

points(x = MyData_1$long, y = MyData_1$lat, pch = 21, bg = gpdd$common.name)

#Answer: I am nor familar with map data, let me think....