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

args = commandArgs(trailingOnly = T) #also can be args = commanArgs(T) 
#pass arguments from the command line

MyTree <- read.table(args[1], sep = ",", header = T, stringsAsFactors = F) #import the data

TreeHeight <- function(degrees, distance){
  radians <- degrees * pi / 180
  height <- distance * tan(radians)
  
  return(height)
}
#define the function that will calculate the height of the trees

TreeHeight.m <- TreeHeight(MyTree[,3], MyTree[,2])
#calculate the height of trees using the TreeHeight function
#the paremeters is the third column and the second column of the table MyTree

MyTree$TreeHeight.m <- TreeHeight.m
#write the height into the table Mytree

filename = tools::file_path_sans_ext(basename(args[1])) #grab the filename from input file
#tools::file_path_sans_ext can remove the extension
#basename can remove the pathway

resultdir = paste0("../Results/", filename, "_treeheight.csv")
#paste0 can combine the pathway, filename and the extension together 

write.csv(MyTree, file =resultdir, row.names = F)
#write the results to the output file



