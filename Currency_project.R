install.packages("RJSONIO")
install.packages("data.table")


library(plyr)
library(RJSONIO)
library(data.table)



path <- "http://api.nbp.pl/api/exchangerates/tables/a/2012-01-01/2012-01-31/" 
df  <- ldply(fromJSON(path), data.frame)


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




comaprision_data <- function(list_of_cur, startDate, endDate, names_a, names_b) {
  data <- c()
  startDate <- as.Date(startDate)
  endDate <- as.Date(endDate)
  
  days <- as.integer(difftime(endDate,startDate))
  iter <- ceiling(days/365)
  intervals <- c(seq(1,days,365),days)
  for(code in list_of_cur){
    
    if(code %in% as.vector(names_a[,1]))
      path <- "http://api.nbp.pl/api/exchangerates/rates/a/code/startDate/endDate/"
    else if(code %in% names_b[,1])
      path <- "http://api.nbp.pl/api/exchangerates/rates/b/code/startDate/endDate/"
    
    path <- gsub("code",code,path)
    
    for(i in 1:iter){
    path <- gsub("startDate",startDate+intervals[i],path)
    path <- gsub("endDate",startDate[i+1],path)
    print(startDate+intervals[i])
    print(startDate[i+1])
    
    }
  }
   
}

names_a <- names_by_table_a()
names_b <- names_by_table_b()

as.vector(names_a[,1])

a <- names_a[,1]
a <- as.Date("2012-01-01")
b <- as.Date("2015-03-03")


comaprision_data(c("THB"),"2012-01-01","2015-03-03",names_a,names_b)
