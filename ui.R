shinyUI(fluidPage(
  
  tabsetPanel(
    
    tabPanel(
      titlePanel("Konwerter walutowy"),
      sidebarPanel(
        
        tags$h3("Do obliczeń będziemy potrzebować liczby jednostek, 
                walutę początkową, walutę docelową i datę:"),
        textInput("nr_units", "Podaj liczbę jednostek: ", 1),
        
        selectInput(
          'symb1',
          "Początkowa waluta: ",
          all_names[2],
          multiple = FALSE,
          selectize = TRUE,
          width = NULL,
          size = NULL),
        
        selectInput(
          'symb2',
          "Docelowa waluta: ",
          all_names[2],
          selected = "EUR",
          multiple = FALSE,
          selectize = TRUE,
          width = NULL,
          size = NULL),
        
        dateInput(
          'date',
          "Wybierz datę:",
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
        actionButton("count_button", "Przelicz!"),
        dataTableOutput("table_converter") 
      )
    )
    
  )
))