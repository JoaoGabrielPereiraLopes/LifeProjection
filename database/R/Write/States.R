caminho_relativo <- "../../"
caminho_absoluto <- normalizePath(caminho_relativo)
setwd(caminho_absoluto)

source("./R/Clean/clean_States.r")
library(RSQLite)

con <- dbConnect(RSQLite::SQLite(), "lifeProjection.db")
States <- clean(read.csv("./csv/states.csv", sep = ";"))

takeID<-function(colum){
    Regions<-unique(colum)
    IDS=c()
    for (Region in Regions) {
        query <- paste("SELECT ID FROM Region WHERE Acronym = '", Region, "'", sep="")
        IDS <- c(IDS, dbGetQuery(con, query)$ID)
    }
    Regions <- data.frame(
        input=Regions,
        output=IDS
    )
    return(Regions)
}
writeID<-function(colum){
    input<-takeID(colum)
    for (x in 1:nrow(input)) {
        colum <- gsub(input$input[x], input$output[x],colum)
    }
    colum <- as.numeric(colum)
    return(colum)
}
States$Regiao<-writeID(States$Regiao)
States <- data.frame(
    ID = 1:nrow(States),
    FU = States$UF,
    HDI=States$IDH,
    Region=States$Regiao,
    Populacion=States$Populacaoresidente,
    AREA = States$AreaTerritorial,
    Density=States$Densidadedemografica,
    Income=States$Rendimentopercapito
)

dbWriteTable(con, "State", States, append = TRUE, row.names = FALSE)