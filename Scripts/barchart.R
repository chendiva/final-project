library(plotly)
library(shiny)
library(stringr)
library(dplyr)


BuildBar.state <- function(yvar){
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


y.equation <- paste0('~', yvar)
p<-plot_ly(df3, x = df3$State, y = eval(parse(text = y.equation)), color = df3$State,
        size = df3$sum,
        text = ~paste(df3[,eval(yvar)]))%>% 
  layout(title = paste0("Comparison of diffent types of surgery in State leve "),
         xaxis = list(showgrid = FALSE),
         yaxis = list(showgrid = FALSE),
         showlegend = FALSE)
  return(p)
}
