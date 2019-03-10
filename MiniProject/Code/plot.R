rm(list = ls())
graphics.off()

#load libraries
library(ggplot2)
library(dplyr)
library(reshape2)
library(plyr)

#constants
k= 8.617*1e-05

#load data
ModifiedData <- read.csv("../Data/BioTraits_modified.csv", stringsAsFactors = F)

CubicData <- read.csv("../Data/Cubic_model_original.csv")
SchoolData <- read.csv("../Data/School_model_original.csv")
SchoolLowData <- read.csv("../Data/School_low_model_original.csv")
SchoolHighData <- read.csv("../Data/School_high_model_original.csv")

#number of sample of one research
ModifiedData[is.na(ModifiedData$count)] <-0
number_sample <- ggplot(ModifiedData, aes(count)) + geom_histogram(aes(y = ..density..), binwidth = 30) + 
  stat_bin(aes(size = ..density..), binwidth = 30, geom = "point", position = "identity", colour = "#006EAF") + 
  xlim(0,700) + ylim(0,6000)
#number_sample <- ggplot(ModifiedData, aes(count)) + geom_freqpoly(aes(y = ..density..), binwidth = 1)
number_sample <- number_sample + xlab("The number of the samples in one research") + ylab("")

#save
pdf("../Results/number.pdf", width = 11, height = 10)
number_sample
graphics.off()


#calculate weight
#create a new dataframe
AICData <- data.frame("id" = CubicData$id,
                    "Cubic" = CubicData$aic,
                    "SchoolField" = SchoolData$aic,
                    "SchoolLowField" = SchoolLowData$aic,
                    "SchoolHighField" = SchoolHighData$aic)
#find the min value
AICData$mindata <- apply(AICData[,2:5], 1, min, na.rm = T)

#calculate the weight
AICData$Cubicweight <- exp((AICData$Cubic - AICData$mindata)*(-1/2)) / (exp((AICData$Cubic - AICData$mindata)*(-1/2)) + 
                                                                          exp((AICData$SchoolField - AICData$mindata)*(-1/2)) + 
                                                                          exp((AICData$SchoolLowField - AICData$mindata)*(-1/2)) + 
                                                                          exp((AICData$SchoolHighField - AICData$mindata)*(-1/2)) )
AICData$SchoolFieldweight <- exp((AICData$SchoolField - AICData$mindata)*(-1/2)) / (exp((AICData$Cubic - AICData$mindata)*(-1/2)) + 
                                                                            exp((AICData$SchoolField - AICData$mindata)*(-1/2)) + 
                                                                            exp((AICData$SchoolLowField - AICData$mindata)*(-1/2)) +
                                                                            exp((AICData$SchoolHighField - AICData$mindata)*(-1/2)) )
AICData$SchoolFieldLowweight <- exp((AICData$SchoolLowField - AICData$mindata)*(-1/2)) / (exp((AICData$Cubic - AICData$mindata)*(-1/2)) +  
                                                                                      exp((AICData$SchoolField - AICData$mindata)*(-1/2)) + 
                                                                                      exp((AICData$SchoolLowField - AICData$mindata)*(-1/2)) +
                                                                                      exp((AICData$SchoolHighField - AICData$mindata)*(-1/2)) )
AICData$SchoolFieldHighweight <- exp((AICData$SchoolHighField - AICData$mindata)*(-1/2)) / (exp((AICData$Cubic - AICData$mindata)*(-1/2)) + 
                                                                                      exp((AICData$SchoolField - AICData$mindata)*(-1/2)) + 
                                                                                      exp((AICData$SchoolLowField - AICData$mindata)*(-1/2)) +
                                                                                      exp((AICData$SchoolHighField - AICData$mindata)*(-1/2)) )

#calculate weight
#create a new dataframe
AICCData <- data.frame("id" = CubicData$id,
                     "Cubic" = CubicData$aicc,
                     "SchoolField" = SchoolData$aicc,
                     "SchoolLowField" = SchoolLowData$aicc,
                     "SchoolHighField" = SchoolHighData$aicc)
#find the min value
AICCData$mindata <- apply(AICCData[,2:5], 1, min, na.rm = T)

#calculate the weight
AICCData$Cubicweight <- exp((AICCData$Cubic - AICCData$mindata)*(-1/2)) / (exp((AICCData$Cubic - AICCData$mindata)*(-1/2)) +
                                                                          exp((AICCData$SchoolField - AICCData$mindata)*(-1/2)) + 
                                                                          exp((AICCData$SchoolLowField - AICCData$mindata)*(-1/2)) + 
                                                                          exp((AICCData$SchoolHighField - AICCData$mindata)*(-1/2)) )

AICCData$SchoolFieldweight <- exp((AICCData$SchoolField - AICCData$mindata)*(-1/2)) / (exp((AICCData$Cubic - AICCData$mindata)*(-1/2)) + 
                                                                                      exp((AICCData$SchoolField - AICCData$mindata)*(-1/2)) + 
                                                                                      exp((AICCData$SchoolLowField - AICCData$mindata)*(-1/2)) +
                                                                                      exp((AICCData$SchoolHighField - AICCData$mindata)*(-1/2)) )
AICCData$SchoolLowweight <- exp((AICCData$SchoolLowField - AICCData$mindata)*(-1/2)) / (exp((AICCData$Cubic - AICCData$mindata)*(-1/2)) + 
                                                                                       exp((AICCData$SchoolField - AICCData$mindata)*(-1/2)) + 
                                                                                       exp((AICCData$SchoolLowField - AICCData$mindata)*(-1/2)) +
                                                                                       exp((AICCData$SchoolHighField - AICCData$mindata)*(-1/2)) )
