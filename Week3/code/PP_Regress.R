pdf("../results/PP_Regress.pdf")

MyData <- read.csv("../data/EcolArchives-E089-51-D1.csv", header = T, stringsAsFactors = F)

library(ggplot2)

p <- ggplot(MyData, aes(x = Prey.mass, y = Predator.mass, col = MyData$Predator.lifestage)) + geom_point(shape = I(3)) + facet_grid(Type.of.feeding.interaction ~ .) 
p <- p + xlab("Prey Mass in grams") + ylab("Predator Mass in grams")
p <- p + stat_smooth(method = lm, fullrange = TRUE, se = T) + scale_y_continuous(trans = "log10") + scale_x_continuous(trans = "log10")
p <- p + theme_bw()  + theme(legend.position = "bottom") + guides(color = guide_legend(nrow=1))

graphics.off()



