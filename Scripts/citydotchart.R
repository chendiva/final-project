#Install the packages that we need to use for this plot
library(plotly)
library(shiny)
library(dplyr)
library(reshape2)

Builddot.city <-function(xvar1){

  df6$Eye.s <- as.numeric(df6$Eye)
  df6$Nervous.System.s <-as.numeric(df6$Nervous.System)
  df6$Musculoskeletal.s <- as.numeric(df6$Musculoskeletal)
  df6$Genitourinary.s <-as.numeric(df6$Genitourinary)
  df6$Skin.s <-as.numeric(df6$Skin)
  df6$Cardiovascular.s <-as.numeric(df6$Cardiovascular)
  df6$Respiratory.s <- as.numeric(df6$Respiratory)
  df6$Other.s <- as.numeric(df6$Other)
  df6$Gastrointestinal.s <-as.numeric(df6$Gastrointestinal)
  df6<- df6 %>% group_by_(~City) %>% summarise(Gastrointestinal = sum(Gastrointestinal.s), Eye = sum(Eye.s), Nervous.System = sum(Nervous.System.s),
                                             Musculoskeletal = sum(Musculoskeletal.s),Genitourinary = sum(Genitourinary.s),Skin = sum(Skin.s),
                                             Cardiovascular = sum(Cardiovascular.s), Respiratory = sum(Respiratory.s), Other = sum(Other.s)) %>% 
  mutate(sum = Gastrointestinal + Eye + Nervous.System +Musculoskeletal + Genitourinary + Skin +Cardiovascular + Respiratory + Other)

  data.needed1<- filter_(df6,~City %in% xvar1) 

#Create the function for the box chart according to the city level
  plot_ly(data.needed1,c("Gastrointestinal","Eye","Nervous System","Musculoskeletal","Genitourinary","Skin","Cardiovascular","Respiratory","Other"), 
          values = c(~Gastrointestinal,~Eye,~Nervous.System,~Musculoskeletal,~Genitourinary,~Skin,~Cardiovascular,~Respiratory,~Other)) %>%
    add_pie(hole = 0.6) %>%
    layout(title = "Donut charts using Plotly",  showlegend = F,
           xaxis = list(showgrid = FALSE, zeroline = FALSE, showticklabels = FALSE),
           yaxis = list(showgrid = FALSE, zeroline = FALSE, showticklabels = FALSE))

  return(p)
}