AICCData$SchoolHighweight <- exp((AICCData$SchoolHighField - AICCData$mindata)*(-1/2)) / (exp((AICCData$Cubic - AICCData$mindata)*(-1/2)) + 
                                                                                          exp((AICCData$SchoolField - AICCData$mindata)*(-1/2)) + 
                                                                                          exp((AICCData$SchoolLowField - AICCData$mindata)*(-1/2)) +
                                                                                          exp((AICCData$SchoolHighField - AICCData$mindata)*(-1/2)) )


#calculate weight
#create a new dataframe
BICData  <- data.frame("id" = CubicData$id,
                    "Cubic" = CubicData$bic,
                    "SchoolField" = SchoolData$bic,
                    "SchoolLowField" = SchoolLowData$bic,
                    "SchoolHighField" = SchoolHighData$bic)

#find the min value
BICData $mindata <- apply(BICData [,2:5], 1, min, na.rm = T)

#calculate the weight
BICData$Cubicweight <- exp((BICData$Cubic - BICData$mindata)*(-1/2)) / (exp((BICData$Cubic - BICData$mindata)*(-1/2)) + 
                                                                             exp((BICData$SchoolField - BICData$mindata)*(-1/2)) + 
                                                                             exp((BICData$SchoolLowField - BICData$mindata)*(-1/2)) + 
                                                                             exp((BICData$SchoolHighField - BICData$mindata)*(-1/2)) )

BICData$SchoolFieldweight <- exp((BICData$SchoolField - BICData$mindata)*(-1/2)) / (exp((BICData$Cubic - BICData$mindata)*(-1/2)) + 
                                                                                         exp((BICData$SchoolField - BICData$mindata)*(-1/2)) + 
                                                                                         exp((BICData$SchoolLowField - BICData$mindata)*(-1/2)) +
                                                                                         exp((BICData$SchoolHighField - BICData$mindata)*(-1/2)) )
BICData$SchoolLowweight <- exp((BICData$SchoolLowField - BICData$mindata)*(-1/2)) / (exp((BICData$Cubic - BICData$mindata)*(-1/2)) + 
                                                                                          exp((BICData$SchoolField - BICData$mindata)*(-1/2)) + 
                                                                                          exp((BICData$SchoolLowField - BICData$mindata)*(-1/2)) +
                                                                                          exp((BICData$SchoolHighField - BICData$mindata)*(-1/2)) )
BICData$SchoolHighweight <- exp((BICData$SchoolHighField - BICData$mindata)*(-1/2)) / (exp((BICData$Cubic - BICData$mindata)*(-1/2)) + 
                                                                                            exp((BICData$SchoolField - BICData$mindata)*(-1/2)) + 
                                                                                            exp((BICData$SchoolLowField - BICData$mindata)*(-1/2)) +
                                                                                            exp((BICData$SchoolHighField - BICData$mindata)*(-1/2)) )

#create a samll metadata for AIC
metadata <- data.frame("id" = CubicData$id,
                       "ConKingdom" = CubicData$ConKingdom,
                       "Habitat" = CubicData$Habitat,
                       "ModelSelectionCriteria" = "AIC",
                       "CubicModel" = AICData$Cubicweight,
                       "SchoolfieldModel" = AICData$SchoolFieldweight,
                       "SchoolfieldModelLow" = AICData$SchoolFieldLowweight,
                       "SchoolfieldModelHigh" = AICData$SchoolFieldHighweight
                       ) 
#data wrangle
metadata <- melt(metadata, id=c("id", "ConKingdom","Habitat","ModelSelectionCriteria"), 
                  variable.name = "model", value.name = "weightvalue")

#create a samll metadata for BIC
metadata_2 <- data.frame("id" = CubicData$id,
                         "ConKingdom" = CubicData$ConKingdom,
                         "Habitat" = CubicData$Habitat,
                         "ModelSelectionCriteria" = "BIC",
                         "CubicModel" = BICData$Cubicweight,
                         "SchoolfieldModel" = BICData$SchoolFieldweight,
                         "SchoolfieldModelLow" = BICData$SchoolLowweight,
                         "SchoolfieldModelHigh" = BICData$SchoolHighweight
) 
#data wrangle
metadata_2 <- melt(metadata_2, id=c("id", "ConKingdom","Habitat","ModelSelectionCriteria"), 
                   variable.name = "model", value.name = "weightvalue")

#create a samll metadata for AICC
metadata_3 <- data.frame("id" = CubicData$id,
                         "ConKingdom" = CubicData$ConKingdom,
                         "Habitat" = CubicData$Habitat,
                         "ModelSelectionCriteria" = "AICC",
                         "CubicModel" = AICCData$Cubicweight,
                         "SchoolfieldModel" = AICCData$SchoolFieldweight,
                         "SchoolfieldModelLow" = AICCData$SchoolLowweight,
                         "SchoolfieldModelHigh" = AICCData$SchoolHighweight
) 
#data wrangle
metadata_3 <- melt(metadata_3, id=c("id", "ConKingdom","Habitat","ModelSelectionCriteria"), 
                   variable.name = "model", value.name = "weightvalue")

#rbind metadata
metadata <- rbind(metadata, metadata_2)
metadata <- rbind(metadata, metadata_3)

#rename to the same 
metadata <- within(metadata,{ Habitat[Habitat == "Marine"] <- "marine"})
metadata <- within(metadata,{ Habitat[Habitat == "Terrestrial"] <- "terrestrial"})


#plot
#habitat figure
meta_habitat <-metadata[metadata$Habitat != "",]
meta_habitat[is.na(meta_habitat)] <-0

