library(tidyverse)
library(plyr)
library(RJSONIO)
library(data.table)
library(dplyr)
library(lubridate)
library(ggplot2)
library(tidyr)
library(DT)



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
########################################### funkcję oddające nazwy walut nalezącychy do tablei A i B
########################################### Return: tabela gdzie pierwsza kolumna to kody walut a druga to nazwy



cur_rate <- function(cur, startDate, endDate, names_a, names_b) {
  
  if(cur %in% names_a[,1])
    path <- "http://api.nbp.pl/api/exchangerates/rates/a/code/startDate/endDate/"
  
  else if(cur %in% names_b[,1])
    path <- "http://api.nbp.pl/api/exchangerates/rates/b/code/startDate/endDate/"
  
  startDate <- as.Date(startDate)
  endDate <- as.Date(endDate)
  days <- as.integer(difftime(endDate,startDate))
  
  
  if(days < 90){
    path <- gsub("startDate",startDate,path)
    path <- gsub("endDate",endDate,path)
    path <- gsub("code",cur,path)
    data <- ldply(fromJSON(path), data.frame)
    row <- which(data == "rates")
    data <- data.table(
      unname(unlist(data[row,grepl("mid",names(data))])),
      unname(unlist(data[row,grepl("Date",names(data))])))
    colnames(data) <- c("rate","date")
    
    data <- data[,c(2,1)]
    data <- cbind(data,rep(cur,nrow(data)))
    colnames(data)[3] <- "sign"
    return(data)
    
  }
  
  iter <- ceiling(days/91)
  intervals <- c(seq(0,days,91),days)
  
  for(i in 1:(length(intervals)-1)){
    
    path_c <- gsub("startDate",startDate+intervals[i],path)
    path_c <- gsub("endDate",startDate+intervals[i+1],path_c)
    path_c <- gsub("code",cur,path_c)
    print(path_c)
    if(i == 1){ 
      
      data  <- ldply(fromJSON(path_c), data.frame)
      row <- which(data=='rates')
      data <- data.table(
        unname(unlist(data[row,grepl("mid",names(data))])),
        unname(unlist(data[row,grepl("Date",names(data))])))
      colnames(data) <- c("rate","date")
    }
    else{ 
      x <- ldply(fromJSON(path_c), data.frame)
      row <- which(x=='rates')
      x <- data.table(
        unname(unlist(x[row,grepl("mid",names(x))])),
        unname(unlist(x[row,grepl("Date",names(x))])))

      data <- rbind(data,x,use.names=FALSE)    
    }
    
  }
  colnames(data) <- c("rate","date")
  data <- unique(data[,c(2,1)])
  data <- cbind(data,rep(cur,nrow(data)))
  colnames(data)[3] <- "sign"
  return(data)
}

compar_cur <- function(cur, startDate, endDate) {
  
  for(c in cur){
    if(which(cur==c)[1]==1){
      data <- cur_rate(c, startDate, endDate, names_a, names_b)

      colnames(data) <- c("date","rate","sign")
    }
    else{
      new <- cur_rate(c, startDate, endDate, names_a, names_b)
      colnames(new) <- c("date","rate","sign")
      data <- rbind(data,new)
    }
  
  }
  data$date = as.Date(data$date, origin = "1964-10-22")
  return(data)
}


  move_of_cur <- function(cur, names_a, names_b) {
  date <- Sys.Date()
  a <- cur[cur %in% names_a[,1]]
  b <- cur[cur %in% names_b[,1]]

  if(length(a) != 0){

  data_a <- compar_cur(a, date-5, date)
  x <- data_a$date 
  x <- max( x[x!=max(x)] )
  data_a <- data_a[data_a$date >= x,]
  data_a <- spread(data_a,key = date, value = rate)
  data_a <- cbind(data_a, 0 < data_a[,3]-data_a[,2])
  colnames(data_a)[4] <- "is_increasing"
  }
  
  if(length(b) != 0){
    data_b <- compar_cur(b, date-15, date)
    x <- data_b$date 
    x <- max( x[x!=max(x)] )
    data_b <- data_b[data_b$date >= x,]
    data_b <- spread(data_b,key = date, value = rate)
    data_b <- cbind(data_b, 0 < data_b[,3]-data_b[,2])
    colnames(data_b)[4] <- "is_increasing"
  }
  if(length(a) == 0) return(data_b[,c(1,4)])
  if(length(b) == 0) return(data_a[,c(1,4)])

  return(rbind(data_a,data_b,use.names= FALSE)[,c(1,4)])
}

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
    return(round(result, 2))
  }
  ######################################### 

names_a <- names_by_table_a()
names_b <- names_by_table_b()

all_names <- as.data.frame(mapply(c, names_a,names_b))

