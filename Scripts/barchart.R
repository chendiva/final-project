#Load the package we need for this chart
library(plotly)
library(shiny)
library(stringr)
library(dplyr)

#Build a bar chart based on the state level for comparison.
BuildBar.state <- function(yvar){

  #We need transfer the value in the data set to the numeric value in order to do the calculation and the arrangement
  #Then, we group the data by state and create replace the original data frame based on the state level.
  #Create a sum level that has the total of procedures based on the state level.
  df3$Eye.s <- as.numeric(df3$Eye)
  df3$Nervous.System.s <-as.numeric(df3$Nervous.System)
  df3$Musculoskeletal.s <- as.numeric(df3$Musculoskeletal)
  df3$Genitourinary.s <-as.numeric(df3$Genitourinary)
  df3$Skin.s <-as.numeric(df3$Skin)
  df3$Cardiovascular.s <-as.numeric(df3$Cardiovascular)
  df3$Respiratory.s <- as.numeric(df3$Respiratory)
  df3$Other.s <- as.numeric(df3$Other)
  df3$Gastrointestinal.s <-as.numeric(df3$Gastrointestinal)
  df3<- df3 %>% group_by_(~State) %>% summarise(Gastrointestinal = sum(Gastrointestinal.s), Eye = sum(Eye.s), Nervous.System = sum(Nervous.System.s),
                                              Musculoskeletal = sum(Musculoskeletal.s),Genitourinary = sum(Genitourinary.s),Skin = sum(Skin.s),
                                              Cardiovascular = sum(Cardiovascular.s), Respiratory = sum(Respiratory.s), Other = sum(Other.s)) %>% 
  mutate(sum = Gastrointestinal + Eye + Nervous.System +Musculoskeletal + Genitourinary + Skin +Cardiovascular + Respiratory + Other)

  #get the  y variable as string
   y.equation <- paste0('~', yvar)
   
   #plot the bar chart, and set the size based on the sum of the total number of surgery, and the color based on the states.
   p<-plot_ly(df3, x = df3$State, y = eval(parse(text = y.equation)), color = df3$State,
        size = df3$sum)%>% 
      layout(title = paste0("Comparison of ",str_to_title(yvar), " surgery in State level "),
         xaxis = list(title = "State Name (Abbreviation)",
                      showgrid = FALSE),
         yaxis = list(title = paste0(yvar," surgery number"),
                      showgrid = FALSE),
         showlegend = FALSE)
  
  #Return the plot 
  return(p)
}