p <- ggplot(meta_habitat, aes(x = ModelSelectionCriteria , y = weightvalue) ) + geom_boxplot() 
p <- p + aes(colour = ModelSelectionCriteria) + scale_colour_manual(values = c("#006EAF", "#B8860B", "#9932CC"))
p <- p + facet_grid(model ~ Habitat , scales = "free", space = "free", margins = T) + 
  labs(x = "Model Selection Criteria", y = "Weight of Models" ) 

pdf("../Results/habitat.pdf", width = 11, height = 10)
p
graphics.off()
  
#Kingdom figure
meta_kingdom <-metadata[metadata$ConKingdom != "",]
meta_kingdom[is.na(meta_kingdom)] <-0

q <- ggplot(meta_kingdom, aes(x = ModelSelectionCriteria , y = weightvalue) ) + geom_boxplot() 
q <- q + aes(colour = ModelSelectionCriteria) + scale_colour_manual(values = c("#006EAF", "#B8860B", "#9932CC"))
q <- q + facet_grid(model ~ ConKingdom , margins = T) + 
  labs(x = "Model Selection Criteria", y = "Weight of Models" ) 

pdf("../Results/kindom.pdf", width = 11, height = 10)
q
graphics.off()


#plot model line


#plot model line
#get the start value
subset_cubic <- subset(CubicData, id == 591)
subset_School <- subset(SchoolData, id == 591)
subset_SchoolLow <- subset(SchoolLowData, id == 591)
subset_SchoolHigh <- subset(SchoolHighData, id == 591)

T_range <- seq(0, 50, by = 0.1)

#define the model function
#cubic
Cubic <- function(B0, B1, B2, B3, T){
  return(B0 + B1 * T + B2 * T ^ 2+B3 * T ^ 3)
}


#schoolfield
Schoolfield <- function(B0, E, T, Tl, Th, El, Eh){
  return((B0 * exp(-E/k *(1/T - 1/283.15))) / (1 + exp(El/k * (1/Tl - 1/T)) + exp(Eh/k * (1/Th - 1/T))))
}

#schoolfield low
Schoolfield_low <- function(B0, E, T, Tl, El){
  return((B0 * exp(-E/k *(1/T - 1/283.15))) / (1 + exp(El/k * (1/Tl - 1/T))))
}

#schoolfield high
Schoolfield_high <- function(B0, E, T, Th, Eh){
  return((B0 * exp(-E/k *(1/T - 1/283.15))) / (1 + exp(Eh/k * (1/Th - 1/T))))
}


cubicplot <- Cubic(subset_cubic[["B0"]], subset_cubic[["B1"]],
                   subset_cubic[["B2"]], subset_cubic[["B3"]],
                   T_range)

Schoolfieldplot <- Schoolfield(B0 = subset_School[["B0"]], E = subset_School[["E"]], T= T_range + 273.15,
                               Tl = subset_School[["Tl"]], Th = subset_School[["Th"]],
                               El = subset_School[["El"]], Eh = subset_School[["Eh"]])

Schoolfieldplot_low <- Schoolfield_low(B0 = subset_SchoolLow[["B0"]], E = subset_SchoolLow[["E"]], T= T_range + 273.15,
                                       Tl = subset_SchoolLow[["Tl"]], El = subset_SchoolLow[["El"]])

Schoolfieldplot_high <- Schoolfield_high(B0 = subset_SchoolHigh[["B0"]], E = subset_SchoolHigh[["E"]], T= T_range + 273.15,
                                         Th = subset_SchoolHigh[["Th"]], Eh = subset_SchoolHigh[["Eh"]])

#Model fitting
data_591 <- subset(ModifiedData, id == 591)

model_plot <- ggplot() + 
  geom_point(data = data_591, aes(x = ConTemp, y = OriginalTraitValue), size = 0.5) +
  geom_line(aes(x=T_range, y= Schoolfieldplot, col = "SchoolfieldModel")) +
  geom_line(aes(x=T_range, y= cubicplot, col = "CubicModel")) +
  geom_line(aes(x=T_range, y= Schoolfieldplot_low, col = "SchoolfieldModelLow") ) +
  geom_line(aes(x=T_range, y= Schoolfieldplot_high, col = "SchoolfieldModelHigh") ) +
  scale_color_manual(name = "Models", values = c("SchoolfieldModel" = "#006EAF", 
                                                 "CubicModel" = "#FF0000",
                                                 "SchoolfieldModelLow" = "#006400", 
                                                 "SchoolfieldModelHigh" = "#9932CC")) +
  xlab("Temperature")

pdf("../Results/model_951.pdf", width = 11, height = 10)
model_plot
graphics.off()

#Stat analysis
#multi test
#kruskal.test(weightvalue ~ Habitat, data = metadata)
#kruskal.test(weightvalue ~ ConKingdom, data = metadata)

#pairwise test
#terrestrial freshwater
#test_data_T_F <- subset(metadata, Habitat == "terrestrial" | Habitat == "freshwater")
#wilcox.test(weightvalue ~ Habitat, data = test_data_T_F)

#terrestrial marine
#test_data_T_M <- subset(metadata, Habitat == "terrestrial" | Habitat == "marine")
#wilcox.test(weightvalue ~ Habitat, data = test_data_T_M)

#marine freshwater
#test_data_M_F <- subset(metadata, Habitat == "marine" | Habitat == "freshwater")
#wilcox.test(weightvalue ~ Habitat, data = test_data_M_F)

#AICC
# metadata_aicc <- subset(metadata, ModelSelectionCriteria == "AICC")
# #cubic_model
# metadata_aicc_cubic <- subset(metadata_aicc, model == "CubicModel")

