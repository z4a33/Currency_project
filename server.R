library(shiny)


shinyServer(function(input, output) {
  
  dane = eventReactive(input$click, {
    wal = c(gsub(pattern = "\t", replacement = "", input$waluty))
    actual_prices(wal)
  })
  output$wykres = renderPlot({ggplot(dane(), mapping = aes(x = waluta, y = wartosc)) +
    geom_bar(fill = "gold",stat = "identity") +
    theme(legend.position = "none") + 
    geom_text(aes(label= wartosc), vjust=-0.3, size=5)})
})
  

