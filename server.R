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
  
  output[["table_converter"]] = renderDataTable({
    result <- converter(input[['nr_units']], input[['symb1']], input[['symb2']], input[['date']])
    tab_conv <- data.frame("Jednostki" = input[['nr_units']],
                           "Początkowa waluta" = input[['symb1']],
                           "Data wymiany" = input[['date']],
                           "Jednostki" = result,
                           "Docelowa waluta" = input[['symb2']],)
    return(tab_conv)
  })
  
})