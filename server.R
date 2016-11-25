#Server.r
#Load the package and library that we need to use 
library(dplyr)
library(plotly)
library(shiny)
library(rsconnect)

#Read in data
#Set the data set into the data frame
source('./Scripts/bubbledotchart.r')
df1<- read.csv('./data/Survey.csv',stringsAsFactors = FALSE)
df2 <- read.csv('./data/Procedures.csv',stringsAsFactors = FALSE)
df3 <- df2 %>% select(Hospital.Name,Gastrointestinal,Eye,Nervous.System,Musculoskeletal,Genitourinary,Skin,Cardiovascular,Respiratory,Other)
#Start Shiny server

shinyServer(function(input, output) { 
  
  # Render a plotly object that returns your map
  #Put the variables of the data frame and the two you need for comparison into the function(which you get these from the ui)
  output$bubble.state <- renderPlotly({ 
    return(BuildBubble.state(input$ycol))
  }) 
  output$table1 <- DT::renderDataTable(
    DT::datatable(df3, options = list(pageLength = 20))
  )
})