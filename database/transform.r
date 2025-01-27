library(RSQLite)
data=read.csv("./death_projection.csv", header = TRUE, sep = ";")
con <- dbConnect(RSQLite::SQLite(), "DeathsProjection.db")

dbWriteTable(con, "pessoas", data, append = TRUE, row.names = FALSE)