# #terr,fresh
# test_data_T_F_aicc_cubic <- subset(metadata_aicc_cubic, Habitat == "terrestrial" | Habitat == "freshwater")
# wilcox.test(weightvalue ~ Habitat, data = test_data_T_F_aicc_cubic )

# #terrestrial marine
# test_data_T_M_aicc_cubic <- subset(metadata_aicc_cubic, Habitat == "terrestrial" | Habitat == "marine")
# wilcox.test(weightvalue ~ Habitat, data = test_data_T_M_aicc_cubic )

# #marine freshwater
# test_data_M_F_aicc_cubic <- subset(metadata_aicc_cubic, Habitat == "marine" | Habitat == "freshwater")
# wilcox.test(weightvalue ~ Habitat, data = test_data_M_F_aicc_cubic)


# #school_model
# metadata_aicc_school <- subset(metadata_aicc, model == "SchoolfieldModel")

# #terr,fresh
# test_data_T_F_aicc_school <- subset(metadata_aicc_school, Habitat == "terrestrial" | Habitat == "freshwater")
# wilcox.test(weightvalue ~ Habitat, data = test_data_T_F_aicc_school )

# #terrestrial marine
# test_data_T_M_aicc_school <- subset(metadata_aicc_school, Habitat == "terrestrial" | Habitat == "marine")
# wilcox.test(weightvalue ~ Habitat, data = test_data_T_M_aicc_school )

# #marine freshwater
# test_data_M_F_aicc_school<- subset(metadata_aicc_school, Habitat == "marine" | Habitat == "freshwater")
# wilcox.test(weightvalue ~ Habitat, data = test_data_M_F_aicc_school)

# #school_model_low
# metadata_aicc_school_low <- subset(metadata_aicc, model == "SchoolfieldModelLow")

# #terr,fresh
# test_data_T_F_aicc_school_low <- subset(metadata_aicc_school_low, Habitat == "terrestrial" | Habitat == "freshwater")
# wilcox.test(weightvalue ~ Habitat, data = test_data_T_F_aicc_school_low )

# #terrestrial marine
# test_data_T_M_aicc_school_low <- subset(metadata_aicc_school_low, Habitat == "terrestrial" | Habitat == "marine")
# wilcox.test(weightvalue ~ Habitat, data = test_data_T_M_aicc_school_low )

# #marine freshwater
# test_data_M_F_aicc_school_low<- subset(metadata_aicc_school_low, Habitat == "marine" | Habitat == "freshwater")
# wilcox.test(weightvalue ~ Habitat, data = test_data_M_F_aicc_school_low)

# #school_model_low
# metadata_aicc_school_high <- subset(metadata_aicc, model == "SchoolfieldModelHigh")

# #terr,fresh
# test_data_T_F_aicc_school_high <- subset(metadata_aicc_school_high, Habitat == "terrestrial" | Habitat == "freshwater")
# wilcox.test(weightvalue ~ Habitat, data = test_data_T_F_aicc_school_high )

# #terrestrial marine
# test_data_T_M_aicc_school_high <- subset(metadata_aicc_school_high, Habitat == "terrestrial" | Habitat == "marine")
# wilcox.test(weightvalue ~ Habitat, data = test_data_T_M_aicc_school_high )

# #marine freshwater
# test_data_M_F_aicc_school_high<- subset(metadata_aicc_school_high, Habitat == "marine" | Habitat == "freshwater")
# wilcox.test(weightvalue ~ Habitat, data = test_data_M_F_aicc_school_high)

# #AIC
# metadata_aic <- subset(metadata, ModelSelectionCriteria == "AIC")
# #cubic_model
# metadata_aic_cubic <- subset(metadata_aic, model == "CubicModel")

# #terr,fresh
# test_data_T_F_aic_cubic <- subset(metadata_aic_cubic, Habitat == "terrestrial" | Habitat == "freshwater")
# wilcox.test(weightvalue ~ Habitat, data = test_data_T_F_aic_cubic )

# #terrestrial marine
# test_data_T_M_aic_cubic <- subset(metadata_aic_cubic, Habitat == "terrestrial" | Habitat == "marine")
# wilcox.test(weightvalue ~ Habitat, data = test_data_T_M_aic_cubic )

# #marine freshwater
# test_data_M_F_aic_cubic <- subset(metadata_aic_cubic, Habitat == "marine" | Habitat == "freshwater")
# wilcox.test(weightvalue ~ Habitat, data = test_data_M_F_aic_cubic)


# #school_model
# metadata_aic_school <- subset(metadata_aic, model == "SchoolfieldModel")

# #terr,fresh
# test_data_T_F_aic_school <- subset(metadata_aic_school, Habitat == "terrestrial" | Habitat == "freshwater")
# wilcox.test(weightvalue ~ Habitat, data = test_data_T_F_aic_school )

# #terrestrial marine
# test_data_T_M_aic_school <- subset(metadata_aic_school, Habitat == "terrestrial" | Habitat == "marine")
# wilcox.test(weightvalue ~ Habitat, data = test_data_T_M_aic_school )

# #marine freshwater
# test_data_M_F_aic_school<- subset(metadata_aic_school, Habitat == "marine" | Habitat == "freshwater")
# wilcox.test(weightvalue ~ Habitat, data = test_data_M_F_aic_school)

# #school_model_low
# metadata_aic_school_low <- subset(metadata_aic, model == "SchoolfieldModelLow")

# #terr,fresh
# test_data_T_F_aic_school_low <- subset(metadata_aic_school_low, Habitat == "terrestrial" | Habitat == "freshwater")
# wilcox.test(weightvalue ~ Habitat, data = test_data_T_F_aic_school_low )

