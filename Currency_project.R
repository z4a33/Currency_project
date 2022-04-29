install.packages("RJSONIO")

library(plyr)
library(RJSONIO)


path <- "http://api.nbp.pl/api/exchangerates/tables/a/2012-01-01/2012-01-31/" 
df  <- ldply(fromJSON(path), data.frame)
