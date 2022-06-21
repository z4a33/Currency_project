#install.packages("RJSONIO")
#install.packages("data.table")


library(plyr)
library(RJSONIO)
library(data.table)


########################
path <- "http://api.nbp.pl/api/exchangerates/tables/a/2012-01-01/2012-01-31/" 
df  <- ldply(fromJSON(path), data.frame)
######################## Przykład pobierania Danych z API


##############################################
names_by_table_a <- function() {
  path <- "https://api.nbp.pl/api/exchangerates/tables/a/" 
  names_a  <- ldply(fromJSON(path), data.frame)
  names_a <- names_a[1,-c(1,2,3)]
  n_a <- length(names_a)/3
  names_a <- rbindlist(list(names_a[1,(c(1:n_a)*3-1)],names_a[1,(c(1:n_a)*3-2)]),use.names = FALSE)
  names_a <- t(names_a)
  colnames(names_a) <- c("A_sign","B_names")
  
  return(names_a)
}

names_by_table_b <- function() {
  path <- "https://api.nbp.pl/api/exchangerates/tables/b/"
  names_b  <- ldply(fromJSON(path), data.frame)
  names_b <- names_b[1,-c(1,2,3)]
  n_b <- length(names_b)/3
  names_b <- rbindlist(list(names_b[1,(c(1:n_b)*3-1)],names_b[1,(c(1:n_b)*3-2)]),use.names = FALSE)
  names_b <- t(names_b)
  colnames(names_b) <- c("B_sign","B_names")
  
  return(names_b)
}
########################################### funkcję oddające nazwy walut nalezącychy do tablei A i B
########################################### Return: tabela gdzie pierwsza kolumna to kody walut a druga to nazwy


###########################################
comaprision_data <- function(list_of_cur, startDate, endDate, names_a, names_b) {
  data <- c()
  startDate <- as.Date(startDate)
  endDate <- as.Date(endDate)
  
  days <- as.integer(difftime(endDate,startDate))
  iter <- ceiling(days/365)
  intervals <- c(seq(0,days,365),days)
  print(intervals)
  for(code in list_of_cur){
    code_price <- c()
    
    
    if(code %in% as.vector(names_a[,1]))
      path <- "http://api.nbp.pl/api/exchangerates/rates/a/code/startDate/endDate/"
    else if(code %in% names_b[,1])
      path <- "http://api.nbp.pl/api/exchangerates/rates/b/code/startDate/endDate/"
    
    path <- gsub("code",code,path)
    
    for(i in 1:iter){
    path_code <- gsub("startDate",startDate+intervals[i],path)
    path_code <- gsub("endDate",startDate+intervals[i+1],path_code)
    print(path_code)
    print(difftime(startDate+intervals[i+1],startDate+intervals[i]-1))
    price  <- ldply(fromJSON(path_code), data.frame)
    price <- price[4,-c(1,2)]
    n <- length(price)/3
    print(n)
    price <- price[c(1:n)*3]  
    code_price <- c(code_price,price)


    }
  }
   return(code_price)
}

######################################### Nie skończona funkca zbierająca dane o wartośći walut do porównania




# konwerter walut
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


converter <- function(nr_units, symb1, symb2, date="") {
  if (symb1 == "PLN") 
    if (symb2 == "PLN") return(nr_units)
    else return(nr_units/value_in_pln(symb2, date))
  else if (symb2 == "PLN") return(nr_units*value_in_pln(symb1, date))
  else return(nr_units*value_in_pln(symb1, data)/value_in_pln(symb2, data))
}