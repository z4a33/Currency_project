shinyUI(fluidPage(
  
  tabsetPanel(
    
    tabPanel(
      titlePanel("Porównaj wykresy walut"),
      selectInput(
        'compar_cur',
        'Porównaj wykresy walut',
        all_names[2],
        selected = "EUR",
        multiple = TRUE,
        selectize = TRUE,
        width = NULL,
        size = NULL),
      
      plotOutput("first_plot"),
      
      dateInput(
        'compar_start',
        "Start date",
        value = "2021-01-01",
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
    ),
    
    tabPanel(
      titlePanel("Czy rośnie"),
      selectInput(
        'is_increasing',
        'czy rośnie',
        all_names[2],
        selected = "EUR",
        multiple = TRUE,
        selectize = TRUE,
        width = NULL,
        size = NULL),
      
      dataTableOutput("table_of_move")
      
    ),
    
    tabPanel(
      titlePanel("Konwerter walutowy"),
      sidebarPanel(
        
        tags$h3("Do obliczeń będziemy potrzebować liczby jednostek, 
                walutę początkową, walutę docelową i datę:"),
        textInput("nr_units", "Podaj liczbę jednostek: ", 1),
        
        tags$h5("Podaj początkową walutę: "),
        
        selectInput(
          'converter',
          "symb1",
          all_names[2],
          selected = "EUR",
          multiple = FALSE,
          selectize = TRUE,
          width = NULL,
          size = NULL),
        tags$h5("Podaj docelową walutę: "),
        
        selectInput(
          'converter',
          "symb2",
          all_names[2],
          selected = "EUR",
          multiple = FALSE,
          selectize = TRUE,
          width = NULL,
          size = NULL),
        
        dateInput(
          'converter',
          "symb2",
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
        dataTableOutput("table_converter") 
      )
    )
    
  )
))