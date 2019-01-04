library(gcookbook)
library(ggplot2)

model <- lm(heightIn ~ ageYear + I(ageYear^2),heightweight)

xmin <- min(heightweight$ageYear)
xmax <- max(heightweight$ageYear)
predicted <- data.frame(ageYear = seq(xmin, xmax, length.out = 100))

predicted$heightIn <- predict(model, predicted)

sp <- ggplot(heightweight, aes(x = ageYear, y = heightIn)) + geom_point(colour = "grey40")
sp + geom_line(data = predicted, size = 1)
