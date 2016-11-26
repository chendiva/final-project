#Load the package we need for this chart.
library(plotly)
library(dplyr)
library(stringr)
library(shiny)

#Build a function that shows the bubble dot plot 

BuildBubble <- function(yvar){
 
  #We first need to make arrangement of the data set since some hospital refused to offer the information.
  #In order to make some calculation based on the data we have, we need to make sure that all the data are numeric
  # So we get rid of the hospitals that refused to offer information about the statistics and used as.numeric syntax to make the information easy to calculate.
   df2 <- df2 %>% filter_(~Gastrointestinal != "Not Available") %>%filter_(~Cardiovascular != "Not Available") %>% 
       select(Hospital.Name,Gastrointestinal,Eye,Nervous.System,Musculoskeletal,Genitourinary,Skin,Cardiovascular,Respiratory,Other)
  df2$sum <- as.numeric(df2$Gastrointestinal) + as.numeric(df2$Eye) + as.numeric(df2$Nervous.System)+ as.numeric(df2$Musculoskeletal) + as.numeric(df2$Genitourinary) + as.numeric(df2$Skin) + as.numeric(df2$Cardiovascular) + as.numeric(df2$Respiratory) +as.numeric(df2$Other)
  
  #get the  y variable as string
  y.equation <- paste0('~', yvar)
  
  #Create a function for the bubble chat we will display.
  #We use evel(parse(text = string variable)) sytax to let the function p to evaluate them as number.
  p <- plot_ly(df2, x =  df2$sum, 
               y = eval(parse(text = y.equation)), type = 'scatter', mode = 'markers', size = df2$sum,
               
               #The color is set by Hospital name.
               #And the range of the size is choosen because I think it will be the best way to read.
               color = df2$Hospital.Name, colors = 'Paired',sizes = c(10, 50),
               marker = list(opacity = 0.5, sizemode = 'diameter'),
               hoverinfo = 'text',
               
               #In the text part, we need to use the df[, eval(variabe we pass)] to get the column that matches the variable that we passed in the function.
               #Paste the related information next to the bubble.
               text = ~paste('Hospital:', df2$Hospital.Name, '<br /> Sum of the surgeries',':',df2$sum,'<br />Numbers of ',yvar,' surgery:',df2[,eval(yvar)],
                             '<br />Percentage:',round(as.numeric(df2[,eval(yvar)])*100/df2$sum,digit = 2),'%' ))%>%
    
    #Set the title of the graph that will be layout correspond to the variable we are using for comparing the procedures among different hospitals.
    layout(title = paste0("Proportion of ",str_to_title(yvar)," surgery in various hospital"),
           xaxis = list(showgrid = FALSE),
           yaxis = list(showgrid = FALSE),
           showlegend = FALSE)
  
  #Return the plot in the end.
  return(p)
}
