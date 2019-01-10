#17
cluster_run <-function( species_rate,size,wall_time,interval_rich,interval_oct,burn_in_generations,output_file_name){
  
  species_rate = 0.1
  size = 100
  wall_time = 10
  interval_rich = 1
  interval_oct = 10
  burn_in_generations = 200
  output_file_name = "may_test_file_1.rda"
  
  neutral_generation_speciation <- function(community,v){
    times = round(length(community)/2)
    for (i in 1:times){
      community = neutral_step_speciation(community,v)}
    return(community)
  }
  
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

  #while(as.numeric(proc.time()-tic)[3] < (wall_time *60)){  
 initialise_min(size)
 #time = proc.time()

 richness = list()
 for (i in 1:burn_in_generations){
 if (i %% interval_rich == 0){
   richness[[i]] = neutral_time_series_speciation(community = initialise_min(size), v = species_rate, i)
   i = i + 1
 }
 all_richness = richness[-which(sapply(richness,is.null))] 
 
 pre_octaves = list()
 if (i %% interval_rich == 0){
   pre_octaves[[i]] = octaves(neutral_time_series_speciation(community = initialise_min(size), v = species_rate, i))
   i = i + 1
 }
 all_octaves = pre_octaves[-which(sapply(pre_octaves,is.null))] 
 }
  }


#totaltime = as.numeric(proc.time()-time)[3]
save(all_octaves, species_rate,size,wall_time,interval_rich,interval_oct,burn_in_generations, file =output_file_name)


#iter <- as.numeric(Sys.getenv("PBS_ARRAY_INDEX"))
