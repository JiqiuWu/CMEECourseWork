#21.)What are the fractal dimensions of these objects? Show and briefly explain your workings.

#the difinition of fractal dimension is: an index for characterizing fractal patterns or sets 
#y quantifying their complexity as a ratio of the change in detail to the change in scale.[1]

#Left one:
#the stick size changes from 1 to 3
#the area changes from 1 to 8
#the dimension= log8 / log3 = 1.89

#Right one:
#the stick size changes from 1 to 3
#the area changes form 1 to (3*9-6)=21
#the dimension = log21 / log 3 = 2.27

#[1]https://en.wikipedia.org/wiki/Fractal_dimension

#22 The chaos game
chaos_games <- function{
  A = c(0,0)
  B = c(3,4)
  C = c(4,1)
  X = c(0,0)
  plot(0:4, 0:4, type = "n")
  points(x = X[1], y = X[2], cex = 0.2)
  pre_sample = list(A,B,C)
  sam = sample(pre_sample, size = 1, replace = T)
  i = 1
  for (i in 1:1000){
    x = sam
    new_point = c((x[1][1]+X[1]) / 2, (x[2][1]+X[2]) / 2) # need to extract the exact element
    points(x = new_point[1], y = new_point[2], cex = 0.1)
    X = new_point
    i = i + 1
  }
}

#23 turtle
turtle <- function(start_position, direction, length){
  start_point = c(start_position[1], start_position[2])
  end_point = c(start_position[1] + length * cos(direction), start_position[2] + length * sin(direction))
  lines(x = start_point, y = end_point)
  
} 

#24 elbow

elbow <- function(start_position,direction, length){
  turtle(start_position,direction, length)
  start_position = c(start_position[1] + length * cos(direction), start_position[2] + length * sin(direction))
  turtle(start_position, direction - pi/4, 0.95*length)
} # point does not present at the right place

# 25

spiral <- function(start_position,direction, length){
  turtle(start_position,direction, length)
  start_position = c(start_position[1] + length * cos(direction), start_position[2] + length * sin(direction))
  turtle(start_position, direction - pi/4, 0.95*length)
}


