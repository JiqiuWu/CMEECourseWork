## run a simulation that involves sampling from a population with try

x <- rnorm(50) #Generate your population
doit <- function(x){
  x <- sample(x, replace = TRUE)
  if(length(unique(x)) > 30) {#only take mean if sample was sufficient
    print(paste("Mean of this sample was:", as.character(mean(x))))
  } 
  else {
    stop("Couldn't calculate mean: too few unique points!")
  }
}
