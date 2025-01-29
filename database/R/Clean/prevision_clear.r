source("./R/Clean/clean.r")

discard <- function(dataframe) {
    dataframe$COD <- NULL
    dataframe$SIGLA <- NULL
    dataframe <- dataframe[!dataframe$LOCAL %in% c("Sudeste", "Sul","Norte","Sul","Nordeste","Centro-Oeste","Brasil"), ]
    return(dataframe)
}

clean <- function(dataframe) {  
    dataframe <- discard(dataframe)
    dataframe$nMx<-clean_float(dataframe$nMx)
    dataframe$nqx<-clean_float(dataframe$nqx)
    dataframe$nAx<-clean_float(dataframe$nAx)
    dataframe$lx<-clean_int(dataframe$lx)
    dataframe$ndx<-clean_int(dataframe$ndx)
    dataframe$nLx<-clean_int(dataframe$nLx)
    dataframe$Sx<-clean_float(dataframe$Sx)
    dataframe$Tx<-clean_int(dataframe$Tx)
    dataframe$ex<-clean_float(dataframe$ex)
    dataframe$LOCAL <- clean_LOCAL(dataframe$LOCAL)
    dataframe$UF <- NULL
    return(dataframe)
}