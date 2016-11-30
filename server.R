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

#df1 and df2 are two files that we are using
df1<- read.csv('./data/Survey.csv',stringsAsFactors = FALSE)
df2 <- read.csv('./data/Procedures.csv',stringsAsFactors = FALSE)

#In df4, I select the state and the hospital and the state name, which is necessary, since we doesn't need evey data
#Also because we are using this later to combine it with df2, which I have checked, not all the data are matched.
df4 = df1 %>% distinct_(~Hospital.Name,~State)

#df5 is the data frame that joined two sets of data. Our data is a little bit weird since the N/A part is not blank, we can not use the normal mathod to get rid of the N/A part.
#After observation, the N/A part will shown "Not available" in two parts. The first part is in every surgery, and one of the row only shown in the column of "Cardivascular".
# As a result, i can used filter to get rid off the hospital that refused to offered data, in order to let our plots publish succcessfully.
df5 <- left_join(df4,df2,by = "Hospital.Name") %>% filter_(~Gastrointestinal != "Not Available") %>%filter_(~Cardiovascular != "Not Available") %>% 
  select(Hospital.Name,State,Gastrointestinal,Eye,Nervous.System,Musculoskeletal,Genitourinary,Skin,Cardiovascular,Respiratory,Other)

#df3 was created for the state level, I grouped it according to states, and selected only the information I need for the bar graph.
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
    DT::datatable(df5, options = list(pageLength = 10))
  )
  output$pie.hospital<-renderPlotly({
    return(BuildPie.hospital(input$ycol3))
  })
})