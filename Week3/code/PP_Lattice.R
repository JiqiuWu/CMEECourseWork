MyData <- read.csv("../data/EcolArchives-E089-51-D1.csv", header = T, stringsAsFactors = F)

library(lattice)
library(plyr)

pdf("../results/Pred_Lattice.pdf")
densityplot(~log(Predator.mass) | Type.of.feeding.interaction, data=MyData)
graphics.off()

pdf("../results/Prey_Lattice.pdf")
densityplot(~log(Prey.mass) | Type.of.feeding.interaction, data=MyData)
graphics.off()

pdf("../results/SizeRation_Lattice.pdf")
densityplot(~log(Prey.mass)/log(Predator.mass) | Type.of.feeding.interaction, data=MyData)
graphics.off()

PPResults <- ddply(MyData, ~ Type.of.feeding.interaction, summarize, 
                   MeanMassPred = mean(log(Predator.mass)), 
                   MedianMassPred = median(log(Predator.mass)), 
                   MeanMassPrey = mean(log(Prey.mass)), 
                   MedianMassPrey = median(log(Prey.mass)),
                   MeanRatio = mean(log(Predator.mass/Prey.mass)), 
                   MedianRatio = median(log(Predator.mass/Prey.mass)))


write.csv(PPResults, file = "../results/PP_Results.csv", row.names = F)