# #terrestrial marine
# test_data_T_M_aic_school_low <- subset(metadata_aic_school_low, Habitat == "terrestrial" | Habitat == "marine")
# wilcox.test(weightvalue ~ Habitat, data = test_data_T_M_aic_school_low )

# #marine freshwater
# test_data_M_F_aic_school_low<- subset(metadata_aic_school_low, Habitat == "marine" | Habitat == "freshwater")
# wilcox.test(weightvalue ~ Habitat, data = test_data_M_F_aic_school_low)

# #school_model_low
# metadata_aic_school_high <- subset(metadata_aic, model == "SchoolfieldModelHigh")

# #terr,fresh
# test_data_T_F_aic_school_high <- subset(metadata_aic_school_high, Habitat == "terrestrial" | Habitat == "freshwater")
# wilcox.test(weightvalue ~ Habitat, data = test_data_T_F_aic_school_high )

# #terrestrial marine
# test_data_T_M_aic_school_high <- subset(metadata_aic_school_high, Habitat == "terrestrial" | Habitat == "marine")
# wilcox.test(weightvalue ~ Habitat, data = test_data_T_M_aic_school_high )

# #marine freshwater
# test_data_M_F_aic_school_high<- subset(metadata_aic_school_high, Habitat == "marine" | Habitat == "freshwater")
# wilcox.test(weightvalue ~ Habitat, data = test_data_M_F_aic_school_high)

# #BIC
# metadata_bic <- subset(metadata, ModelSelectionCriteria == "BIC")
# #cubic_model
# metadata_bic_cubic <- subset(metadata_bic, model == "CubicModel")

# #terr,fresh
# test_data_T_F_bic_cubic <- subset(metadata_bic_cubic, Habitat == "terrestrial" | Habitat == "freshwater")
# wilcox.test(weightvalue ~ Habitat, data = test_data_T_F_bic_cubic )

# #terrestrial marine
# test_data_T_M_bic_cubic <- subset(metadata_bic_cubic, Habitat == "terrestrial" | Habitat == "marine")
# wilcox.test(weightvalue ~ Habitat, data = test_data_T_M_bic_cubic )

# #marine freshwater
# test_data_M_F_bic_cubic <- subset(metadata_bic_cubic, Habitat == "marine" | Habitat == "freshwater")
# wilcox.test(weightvalue ~ Habitat, data = test_data_M_F_bic_cubic)


# #school_model
# metadata_bic_school <- subset(metadata_bic, model == "SchoolfieldModel")

# #terr,fresh
# test_data_T_F_bic_school <- subset(metadata_bic_school, Habitat == "terrestrial" | Habitat == "freshwater")
# wilcox.test(weightvalue ~ Habitat, data = test_data_T_F_bic_school )

# #terrestrial marine
# test_data_T_M_bic_school <- subset(metadata_bic_school, Habitat == "terrestrial" | Habitat == "marine")
# wilcox.test(weightvalue ~ Habitat, data = test_data_T_M_bic_school )

# #marine freshwater
# test_data_M_F_bic_school<- subset(metadata_bic_school, Habitat == "marine" | Habitat == "freshwater")
# wilcox.test(weightvalue ~ Habitat, data = test_data_M_F_bic_school)

# #school_model_low
# metadata_bic_school_low <- subset(metadata_bic, model == "SchoolfieldModelLow")

# #terr,fresh
# test_data_T_F_bic_school_low <- subset(metadata_bic_school_low, Habitat == "terrestrial" | Habitat == "freshwater")
# wilcox.test(weightvalue ~ Habitat, data = test_data_T_F_bic_school_low )

# #terrestrial marine
# test_data_T_M_bic_school_low <- subset(metadata_bic_school_low, Habitat == "terrestrial" | Habitat == "marine")
# wilcox.test(weightvalue ~ Habitat, data = test_data_T_M_bic_school_low )

# #marine freshwater
# test_data_M_F_bic_school_low<- subset(metadata_bic_school_low, Habitat == "marine" | Habitat == "freshwater")
# wilcox.test(weightvalue ~ Habitat, data = test_data_M_F_bic_school_low)

# #school_model_low
# metadata_bic_school_high <- subset(metadata_bic, model == "SchoolfieldModelHigh")

# #terr,fresh
# test_data_T_F_bic_school_high <- subset(metadata_bic_school_high, Habitat == "terrestrial" | Habitat == "freshwater")
# wilcox.test(weightvalue ~ Habitat, data = test_data_T_F_bic_school_high )

# #terrestrial marine
# test_data_T_M_bic_school_high <- subset(metadata_bic_school_high, Habitat == "terrestrial" | Habitat == "marine")
# wilcox.test(weightvalue ~ Habitat, data = test_data_T_M_bic_school_high )

# #marine freshwater
# test_data_M_F_bic_school_high<- subset(metadata_bic_school_high, Habitat == "marine" | Habitat == "freshwater")
# wilcox.test(weightvalue ~ Habitat, data = test_data_M_F_bic_school_high)


# #aicc freshwater
# test_data_aicc_freshwater <- subset(metadata_aicc, Habitat == "freshwater" )

# #cu,shool
# test_data_aicc_freshwater_C_school <- subset(test_data_aicc_freshwater, model == "CubicModel" | model == "SchoolfieldModel")
# wilcox.test(weightvalue ~ model, data = test_data_aicc_freshwater_C_school)

# #cu,school_low
# test_data_aicc_freshwater_C_school_low <- subset(test_data_aicc_freshwater, model == "CubicModel" | model == "SchoolfieldModelLow")
# wilcox.test(weightvalue ~ model, data = test_data_aicc_freshwater_C_school_low )

