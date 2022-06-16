
library(shiny)

library(plyr)
library(RJSONIO)
library(data.table)
library(dplyr)
library(lubridate)
library(ggplot2)

shinyUI(fluidPage(

  tabsetPanel(
              
    tabPanel(
      titlePanel("Porównaj wykresy walut"),
      selectInput(
        'compar_cur',
        'Porównaj wykresy walut',
        all_names[2],
        selected = NULL,
        multiple = TRUE,
        selectize = TRUE,
        width = NULL,
        size = NULL),
      
      plotOutput("first_plot"),
      
      dateInput(
        'compar_start',
        "Start date",
        value = NULL,
        min = NULL,
        max = NULL,
        format = "yyyy-mm-dd",
        startview = "month",
        weekstart = 0,
        language = "en",
        width = NULL,
        autoclose = TRUE,
        datesdisabled = NULL,
        daysofweekdisabled = NULL
      ),
      
      dateInput(
        'compar_end',
        "End date",
        value = NULL,
        min = NULL,
        max = NULL,
        format = "yyyy-mm-dd",
        startview = "month",
        weekstart = 0,
        language = "en",
        width = NULL,
        autoclose = TRUE,
        datesdisabled = NULL,
        daysofweekdisabled = NULL
      )
             )
    
    )
  ))
