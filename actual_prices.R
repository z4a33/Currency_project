install.packages("RJSONIO")
install.packages("data.table")
install.packages("plyr")
library(plyr)
library(RJSONIO)
library(data.table)
library(ggplot2)

actual_prices <- function(waluty) {
  
  path <- "http://api.nbp.pl/api/exchangerates/tables/a/"
  df  <- ldply(fromJSON(path), data.frame)
  df = df[4:length(df)]
  iter = length(df)/3
  waluta = c()
  wartosc = c()
  for (i in 1:iter) {
    if (df[3*i - 1] %in% waluty) {
      waluta <- c(waluta, df[3*i - 1])
      wartosc <- c(wartosc, df[3*i])
    }
  }
  
  dane <- data.frame("waluta" = as.character(c(waluta)),
                     "wartosc" = as.double(c(wartosc))) 
}
  