cluster_run <-function( species_rate,size,wall_time,interval_rich,interval_oct,burn_in_generations,output_file_name){
 initialise_min(size)
 proc.time()

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

write


#iter <- as.numeric(Sys.getenv("PBS_ARRAY_INDEX"))
