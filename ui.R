

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
      
    )

  tabsetPanel(

    
    )
  ))
