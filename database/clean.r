discard <- function(dataframe) {
    dataframe$COD <- NULL
    dataframe$SIGLA <- NULL
    dataframe <- dataframe[!dataframe$LOCAL %in% c("Sudeste", "Sul","Norte","Sul","Nordeste","Centro-Oeste"), ]
    return(dataframe)
}
clean_float <-function(colum){
    colum <- gsub(',','.', colum)
    colum <- gsub('-','0', colum)
    colum <- as.numeric(colum)
    return(colum)
}
clean_int <-function(colum){
    colum <- as.character(colum)
    colum <- gsub("\\.", "", colum)
    colum <- as.numeric(colum)
    return(colum)
}
clean_LOCAL <- function(dataframe) {
    substitucion <- c(
        "Cear�" = "Ceara",
        "Esp�rito Santo" = "Espirito Santo",
        "Goi�s" = "Goias",
        "Maranh�o" = "Maranhao",
        "Par�" = "Para",
        "Para�ba" = "Paraiba",
        "Paran�" = "Parana",
        "Piau�" = "Piaui",
        "Rond�nia" = "Rondonia",
        "S�o Paulo" = "Sao Paulo",
        "Amap�"="Amapa"
    )
    for (i in names(substitucion)) {
        dataframe$LOCAL <- gsub(i, substitucion[i], dataframe$LOCAL)
    }
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
    dataframe <- clean_LOCAL(dataframe)
    return(dataframe)
}
data <- clean(read.csv("./projecoes_2024_tabuas.csv", header = TRUE, sep = ";"))
write.csv(data, file = "death_projection.csv", row.names = FALSE)