# #cu,school_low
# test_data_aicc_freshwater_C_school_high <- subset(test_data_aicc_freshwater, model == "CubicModel" | model == "SchoolfieldModelHigh")
# wilcox.test(weightvalue ~ model, data = test_data_aicc_freshwater_C_school_high )

# #shool, low
# test_data_aicc_freshwater_school_shool_low <- subset(test_data_aicc_freshwater, model == "SchoolfieldModel"| model == "SchoolfieldModelLow")
# wilcox.test(weightvalue ~ model, data = test_data_aicc_freshwater_school_shool_low)

# #shool, high
# test_data_aicc_freshwater_school_shool_high <- subset(test_data_aicc_freshwater, model == "SchoolfieldModel"| model == "SchoolfieldModelHigh")
# wilcox.test(weightvalue ~ model, data = test_data_aicc_freshwater_school_shool_high)

# #high, low
# test_data_aicc_freshwater_school_low_shool_high <- subset(test_data_aicc_freshwater, model == "SchoolfieldModelLow"| model == "SchoolfieldModelHigh")
# wilcox.test(weightvalue ~ model, data = test_data_aicc_freshwater_school_low_shool_high)

# #aicc marine
# test_data_aicc_marine <- subset(metadata_aicc, Habitat == "marine" )

# #cu,shool
# test_data_aicc_marine_C_school <- subset(test_data_aicc_marine, model == "CubicModel" | model == "SchoolfieldModel")
# wilcox.test(weightvalue ~ model, data = test_data_aicc_marine_C_school)

# #cu,school_low
# test_data_aicc_marine_C_school_low <- subset(test_data_aicc_marine, model == "CubicModel" | model == "SchoolfieldModelLow")
# wilcox.test(weightvalue ~ model, data = test_data_aicc_marine_C_school_low )

# #cu,school_low
# test_data_aicc_marine_C_school_high <- subset(test_data_aicc_marine, model == "CubicModel" | model == "SchoolfieldModelHigh")
# wilcox.test(weightvalue ~ model, data = test_data_aicc_marine_C_school_high )

# #shool, low
# test_data_aicc_marine_school_shool_low <- subset(test_data_aicc_marine, model == "SchoolfieldModel"| model == "SchoolfieldModelLow")
# wilcox.test(weightvalue ~ model, data = test_data_aicc_marine_school_shool_low)

# #shool, high
# test_data_aicc_marine_school_shool_high <- subset(test_data_aicc_marine, model == "SchoolfieldModel"| model == "SchoolfieldModelHigh")
# wilcox.test(weightvalue ~ model, data = test_data_aicc_marine_school_shool_high)

# #high, low
# test_data_aicc_marine_school_low_shool_high <- subset(test_data_aicc_marine, model == "SchoolfieldModelLow"| model == "SchoolfieldModelHigh")
# wilcox.test(weightvalue ~ model, data = test_data_aicc_marine_school_low_shool_high)

# #aic,terr
# test_data_aicc_terrestrial <- subset(metadata_aicc, Habitat == "terrestrial" )

# #cu,shool
# test_data_aicc_terrestrial_C_school <- subset(test_data_aicc_terrestrial, model == "CubicModel" | model == "SchoolfieldModel")
# wilcox.test(weightvalue ~ model, data = test_data_aicc_terrestrial_C_school)

# #cu,school_low
# test_data_aicc_terrestrial_C_school_low <- subset(test_data_aicc_terrestrial, model == "CubicModel" | model == "SchoolfieldModelLow")
# wilcox.test(weightvalue ~ model, data = test_data_aicc_terrestrial_C_school_low )

# #cu,school_low
# test_data_aicc_terrestrial_C_school_high <- subset(test_data_aicc_terrestrial, model == "CubicModel" | model == "SchoolfieldModelHigh")
# wilcox.test(weightvalue ~ model, data = test_data_aicc_terrestrial_C_school_high )

# #shool, low
# test_data_aicc_terrestrial_school_shool_low <- subset(test_data_aicc_terrestrial, model == "SchoolfieldModel"| model == "SchoolfieldModelLow")
# wilcox.test(weightvalue ~ model, data = test_data_aicc_terrestrial_school_shool_low)

# #shool, high
# test_data_aicc_terrestrial_school_shool_high <- subset(test_data_aicc_terrestrial, model == "SchoolfieldModel"| model == "SchoolfieldModelHigh")
# wilcox.test(weightvalue ~ model, data = test_data_aicc_terrestrial_school_shool_high)

# #high, low
# test_data_aicc_terrestrial_school_low_shool_high <- subset(test_data_aicc_terrestrial, model == "SchoolfieldModelLow"| model == "SchoolfieldModelHigh")
# wilcox.test(weightvalue ~ model, data = test_data_aicc_terrestrial_school_low_shool_high)

# #aic freshwater
# test_data_aic_freshwater <- subset(metadata_aic, Habitat == "freshwater" )

# #cu,shool
# test_data_aic_freshwater_C_school <- subset(test_data_aic_freshwater, model == "CubicModel" | model == "SchoolfieldModel")
# wilcox.test(weightvalue ~ model, data = test_data_aic_freshwater_C_school)

# #cu,school_low
# test_data_aic_freshwater_C_school_low <- subset(test_data_aic_freshwater, model == "CubicModel" | model == "SchoolfieldModelLow")
# wilcox.test(weightvalue ~ model, data = test_data_aic_freshwater_C_school_low )

