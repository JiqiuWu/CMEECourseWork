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

MyTree <- read.table("../data/trees.csv", sep = ",", header = T, stringsAsFactors = F) #read information, and aviod R seting objects into factor

TreeHeight <- function(degrees, distance){  #define the function, and degrees and distance are arguments
    radians <- degrees * pi / 180
    height <- distance * tan(radians) 

    return(height) #calculation of height
}


TreeHeight.m <- TreeHeight(MyTree[,3], MyTree[,2])
MyTree$TreeHeight.m <- TreeHeight.m #add the heights calculated into a row of the previous csv file
write.csv(MyTree, "../results/TreeHts.csv", row.names = F) #output the csv file with heights of trees, and avoid R setting numbers into the first column,NICE!
