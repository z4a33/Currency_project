shinyServer(function(input, output) {
  
  #result_conv <- eventReactive(input$count_button, {
  #  converter(input$nr_units, input$symb1, input$symb2, input$date)
  #})
  
  output$table_converter = renderDataTable({
    result_conv <- converter(input$nr_units, input$symb1, input$symb2, input$date)
    return(data.frame("Jednostki" = input$nr_units,
                           "Początkowa waluta" = input$symb1,
                           "Data wymiany" = input$date,
                            "Jednostki" = result_conv,
                           "Docelowa waluta" = input$symb2))
  })
  
})