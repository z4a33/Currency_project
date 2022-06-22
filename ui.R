
library(shiny)


shinyUI(fluidPage(
  tabsetPanel(
    tabPanel(
    titlePanel("Aktualne ceny w PLN"),
        checkboxGroupInput(inputId = "waluty",
                           label = "Wybierz waluty",
                           inline = TRUE,
                           selected = c("USD", "EUR"),
                           c("THB", "USD", "	AUD", "HKD", "CAD", 	
                              "NZD", 	"SGD", 'EUR', "	HUF", 	
                              "CHF", "GBP", "UAH", "JPY", "CZK", "DKK", "	ISK", 	
                              "NOK")),
        actionButton(inputId ="click",label = "Zobacz wykres"),
        plotOutput("wykres")
    )
  )
))


      
      
