

shinyUI(fluidPage(


  tabsetPanel(
              
    tabPanel(
      titlePanel("Porównaj wykresy walut"),
      actionButton("go1", "Go"),
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
      actionButton("go2", "Go"),
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
      titlePanel("Aktualne ceny w PLN"),
      h4(paste("Dzisiaj jest", as.character(Sys.Date()), sep = " ")),
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
    ),
    
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
      ),
      mainPanel(
        h1("Wynik"),
        verbatimTextOutput("txtout")
      )
      
    )
    


  )))