# #cu,school_low
# test_data_aic_freshwater_C_school_high <- subset(test_data_aic_freshwater, model == "CubicModel" | model == "SchoolfieldModelHigh")
# wilcox.test(weightvalue ~ model, data = test_data_aic_freshwater_C_school_high )

# #shool, low
# test_data_aic_freshwater_school_shool_low <- subset(test_data_aic_freshwater, model == "SchoolfieldModel"| model == "SchoolfieldModelLow")
# wilcox.test(weightvalue ~ model, data = test_data_aic_freshwater_school_shool_low)

# #shool, high
# test_data_aic_freshwater_school_shool_high <- subset(test_data_aic_freshwater, model == "SchoolfieldModel"| model == "SchoolfieldModelHigh")
# wilcox.test(weightvalue ~ model, data = test_data_aic_freshwater_school_shool_high)

# #high, low
# test_data_aic_freshwater_school_low_shool_high <- subset(test_data_aic_freshwater, model == "SchoolfieldModelLow"| model == "SchoolfieldModelHigh")
# wilcox.test(weightvalue ~ model, data = test_data_aic_freshwater_school_low_shool_high)

# #aicc marine
# test_data_aic_marine <- subset(metadata_aic, Habitat == "marine" )

# #cu,shool
# test_data_aic_marine_C_school <- subset(test_data_aic_marine, model == "CubicModel" | model == "SchoolfieldModel")
# wilcox.test(weightvalue ~ model, data = test_data_aic_marine_C_school)

# #cu,school_low
# test_data_aic_marine_C_school_low <- subset(test_data_aic_marine, model == "CubicModel" | model == "SchoolfieldModelLow")
# wilcox.test(weightvalue ~ model, data = test_data_aic_marine_C_school_low )

# #cu,school_low
# test_data_aic_marine_C_school_high <- subset(test_data_aic_marine, model == "CubicModel" | model == "SchoolfieldModelHigh")
# wilcox.test(weightvalue ~ model, data = test_data_aic_marine_C_school_high )

# #shool, low
# test_data_aic_marine_school_shool_low <- subset(test_data_aic_marine, model == "SchoolfieldModel"| model == "SchoolfieldModelLow")
# wilcox.test(weightvalue ~ model, data = test_data_aic_marine_school_shool_low)

# #shool, high
# test_data_aic_marine_school_shool_high <- subset(test_data_aic_marine, model == "SchoolfieldModel"| model == "SchoolfieldModelHigh")
# wilcox.test(weightvalue ~ model, data = test_data_aic_marine_school_shool_high)

# #high, low
# test_data_aic_marine_school_low_shool_high <- subset(test_data_aic_marine, model == "SchoolfieldModelLow"| model == "SchoolfieldModelHigh")
# wilcox.test(weightvalue ~ model, data = test_data_aic_marine_school_low_shool_high)

# #aic,terr
# test_data_aic_terrestrial <- subset(metadata_aic, Habitat == "terrestrial" )

# #cu,shool
# test_data_aic_terrestrial_C_school <- subset(test_data_aic_terrestrial, model == "CubicModel" | model == "SchoolfieldModel")
# wilcox.test(weightvalue ~ model, data = test_data_aic_terrestrial_C_school)

# #cu,school_low
# test_data_aicc_terrestrial_C_school_low <- subset(test_data_aicc_terrestrial, model == "CubicModel" | model == "SchoolfieldModelLow")
# wilcox.test(weightvalue ~ model, data = test_data_aicc_terrestrial_C_school_low )

# #cu,school_low
# test_data_aic_terrestrial_C_school_high <- subset(test_data_aic_terrestrial, model == "CubicModel" | model == "SchoolfieldModelHigh")
# wilcox.test(weightvalue ~ model, data = test_data_aic_terrestrial_C_school_high )

# #shool, high
# test_data_aic_terrestrial_school_shool_high <- subset(test_data_aic_terrestrial, model == "SchoolfieldModel"| model == "SchoolfieldModelHigh")
# wilcox.test(weightvalue ~ model, data = test_data_aic_terrestrial_school_shool_high)

# #high, low
# test_data_aic_terrestrial_school_low_shool_high <- subset(test_data_aic_terrestrial, model == "SchoolfieldModelLow"| model == "SchoolfieldModelHigh")
# wilcox.test(weightvalue ~ model, data = test_data_aic_terrestrial_school_low_shool_high)

# #bic freshwater
# test_data_bic_freshwater <- subset(metadata_bic, Habitat == "freshwater" )

# #cu,shool
# test_data_bic_freshwater_C_school <- subset(test_data_bic_freshwater, model == "CubicModel" | model == "SchoolfieldModel")
# wilcox.test(weightvalue ~ model, data = test_data_bic_freshwater_C_school)

# #cu,school_low
# test_data_bic_freshwater_C_school_low <- subset(test_data_bic_freshwater, model == "CubicModel" | model == "SchoolfieldModelLow")
# wilcox.test(weightvalue ~ model, data = test_data_bic_freshwater_C_school_low )

# #cu,school_low
# test_data_bic_freshwater_C_school_high <- subset(test_data_bic_freshwater, model == "CubicModel" | model == "SchoolfieldModelHigh")
# wilcox.test(weightvalue ~ model, data = test_data_bic_freshwater_C_school_high )

# #shool, low
# test_data_bic_freshwater_school_shool_low <- subset(test_data_bic_freshwater, model == "SchoolfieldModel"| model == "SchoolfieldModelLow")
# wilcox.test(weightvalue ~ model, data = test_data_bic_freshwater_school_shool_low)

