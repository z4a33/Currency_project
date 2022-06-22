library(tidyverse)
library(plyr)
library(RJSONIO)
library(data.table)
library(dplyr)
library(lubridate)
library(ggplot2)
library(tidyr)
library(DT)


########################
path <- "http://api.nbp.pl/api/exchangerates/tables/a/2012-01-01/2012-01-31/" 
df  <- data.table(ldply(fromJSON(path), data.frame))
##############################################

names_by_table_a <- function() {
  path <- "https://api.nbp.pl/api/exchangerates/tables/a/" 
  names_a  <- data.frame(unlist(ldply(fromJSON(path), data.frame)))
  names_a <- names_a[-c(1,2,3),]
  n_a <- length(names_a)/3
  names_a <- data.frame("Code"=names_a[(c(1:n_a)*3-1)],"Name"=names_a[(c(1:n_a)*3-2)],use.names = FALSE)
  names_a <- names_a[,c(1,2)]
  colnames(names_a) <- c("A_sign","A_names")
  
  return(names_a)
}

names_by_table_b <- function() {
  path <- "https://api.nbp.pl/api/exchangerates/tables/b/"
  names_b  <- data.frame(unlist(ldply(fromJSON(path), data.frame)))
  names_b <- names_b[-c(1,2,3),]
  n_b <- length(names_b)/3
  names_b <- data.frame("Code"=names_b[(c(1:n_b)*3-1)],"Name"=names_b[(c(1:n_b)*3-2)],use.names = FALSE)
  names_b <- names_b[,c(1,2)]
  colnames(names_b) <- c("B_sign","B_names")
  
  return(names_b)
}

names_a <- names_by_table_a()
names_b <- names_by_table_b()

all_names <- as.data.frame(mapply(c, names_a,names_b))


######################################### konwerter walut
value_in_pln <- function(symb, date="") {
  names_a = names_by_table_a()
  names_b = names_by_table_b()
  if(symb %in% as.vector(names_a[,1]))
    path <- "http://api.nbp.pl/api/exchangerates/rates/a/code/date"
  else if(symb %in% names_b[,1])
    path <- "http://api.nbp.pl/api/exchangerates/rates/b/code/date"
  path <- gsub("code", symb, path)
  path <- gsub("date", date, path)
  result <- ldply(fromJSON(path), data.frame)[4,5]
  return(result)
}


converter <- function(nr_units, symb1, symb2, date) {
  nr_units = as.double(nr_units)
  result <- nr_units*value_in_pln(symb1, date)/value_in_pln(symb2, date)
  return(round(result, 2)))
}


