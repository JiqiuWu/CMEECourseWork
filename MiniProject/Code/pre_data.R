rm(list = ls())
graphics.off()

#load packages
library(plyr)
library(dplyr)

#choose target columns
Mydata <- read.csv("../Data/BioTraits.csv")
Mydata <- select(Mydata, FinalID, OriginalTraitName, OriginalTraitValue, OriginalTraitUnit, ConTemp, ConTempUnit, AmbientTemp, AmbientTempUnit, Habitat, 
               ConKingdom)

#remove NAs, 0s, and negetive values
Mydata <- subset(Mydata, Mydata$OriginalTraitValue > 0)
Mydata <- subset(Mydata, Mydata$ConTemp > 0)

#remove subdatasets that contains less than 8 data
Mydata <- ddply(Mydata, .(FinalID), mutate, count = length(FinalID))
Mydata <- subset(Mydata, Mydata$count >7)

#if ConTemp is missing, use the AmbientTemp
Mydata$ConTemp[is.na(Mydata$ConTemp)] <- Mydata$AmbientTemp[is.na(Mydata$ConTemp)]

#Add column with kelvin temperature, logged trait values, and 1/kT
Mydata$ConTemp_k <- Mydata$ConTemp + 273.15
Mydata$OriginalTraitValue_logged <- log(Mydata$OriginalTraitValue)
k <- 8.617e-5
Mydata$ConTemp_rk <- 1/(Mydata$ConTemp_k*k) 

#Create new id based on final ID
Mydata <- transform(Mydata,id=as.numeric(factor(FinalID)))
outlier <- c() #Initiate a vector to store outliers

#Calculate the starting values for schoolfield model
strt_value <- function(subset){
  #Get the peaking temperature
  optimal_t <- subset[subset$OriginalTraitValue_logged == max(subset$OriginalTraitValue_logged),]$ConTemp
  #If there are multiple peaks, take the lowest temperature, and record the outlier
  if (length(optimal_t)>1){
    optimal_t <- min(optimal_t)  
    outlier <- c(outlier, subset$id)}
  
  #Split the data into two parts: before and after the peak temperature
  subset_before <- subset(subset, ConTemp <= optimal_t)
  subset_after <- subset(subset, ConTemp >= optimal_t)
  #Linear regression
  lm_before <- tryCatch(lm(OriginalTraitValue_logged ~ ConTemp_rk, subset_before), 
                   error=function(e) NA)
  lm_after <- tryCatch(lm(OriginalTraitValue_logged ~ ConTemp_rk, subset_after), 
                   error=function(e) NA)

  
  #calculate the starting value
  e <- tryCatch(lm_before$coefficients[[2]], error=function(e) NA)
  eh <-tryCatch(lm_after$coefficients[[2]], error=function(e) NA)     #Eh is the slop before the peak                                              
  Tl <- (optimal_t+min(subset$ConTemp))/2 + 273.15                #Tl is set as the mean of minimal and optimal temperature
  Th <- (optimal_t+max(subset$ConTemp))/2 + 273.15                #Th is set as the mean of maximal and optimal temperature
  k_10 <- 10 + 273.15
  rk_10 <- 1 / (k_10 * k)  
  b0 <- rk_10 * lm_after$coefficients[[2]] + lm_before$coefficients[[1]]
  E <- abs(e)
  Eh <- abs(eh) 
  B0 <- abs(b0)              
  El <- E * 0.5                                                   #El is set to 1/2*E
  return(c(B0, E, Tl, Th, El, Eh))
}

#Calculate start value for each group
Start_Value <- ddply(Mydata, .(id), function(x) strt_value(x))
#Set column names
colnames(Start_Value) <- c("id", "B0", "E", "Tl", "Th", "El", "Eh")
#Replace NA with 0.6 
Start_Value[is.na(Start_Value)] <- 0.6

#Merge data and start value table
Mydata <- merge.data.frame(Mydata, Start_Value, by = "id")

#Save as csv
write.csv(Mydata, "../Data/BioTraits_modified.csv",row.names = F)