# #shool, high
# test_data_bic_freshwater_school_shool_high <- subset(test_data_bic_freshwater, model == "SchoolfieldModel"| model == "SchoolfieldModelHigh")
# wilcox.test(weightvalue ~ model, data = test_data_bic_freshwater_school_shool_high)

# #high, low
# test_data_bic_freshwater_school_low_shool_high <- subset(test_data_bic_freshwater, model == "SchoolfieldModelLow"| model == "SchoolfieldModelHigh")
# wilcox.test(weightvalue ~ model, data = test_data_bic_freshwater_school_low_shool_high)

# #aicc marine
# test_data_bic_marine <- subset(metadata_bic, Habitat == "marine" )

# #cu,shool
# test_data_bic_marine_C_school <- subset(test_data_bic_marine, model == "CubicModel" | model == "SchoolfieldModel")
# wilcox.test(weightvalue ~ model, data = test_data_bic_marine_C_school)

# #cu,school_low
# test_data_bic_marine_C_school_low <- subset(test_data_bic_marine, model == "CubicModel" | model == "SchoolfieldModelLow")
# wilcox.test(weightvalue ~ model, data = test_data_bic_marine_C_school_low )

# #cu,school_low
# test_data_bic_marine_C_school_high <- subset(test_data_bic_marine, model == "CubicModel" | model == "SchoolfieldModelHigh")
# wilcox.test(weightvalue ~ model, data = test_data_bic_marine_C_school_high )

# #shool, low
# test_data_bic_marine_school_shool_low <- subset(test_data_bic_marine, model == "SchoolfieldModel"| model == "SchoolfieldModelLow")
# wilcox.test(weightvalue ~ model, data = test_data_bic_marine_school_shool_low)

# #shool, high
# test_data_bic_marine_school_shool_high <- subset(test_data_bic_marine, model == "SchoolfieldModel"| model == "SchoolfieldModelHigh")
# wilcox.test(weightvalue ~ model, data = test_data_bic_marine_school_shool_high)

# #high, low
# test_data_bic_marine_school_low_shool_high <- subset(test_data_bic_marine, model == "SchoolfieldModelLow"| model == "SchoolfieldModelHigh")
# wilcox.test(weightvalue ~ model, data = test_data_bic_marine_school_low_shool_high)

# #aic,terr
# test_data_bic_terrestrial <- subset(metadata_bic, Habitat == "terrestrial" )

# #cu,shool
# test_data_bic_terrestrial_C_school <- subset(test_data_bic_terrestrial, model == "CubicModel" | model == "SchoolfieldModel")
# wilcox.test(weightvalue ~ model, data = test_data_bic_terrestrial_C_school)

# #cu,school_low
# test_data_aicc_terrestrial_C_school_low <- subset(test_data_aicc_terrestrial, model == "CubicModel" | model == "SchoolfieldModelLow")
# wilcox.test(weightvalue ~ model, data = test_data_aicc_terrestrial_C_school_low )

# #cu,school_low
# test_data_bic_terrestrial_C_school_high <- subset(test_data_bic_terrestrial, model == "CubicModel" | model == "SchoolfieldModelHigh")
# wilcox.test(weightvalue ~ model, data = test_data_bic_terrestrial_C_school_high )

# #shool, high
# test_data_bic_terrestrial_school_shool_low <- subset(test_data_bic_terrestrial, model == "SchoolfieldModel"| model == "SchoolfieldModelLow")
# wilcox.test(weightvalue ~ model, data = test_data_bic_terrestrial_school_shool_low)

# #shool, high
# test_data_bic_terrestrial_school_shool_high <- subset(test_data_bic_terrestrial, model == "SchoolfieldModel"| model == "SchoolfieldModelHigh")
# wilcox.test(weightvalue ~ model, data = test_data_bic_terrestrial_school_shool_high)

# #high, low
# test_data_bic_terrestrial_school_low_shool_high <- subset(test_data_bic_terrestrial, model == "SchoolfieldModelLow"| model == "SchoolfieldModelHigh")
# wilcox.test(weightvalue ~ model, data = test_data_bic_terrestrial_school_low_shool_high)






# #Archaea Bacteria
# test_data_A_B <- subset(metadata, ConKingdom == "Archaea" | ConKingdom == "Bacteria")
# wilcox.test(weightvalue ~ ConKingdom, data = test_data_A_B)

# test_data_A_C <- subset(metadata, ConKingdom == "Archaea" | ConKingdom == "Chromista")
# wilcox.test(weightvalue ~ ConKingdom, data = test_data_A_C)

# test_data_A_F <- subset(metadata, ConKingdom == "Archaea" | ConKingdom == "Fungi")
# wilcox.test(weightvalue ~ ConKingdom, data = test_data_A_F)

# test_data_A_M <- subset(metadata, ConKingdom == "Archaea" | ConKingdom == "Metazoa")
# wilcox.test(weightvalue ~ ConKingdom, data = test_data_A_M)

# test_data_A_PL <- subset(metadata, ConKingdom == "Archaea" | ConKingdom == "Plantae")
# wilcox.test(weightvalue ~ ConKingdom, data = test_data_A_PL)

# test_data_A_PL <- subset(metadata, ConKingdom == "Archaea" | ConKingdom == "Plantae")
# wilcox.test(weightvalue ~ ConKingdom, data = test_data_A_PL)

# test_data_A_PR <- subset(metadata, ConKingdom == "Archaea" | ConKingdom == "Protista")
# wilcox.test(weightvalue ~ ConKingdom, data = test_data_A_PR)

# test_data_B_C <- subset(metadata, ConKingdom == "Bacteria"| ConKingdom == "Chromista")
# wilcox.test(weightvalue ~ ConKingdom, data = test_data_B_C)
