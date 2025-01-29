caminho_relativo <- "../../"
caminho_absoluto <- normalizePath(caminho_relativo)
setwd(caminho_absoluto)
source("./R/Clean/clean_States.r")
library(RSQLite)
con <- dbConnect(RSQLite::SQLite(), "lifeProjection.db")
States <- clean(read.csv("./csv/states.csv", sep = ";"))

filter <- function(acronym) {
  resultado <- States[States$Regiao == acronym, ]
  return(resultado)
}

Area <- function(acronym) {
  States_region <- filter(acronym)
  if (nrow(States_region) == 0) return(0)
  return(sum(States_region$AreaTerritorial, na.rm = TRUE))
}

populacion <- function(acronym) {
  States_region <- filter(acronym)
  if (nrow(States_region) == 0) return(0)
  return(sum(States_region$Populacaoresidente, na.rm = TRUE))
}

idh <- function(acronym) {
  States_region <- filter(acronym)
  if (nrow(States_region) == 0) return(NA)
  idh_sum <- sum(States_region$IDH * States_region$Populacaoresidente, na.rm = TRUE)
  return(round(idh_sum / sum(States_region$Populacaoresidente, na.rm = TRUE), digits = 3))
}

Regions <- data.frame(
    ID = 1:5,
    Name = c("Sul", "Sudeste", "Centro-Oeste", "Nordeste", "Norte"),
    Acronym = c('SU', 'SD', 'CO', 'ND', 'NO'),
    AREA = c(Area('SU'), Area('SD'), Area('CO'), Area('ND'), Area('NO')),
    Populacion=c(populacion('SU'), populacion('SD'), populacion('CO'), populacion('ND'), populacion('NO')),
    HDI=c(idh('SU'), /idh('SD'), idh('CO'), idh('ND'), idh('NO'))
)

dbWriteTable(con, "Region", Regions, append = TRUE, row.names = FALSE)