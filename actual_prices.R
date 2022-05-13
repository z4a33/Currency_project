install.packages("RJSONIO")

library(plyr)
library(RJSONIO)
library(data.table)
library(ggplot2)

actual_prices <- function(waluty) {
  
  path <- "http://api.nbp.pl/api/exchangerates/tables/a/"
  df  <- ldply(fromJSON(path), data.frame)
  df = df[4:length(df)]
  l = length(df)/3
  waluta = c()
  wartosc = c()
  for (i in 1:l) {
    if (df[3*i - 1] %in% waluty) {
      waluta <- c(waluta, df[3*i - 1])
      wartosc <- c(wartosc, df[3*i])
    }
  }
  
  dane <- data.frame("waluta" = as.character(c(waluta)),
                     "wartosc" = as.double(c(wartosc)))
  
  ggplot(dane, aes(x = waluta, y = wartosc)) +
    geom_col()
  
}

actual_prices(c("THB","AUD","HKD","USD","CAD","NZD"))
