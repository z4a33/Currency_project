library(shiny)


shinyServer(function(input, output) {

  output[["first_plot"]] =  {renderPlot({
    print(input[['compar_cur']])
    
    signs <- all_names[all_names$A_names %in% input[['compar_cur']],1]
    data <- compar_cur(signs,input[['compar_start']], input[['compar_end']])
    print(signs)
    ggplot(data,aes(date,rate,col=sign)) +geom_line()
  })



}})
