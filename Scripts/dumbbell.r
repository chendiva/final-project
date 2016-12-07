


compare.surgeries <- function(surgery.one, surgery.two) {
  print(paste0(surgery.one,":",surgery.two))
  all.state <- select_(df3, quote(State), surgery.one, surgery.two) %>%
    summarise_(surgery1.sum = paste0("sum(as.numeric(",surgery.one,"))"),
               surgery2.sum = paste0("sum(as.numeric(",surgery.two,"))"), 
               gap = "surgery1.sum-surgery2.sum")
  
  plot_ly(all.state, color = I("gray80")) %>%
    add_segments(x = ~surgery1.sum, xend = ~surgery2.sum, y = ~State, yend = ~State, showlegend = FALSE) %>%
    add_markers(x = ~surgery1.sum, y = ~State, name = surgery.one, color = I("pink")) %>%
    add_markers(x = ~surgery2.sum, y = ~State, name = surgery.two, color = I("blue")) %>%
    layout(
      title = "Total Number of Surgeries",
      xaxis = list(title = "Number of Surgeries per State"),
      margin = list(l = 65)
    )
}