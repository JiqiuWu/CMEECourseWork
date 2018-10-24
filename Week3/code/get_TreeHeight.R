# This function calculates heights of trees given distances of each
# from its base and angle to its top, using the trigonometric for
#
# height = distance * tan(radians)
#
# AGRUMENTS
# degrees: The angle of elevation of tree
# distance: The distance from base of tree(e.g. meters)
#
# OUTPUT
# The heights of the tree, same units as "distance"
args = commandArgs(trailingOnly = T)


MyTree <- read.table(args[1], sep = ",", header = T, stringsAsFactors = F)

TreeHeight <- function(degrees, distance){
  radians <- degrees * pi / 180
  height <- distance * tan(radians)
  
  return(height)
}


TreeHeight.m <- TreeHeight(MyTree[,3], MyTree[,2])

MyTree$TreeHeight.m <- TreeHeight.m

InputFileName <- as.character(args[1])
write.csv(MyTree, file = args[2], out.txt)
