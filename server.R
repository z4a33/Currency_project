
shinyServer(function(input, output) {

  output[["first_plot"]] =  renderPlot({
    print(input[['compar_cur']])
    
    signs <- all_names[all_names$A_names %in% input[['compar_cur']],1]
    data <- compar_cur(signs,input[['compar_start']], input[['compar_end']])
    print(signs)
    ggplot(data,aes(date,rate,col=sign)) +geom_line()
  })
  
  output[["table_of_move"]] = renderDataTable({
    signs_1 <- all_names[all_names$A_names %in% input[['is_increasing']],1]
    df <- move_of_cur(signs_1,names_a,names_b)
    return(datatable(df) %>% formatStyle('is_increasing',
                                         backgroundColor = styleEqual(c(TRUE, FALSE),
                                                                      c('green', 'red'))))

  })

})
