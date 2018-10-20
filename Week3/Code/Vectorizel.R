M <- matrix(runif(1000000),1000,1000)

SumALLElements <- function(M){
    Dimensions <- dim(M)
    Tot <- 0
    for (i in l:Dimensions[1]){
        for (j in l:Dimensions[2]){
            Tot <- Tot + M[i,j]
        }
    }
    return(Tot)
}

##