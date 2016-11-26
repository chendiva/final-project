#Server.r
#Load the package and library that we need to use 
library(dplyr)
library(plotly)
library(shiny)
library(rsconnect)
library(DT)
#Read in data
#Set the data set into the data frame
source('./Scripts/bubbledotchart.r')
source('./Scripts/barchart.r')
source('./Scripts/piecharthospital.r')
df1<- read.csv('./data/Survey.csv',stringsAsFactors = FALSE)
df2 <- read.csv('./data/Procedures.csv',stringsAsFactors = FALSE)
df4 = df1 %>% distinct_(~Hospital.Name,~State)
df5 <- left_join(df4,df2,by = "Hospital.Name") %>% filter_(~Gastrointestinal != "Not Available") %>%filter_(~Cardiovascular != "Not Available") %>% 
  select(Hospital.Name,State,Gastrointestinal,Eye,Nervous.System,Musculoskeletal,Genitourinary,Skin,Cardiovascular,Respiratory,Other)
df3 <- df5 %>% group_by_(~State) %>% select(State,Gastrointestinal,Eye,Nervous.System,Musculoskeletal,Genitourinary,Skin,Cardiovascular,Respiratory,Other) 

     


shinyServer(function(input, output) { 
  
  # Render a plotly object that returns your map, charts and the table
  #Put the variables of the data frame that you need for comparison into the function(which you get these from the ui)
  output$bar.state <-renderPlotly({
    return(BuildBar.state(input$ycol2))
  })
  output$bubble <- renderPlotly({ 
    return(BuildBubble(input$ycol))
  }) 
  output$table1 <- DT::renderDataTable(
    DT::datatable(df5, options = list(pageLength = 20))
  )
  output$pie.hospital<-renderPlotly({
    return(BuildPie.hospital(input$ycol3))
  })
})