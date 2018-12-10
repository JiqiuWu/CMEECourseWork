roll <- function(bones){
  dice <- sample(bones, size = 2, replace = T)  
  sum(dice)
}

print(roll(bones = 1:6))
