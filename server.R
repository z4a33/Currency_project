
shinyServer(function(input, output) {
  
  signs <- eventReactive(input$go1, {
    all_names[all_names$A_names %in% input[['compar_cur']],1]
  })
  
  signs_1 <- eventReactive(input$go2, {
    all_names[all_names$A_names %in% input[['is_increasing']],1]
  })
  
  output[["first_plot"]] =  renderPlot({
    # signs <- all_names[all_names$A_names %in% input[['compar_cur']],1]
    data <- compar_cur(signs(),input[['compar_start']], input[['compar_end']])
    ggplot(data,aes(date,rate,col=sign)) +geom_line()
  })
  
  output[["table_of_move"]] = renderDataTable({
    # signs_1 <- all_names[all_names$A_names %in% input[['is_increasing']],1]
    df <- move_of_cur(signs_1(),names_a,names_b)
    return(datatable(df) %>% formatStyle('is_increasing',
                                         backgroundColor = styleEqual(c(TRUE, FALSE),
                                                                      c('green', 'red'))))

  })
  
  dane = eventReactive(input$click, {
    wal = c(gsub(pattern = "\t", replacement = "", input$waluty))
    actual_prices(wal)
  })
  output$wykres = renderPlot({ggplot(dane(), mapping = aes(x = waluta, y = wartosc)) +
      geom_bar(fill = "gold",stat = "identity") +
      theme(legend.position = "none") + 
      geom_text(aes(label= wartosc), vjust=-0.3, size=5)})
  
  output$txtout <- renderText({
    symb1 <- all_names[all_names$A_names %in% input$symb1,1]
    symb2 <- all_names[all_names$A_names %in% input$symb2,1]
    result <- converter(input$nr_units, symb1, symb2, "")
    paste(input$nr_units, symb1, paste("(", input$symb1, ")", sep = ""), 
          "to w przeliczeniu", result, symb2, paste("(", input$symb2, ")", sep = ""), 
          sep = " " )
  })

})
