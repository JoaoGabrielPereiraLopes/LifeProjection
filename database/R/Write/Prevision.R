caminho_relativo <- "../../"
caminho_absoluto <- normalizePath(caminho_relativo)
setwd(caminho_absoluto)
source("./R/Clean/prevision_clear.r")

library(RSQLite)
con <- dbConnect(RSQLite::SQLite(), "lifeProjection.db")
Prevision <- clean(read.csv("./csv/projecoes_2024_tabuas.csv", header = TRUE, sep = ";"))

takeID<-function(colum){
    States<-unique(colum)
    IDS=c()
    for (State in States) {
        query <- paste("SELECT ID FROM State WHERE FU = '", State, "'", sep="")
        IDS <- c(IDS, dbGetQuery(con, query)$ID)
    }
    States <- data.frame(
        input=States,
        output=IDS
    )
    return(States)
}

writeID<-function(colum){
    input<-takeID(colum)
    for (x in 1:nrow(input)) {
        colum[colum == input$input[x]] <- input$output[x]
    }
    colum <- as.numeric(colum)
    return(colum)
}
Prevision$LOCAL<-writeID(Prevision$LOCAL)
Prevision <- data.frame(
    ID = 1:nrow(Prevision),
    Sex = Prevision$SEXO,
    Age = Prevision$IDADE,
    Year = Prevision$ANO,
    nMx = Prevision$nMx,
    nqx = Prevision$nqx,
    nAx = Prevision$nAx,
    lx = Prevision$lx,
    ndx = Prevision$ndx,
    nLx = Prevision$nLx,
    Sx = Prevision$Sx,
    Tx = Prevision$Tx,
    ex = Prevision$ex,
    STATE=Prevision$LOCAL
)
dbWriteTable(con, "Prevision", Prevision, append = TRUE, row.names = FALSE)