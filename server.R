shinyServer(function(input, output) {
  
  
  output$txtout <- renderText({
    symb1 <- all_names[all_names$A_names %in% input[['symb1']],1]
    symb2 <- all_names[all_names$A_names %in% input[['symb2']],1]
    result <- converter(input$nr_units, symb1, symb2, "")
    paste( 'W przeliczeniu dostaliśmy', result, sep = " " )
  })
  
})