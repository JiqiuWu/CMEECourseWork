MyData <- load("../data/KeyWestAnnualMeanTemperature.RData")
MyData_1 <- ats[,]
Year <- MyData_1[[1]]
Tempera <- MyData_1[[2]]
x_1 <- Tempera[1:99]
y_1 <- Tempera[2:100]
cor_1 <- cor(x_1, y_1)

MyData_2 <- sample(Tempera, size = 10000, replace = T)
x_2 <- MyData_2[1:9999]
y_2 <- MyData_2[2:10000]

cor_2 <- cor(x_2, y_2)

#print(cor_1)
#print(cor_2)
#print(cor_2/cor_1)


