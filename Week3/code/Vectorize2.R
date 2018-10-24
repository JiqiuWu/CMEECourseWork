# Runs the stochastic (with gaussian fluctuations) Ricker Eqn .

rm(list=ls())

stochrickvect <- function(p0=runif(1000,.5,1.5),r=1.2,K=1,sigma=0.2,numyears=100)
{
  #initialize
  N<-matrix(NA,numyears,length(p0))
  N[1,]<-p0
  
  for (yr in 2:numyears) { 
    N[yr,]<-N[yr-1,]*exp(r*(1-N[yr-1,]/K))+rnorm(length(p0), 0, sigma)
  }
  
 return(N)

}

# Now write another function called stochrickvect that vectorizes the above 
# to the extent possible, with improved performance: 

print("Vectorized Stochastic Ricker takes:")
print(system.time(res2<-stochrickvect()))

