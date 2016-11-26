library(plotly)
library(dplyr)
library(shiny)
library(stringr)


BuildPie.hospital<- function(name){
df2 <- read.csv('./data/Procedures.csv',stringsAsFactors = FALSE)
df2 <- df2 %>% filter_(~Gastrointestinal != "Not Available") %>%filter_(~Cardiovascular != "Not Available") %>% 
  select(Hospital.Name,Gastrointestinal,Eye,Nervous.System,Musculoskeletal,Genitourinary,Skin,Cardiovascular,Respiratory,Other)
df2$sum <- as.numeric(df2$Gastrointestinal) + as.numeric(df2$Eye) + as.numeric(df2$Nervous.System)+ as.numeric(df2$Musculoskeletal) + as.numeric(df2$Genitourinary) + as.numeric(df2$Skin) + as.numeric(df2$Cardiovascular) + as.numeric(df2$Respiratory) +as.numeric(df2$Other)
data.needed<- filter_(df2,~Hospital.Name %in% name)

colors <- c(colnames(data.needed))

p <- plot_ly(data.needed, labels = c("Gastrointestinal","Eye","Nervous System","Musculoskeletal","Genitourinary","Skin","Cardiovascular","Respiratory","Other"), values = c(~Gastrointestinal,~Eye,~Nervous.System,~Musculoskeletal,~Genitourinary,~Skin,~Cardiovascular,~Respiratory,~Other), 
             type = 'pie',
             textposition = 'inside',
             textinfo = 'label+percent',
             insidetextfont = list(color = '#FFFFFF'),
             
             
             marker = list(colors = colors,
                           line = list(color = '#FFFFFF', width = 1)),
             #The 'pull' attribute can also be used to create space between the sectors
             showlegend = FALSE) %>%
  layout(title = paste('Procedure proportion of',str_to_title(name)),
         xaxis = list(showgrid = FALSE, zeroline = FALSE, showticklabels = FALSE),
         yaxis = list(showgrid = FALSE, zeroline = FALSE, showticklabels = FALSE))
  return(p)
}