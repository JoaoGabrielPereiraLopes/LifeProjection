source("./R/Clean/clean.r")

clean <- function(dataframe) {
    dataframe$UF <- clean_LOCAL(dataframe$UF)
    dataframe$AreaTerritorial<-clean_float(dataframe$AreaTerritorial)
    dataframe$Densidadedemografica<-clean_float(dataframe$Densidadedemografica)
    dataframe$IDH<-clean_float(dataframe$IDH)
    return(dataframe)
}