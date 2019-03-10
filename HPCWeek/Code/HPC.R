rm(list = ls())
graphics.off()

#17
neutral_generation_speciation <- function(community,v){
  times = round(length(community)/2)
  for (i in 1:times){
    community = neutral_step_speciation(community,v)}
  return(community)
}

neutral_step_speciation <- function(community, v){
  x <- runif(1, min = 0, max =1)
  if (x < v){
    add_one = max(community) + 1
    dead = choose_two(length(community))
    die = dead[1]
    community[die] = add_one
    return(community)
  } else{
    community = neutral_step(community)
    
    return(community)
  }
}

choose_two <- function(x){
  two <- sample(1:x, size = 2, replace = F)
  return(two)
}

species_richness <- function(community){
  species_richness <- length(unique(community))
  return(species_richness)
}

species_abundance <-function(community){
  species_abundance <- sort(as.numeric(table(community)), decreasing = T)
  return(species_abundance)
}

octaves <- function(community){
  
  result <- tabulate(as.integer(floor(log2(community))) + 1)  
  return(result)
}

initialise_min <- function(size){
  minimum <- sample(1,size, replace = T)
  return(minimum)
}

neutral_time_series_speciation <- function(community,v,duration){
  richness =  c(species_richness(community))
  for (i in 1:duration){
    community = neutral_generation_speciation(community,v)
    richness = c(richness, species_richness(community))
  }
  return(richness)
}

neutral_step <- function(community){
  die_repro = choose_two(length(community))
  community[die_repro[1]]=community[die_repro[2]]
  return(community)
}
#copy funtions form the previous file

cluster_run <-function(species_rate, size,wall_time, interval_rich, interval_oct, burn_in_generations, output_file_name){

community = initialise_min(size)

tic = proc.time()
while(as.numeric(proc.time()-tic)[3] < (wall_time *60)){
  

  rich = c()
  oct =  list()
  
  community_list = list()
  
  for (i in 1:burn_in_generations){
    community_list = list(community_list, neutral_generation_speciation(community, species_rate))
    
    if (i %% interval_rich == 0){
      rich = c(rich, species_richness(community[i]))
    }
    if (i %% interval_oct == 0){
      oct = c(oct, list(octaves(species_abundance(community[i] ))))
    }
  }
  
  }
community_end = community_list[length(community_list)]

totaltime=as.numeric(proc.time()-tic)[3]
save(totaltime, oct, rich, community_end, species_rate,size,wall_time,interval_rich,interval_oct,burn_in_generations, file =output_file_name)
}


iter <- as.numeric(Sys.getenv("PBS_ARRAY_INDEX"))
#iter = 1
real_size <- function(iter){
  if (iter%%4 == 1){
    size=500
  }
  if (iter%%4 == 2){
    size=1000
  }
  if (iter%%4 == 3){
    size=2500
  }
  if (iter%%4 == 0){
    size=5000
  }
  return(size)
}



simulation <- function(iter){
  size = real_size(iter)
  interval_oct = (size) / 10
  burn_in_generations = (size) * 8
cluster_run(species_rate = 0.002197, size, wall_time = 11.5*60, interval_rich = 1, interval_oct, burn_in_generations, output_file_name = paste("my_test_file_",iter,".rda",sep=""))
}

simulation(iter)





