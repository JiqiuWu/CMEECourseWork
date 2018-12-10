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
  for (i in times){
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

neutral_step_speciation <- function(community){
  new_community = initialise_max(length(community)) + 1
  community[1]=new_community[-1]
  return(community)

  
x <- runif(min = 0, max =1)
if (x <0.2){
  community = neutral_step_speciation(community)
} else{
  community = neutral_step(community)

  return(community)
}
}
#9

neutral_generation_speciation <- function(community,v){
  times = round(length(community)/2)
  for (i in 1:times){
    community = neutral_step_specitation(community)
  return(community)}
}
#10

neutral_time_series_speciation <- function(community,v,duration){
  community = initialise_max(initial)
  times = duration
  for (i in times)
    community = neutral_generation_speciation(community,v)
  richness =  length(unique(community))
  return(richness)
}
#11

question_12 <- function(){
  
  
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

if (length(x) > length(y)){
  a = x
  x = y
  y = a
}
sum_vect <- function(x,y){
  if(length(x) != length(y)){
    gap = length(y)-length(x)
    for (i in gap){
    x = append(x,0)}
    result = sum(x+y)
  } else {
  result = sum(x+y)
  }
}
#15











  
  