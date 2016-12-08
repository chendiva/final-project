#Server.r
#Load the package and library that we need to use 
library(dplyr)
library(plotly)
library(shiny)
#library(rsconnect)
library(DT)
library(reshape2)
library(magrittr)

#Read in data
#Set the data set into the data frame
source('./Scripts/bubbledotchart.r')
source('./Scripts/barchart.r')
source('./Scripts/piecharthospital.r')
source('./Scripts/usmap.r')
source('./scripts/dumbbell.r')

map.data <- as.data.frame(read.csv('./data/Procedures.csv', stringsAsFactors = FALSE))
map.data <- left_join(map.data, as.data.frame(read.csv('./data/Survey.csv', stringsAsFactors = FALSE)))

shinyServer(function(input, output) { 
  
  # Render a plotly object that returns your map, charts and the table
  #Put the variables of the data frame that you need for comparison into the function(which you get these from the ui)
  output$bar.state <-renderPlotly({
    return(BuildBar.state(input$ycol2))
  })
  
  output$bubble <- renderPlotly({ 
    return(BuildBubble(input$ycol))
  }) 
  
  #I set the row initially displayed is ten, and then you can click the column to sort.
  output$table1 <- DT::renderDataTable(
    DT::datatable(df5, options = list(pageLength = 10,orderClasses = TRUE))
  )
  
  output$pie.hospital<-renderPlotly({
    return(BuildPie.hospital(input$ycol3))
  })
  
  output$map<-renderPlotly({
    return(drawMap(map.data, input$map.variable, input$display))
  })
  
  output$scatter <- renderPlotly({
    return(compare.surgeries(input$select, input$select1))
  })
  
})