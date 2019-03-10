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

question8 <-function(){
  pdf(file="../Results/Figures/Question8.pdf")
  
  plot(x=1:201, y = neutral_time_series(initialise_max(100), 200), 
       
       type = "p", pch = 20, cex =0.5, col = "blue",
       xlab = "Generations" , ylab = "Speices Richness", 
       
       main = "Neutral Model Simulation Over Generations")
  
  dev.off()
}
#8

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


question12 <- function(){
    pdf(file="../Results/Figures/Question12.pdf")
  
    y1 = neutral_time_series_speciation(initialise_max(100),0.1,duration=200)
    y2 = neutral_time_series_speciation(initialise_min(100),0.1,duration=200)
    x = c(1:length(y1))
  
    plot(x, y1, xlab="Generations", ylab = "Species Richness", cex = 0.5,
    main="Netural Model Simulation With Speciation Over Generations", col="green", pch=20, ylim =c(1,100))
    points(x, y2, col="blue", pch=20, cex = 0.5)
    legend('topright',c('initialise max','initialise min'),
           col=c('green','blue'), pch=c(20,20), bty="n")
    dev.off()
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



question16_200 <- function(){
  #n <- octaves(neutral_time_series_speciation(initialise_max(100), 0.1, 200))
  #p <- octaves(neutral_time_series_speciation(initialise_min(100), 0.1, 200))
  #q <- neutral_time_series_speciation(initialise_max(100), 0.1, 2000)
  # r <- neutral_time_series_speciation(initialise_min(100), 0.1, 2000) 
  duration = 200
  lst = list()
  summa = c()
  
  community = initialise_max(100)
  community_list = list()
  for (i in 1:duration){
    community = neutral_generation_speciation(community,0.1)
    community_list = c(community_list, list(community))
    
    if (i %% 20 == 0){
      
      summa = sum_vect(summa, octaves(species_abundance(community_list[i])))
      
      
    }
  }
  
  avg = unlist(summa)/10
  
  
  pdf(file="../Results/Figures/Question16_2000.pdf")
  
  barplot(avg, xlab = "The Abundance Range", ylab = "The Number Of Species",
          main = "The Average Of The Species Abundance Distribution Over 200 generation",
          names.arg = c(2^((1:length(avg))-1)), ylim = c(0,10))
  dev.off()
} 


question16_2000 <- function(){
  #n <- octaves(neutral_time_series_speciation(initialise_max(100), 0.1, 200))
  #p <- octaves(neutral_time_series_speciation(initialise_min(100), 0.1, 200))
  #q <- neutral_time_series_speciation(initialise_max(100), 0.1, 2000)
  # r <- neutral_time_series_speciation(initialise_min(100), 0.1, 2000) 
  duration = 2000
  lst = list()
  summa = c()
  
  community = initialise_max(100)
  community_list = list()
  for (i in 1:duration){
    community = neutral_generation_speciation(community,0.1)
    community_list = c(community_list, list(community))
    
    if (i %% 20 == 0){
      
      summa = sum_vect(summa, octaves(species_abundance(community_list[i])))
    }
  }
  
  avg = unlist(summa)/100
  
  pdf(file="../Results/Figures/Question16_2000.pdf")
  barplot(avg, xlab = "The Abundance Range", ylab = "The Number Of Species",
          main = "The Average Of The Species Abundance Distribution Over 2000 generation",
          names.arg = c(2^((1:length(avg))-1)), ylim = c(0,10))
  dev.off()
} 

#17
cluster_run <-function( species_rate, size,wall_time, interval_rich, interval_oct, burn_in_generations, output_file_name){
  
  tic = proc.time()
  while(as.numeric(proc.time()-tic)[3] < (wall_time *60)){
    
    rich = list()
    oct = list()
    for (i in 1:burn_in_generations){
      if (i %% interval_rich == 0){
        rich = c(rich, species_richness(neutral_time_series_speciation(community = initialise_min(size), v = species_rate, i)))
      }
      if (i %% interval_oct == 0){
        oct = c(oct, list(octaves(neutral_time_series_speciation(community = initialise_min(size), v = species_rate, i))))
      }
    }
    
  }
  community_end = neutral_time_series_speciation(community = initialise_min(size), v = species_rate, duration = burn_in_generations)
  
  totaltime=as.numeric(proc.time()-tic)[3]
  save(totaltime, oct, community_end, species_rate,size,wall_time,interval_rich,interval_oct,burn_in_generations, file =output_file_name)
}

#18
#19

#20
all_oct_avg <- function(){
  a <- c(1:25)
  b <- 4*a - 3
  c <- 4*a - 2
  iter <- sort(c(b,c))
  
  all_oct_avg = c()
  for (i in iter){
    file = paste("my_test_file_",i,".rda",sep="")
    load(file)
    summa_oct = c(0)
    
    for (j in 1:length(oct)){
      summa_oct = sum_vect(summa_oct,oct[[j]])
    }
    oct_avg = summa_oct/length(oct)
    all_oct_avg = c(all_oct_avg, list(oct_avg))
  }
  return(all_oct_avg)
}

question20 <- function(){
  all_oct_all_500 = c()
  all_oct_all_1000 = c()
 
  for (i in (1:length(all_oct_avg))){
    if(i%%2==1){
      all_oct_all_500 = sum_vect(all_oct_all_500,all_oct_avg[i])
    }
    else if(i%%2==0){
      all_oct_all_1000 = sum_vect(all_oct_all_1000, all_oct_avg[i])
    }
    
  }
  
  all_oct_avg_500 = all_oct_all_500/25
  all_oct_avg_1000 = all_oct_all_1000/25

  
  pdf(file="../Results/Figures/Question20.pdf")
  par(mfrow = c(1,2),oma=c(0,0,2,0))
  barplot(all_oct_avg_500, names.arg = c(2^((1:all_oct_avg_500))-1),
          main = "Community size = 500",
          xlab = "The Abundance Range", ylab = "The Number Of Species")
  
  barplot(all_oct_avg_1000, names.arg = c(2^((1:length(all_oct_avg_1000))-1)),
          main = "Community size = 1000",
          xlab = "The Abundance Range", ylab = "The Number Of Species")
  
  
  
  title("The Average Of The Species Abundance Distribution", outer=TRUE)
  dev.off()
}
  
  











  
  