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
clean_LOCAL <- function(colum) {
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
       colum <- gsub(i, substitucion[i],colum)
    }
    return(colum)
}