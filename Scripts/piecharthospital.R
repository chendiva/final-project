#Load the packages we need for this chart.
library(plotly)
library(dplyr)
library(shiny)
library(stringr)

#Build the function that can return the pie chart that display the proportion of procedures of certain hospital.
BuildPie.hospital<- function(name){
  #We need to make arrangement of the data first (take off the rows without any value, and calculate the sum)
  df2 <- read.csv('./data/Procedures.csv',stringsAsFactors = FALSE)
  df2 <- df2 %>% filter_(~Gastrointestinal != "Not Available") %>%filter_(~Cardiovascular != "Not Available") %>% 
         select(Hospital.Name,Gastrointestinal,Eye,Nervous.System,Musculoskeletal,Genitourinary,Skin,Cardiovascular,Respiratory,Other)
  df2$sum <- as.numeric(df2$Gastrointestinal) + as.numeric(df2$Eye) + as.numeric(df2$Nervous.System)+ as.numeric(df2$Musculoskeletal) + as.numeric(df2$Genitourinary) + as.numeric(df2$Skin) + as.numeric(df2$Cardiovascular) + as.numeric(df2$Respiratory) +as.numeric(df2$Other)
  
  #Set a new data frame that comes from the df2 we originally have, this new data frame will be used in pie chart
  #This data frame is created based on the hospital that the user wants to look into
  data.needed<- filter_(df2,~Hospital.Name %in% name)

  #The color is set with different kinds of surgery
  colors <- c(colnames(data.needed))
  
  #Plot the pie chart.
  #Set different pieces based on the surgery type and label them with the name of the surgery, the number of surgery of certain type and the percentage of the total procedures in certain hospital.
  p <- plot_ly(data.needed, labels = c("Gastrointestinal","Eye","Nervous System","Musculoskeletal","Genitourinary","Skin","Cardiovascular","Respiratory","Other"), values = c(~Gastrointestinal,~Eye,~Nervous.System,~Musculoskeletal,~Genitourinary,~Skin,~Cardiovascular,~Respiratory,~Other), 
             type = 'pie',
             textposition = 'inside',
             textinfo = 'label+percent',
             insidetextfont = list(color = '#FFFFFF'),
             
             
             marker = list(colors = colors,
                           line = list(color = '#FFFFFF', width = 1)),
             showlegend = FALSE) %>%
    #Set the tiltle that changes with the hospital of your choice.
    layout(title = paste('Procedure proportion of',str_to_title(name)),
           xaxis = list(showgrid = FALSE, zeroline = FALSE, showticklabels = FALSE),
           yaxis = list(showgrid = FALSE, zeroline = FALSE, showticklabels = FALSE))
   #Return the pie chart.
    return(p)
}