rm(list = ls())
graphics.off()

species_richness <- function(community){
  species_richness <- length(unique(community))
  return(species_richness)
}
#1

initialise_max <- function(size){
  range <- seq(size)
  return(range)
}
#2

initialise_min <- function(size){
  minimum <- sample(1,size, replace = T)
  return(minimum)
}
#3

choose_two <- function(x){
  two <- sample(1:x, size = 2, replace = F)
  return(two)
}
#4

neutral_step <- function(community){
  die_repro = choose_two(length(community))
  community[die_repro[1]]=community[die_repro[2]]
  return(community)
}
#5

neutral_generation <- function(community){
  times = round(length(community)/2)
  for (i in 1:times){
    community = neutral_step(community)}
    return(community)
}
#6

neutral_time_series <- function(initial, duration){
  result <- c(species_richness(initial))
  for (i in 1:duration){
    initial = neutral_generation(initial)
    result = c(result,species_richness(initial))
    }
    return(result)
}
#7

plot(x=1:201, y = neutral_time_series(initialise_max(100), 200), type = "p", xlab = "generations" , ylab = "speices_richness", main = "The exact plot of question8, happy!")

#8

neutral_step_speciation <- function(community, v){
  x <- runif(1, min = 0, max =1)
if (x < v){
  middle_community = community + 1
  dead = sample(community, size = 1, replace = F)
  community[dead] = middle_community[length(middle_community)]
  return(community)
} else{
  community = neutral_step(community)

  return(community)
}
}
#9

neutral_generation_speciation <- function(community,v){
  times = round(length(community)/2)
  for (i in 1:times){
    community = neutral_step_speciation(community,v)}
  return(community)
}
#10

neutral_time_series_speciation <- function(community,v,duration){
  richness =  c(species_richness(community))
  for (i in 1:duration){
  community = neutral_generation_speciation(community,v)
  richness = c(richness, species_richness(community))
  }
  return(richness)
}
#11
question12 <- function(community,v,duration){
p <- plot(x=1:201, y = neutral_time_series_speciation(initialise_max(100), 0.1, 200), type = "l", xlab = "generations" ,ylim =  range(1,100), col = "blue", ylab = "speices_richness", main = "The exact plot of question12, happy!")
par(new = T)
p <- plot(x=1:201, y = neutral_time_series_speciation(initialise_min(100), 0.1, 200), type = "l", ylim =range(1,100), col = "green")
}

#12

species_abundance <-function(community){
  species_abundance <- sort(as.numeric(table(community)), decreasing = T)
  return(species_abundance)
}
#13

octaves <- function(community){
  
result <- tabulate(as.integer(floor(log2(community))) + 1)  
return(result)
}
#14
sum_vect <- function(x,y){
if (length(x) > length(y)){
  a = x
  x = y
  y = a
}

if(length(x) != length(y)){
    gap = length(y)-length(x)
    for (i in 1:gap){
    x = append(x,0)}
    result = x + y
  } else {
  result = x + y
  }
}
#15



question16 <- function(){
  n <- octaves(neutral_time_series_speciation(initialise_max(100), 0.1, 200))
  p <- octaves(neutral_time_series_speciation(initialise_min(100), 0.1, 200))
  q <- neutral_time_series_speciation(initialise_max(100), 0.1, 2000)
  r <- neutral_time_series_speciation(initialise_min(100), 0.1, 2000) 

lst <- list()
for (i in 1:2000){
  
if (i %% 20 == 0){
  lst[[i]] = octaves(neutral_time_series_speciation(initialise_max(100),0.1,i))
 i = i + 1
}
  all_octaves = lst[-which(sapply(lst,is.null))] 
  
  summa = all_octaves[[1]]
  for (i in 2:100){
    summa = sum_vect(summa, all_octaves[[i]])
    average = summa/100
    barplot(average)
 # return(lst)
} 
}
} 









  
  