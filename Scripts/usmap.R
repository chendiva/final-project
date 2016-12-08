library (plotly)
library (dplyr)
library(zipcode)
data("zipcode")
# Sets up the DataFrame map.data to work with.
drawMap <- function(map.data, procedure, max.value) {
  map.data.place <- select(map.data, Hospital.Name, City, State, ZIP.Code)
  map.data.procedure <- select_(map.data, "Hospital.Name", procedure)
  map.data.procedure <- unique(map.data.procedure[1:2])
  names(map.data.procedure)[2]<-paste("Variable")
  map.data <- left_join(map.data.place, map.data.procedure, by ="Hospital.Name")
  map.data <- unique(map.data[1:5])
  map.data <- na.omit(map.data)
  map.data <- map.data[!grepl("Not Available", map.data$Variable),]
  
  names(zipcode)[1]<-paste("ZIP.Code")
  zipcode$ZIP.Code <- as.numeric(zipcode$ZIP.Code)
  
  map.data <- left_join(map.data, zipcode, by="ZIP.Code")
  
  map.data$Variable <- as.numeric(map.data$Variable)
  
  map.data.summary <- group_by(map.data, State) %>%
              summarise(procedure = sum(Variable)) %>%
              filter(procedure < max.value)
  
  info <- paste0(map.data$State, '<br>', map.data$Variable)
  # give state boundaries a white border
  l <- list(color = toRGB("white"), width = 2)
  # specify some map projection/options
  g <- list(
    scope = 'usa',
    projection = list(type = 'albers usa'),
    showlakes = TRUE,
    lakecolor = toRGB('white')
  )
  
  p <- plot_geo(map.data.summary, locationmode = 'USA-states') %>%
    add_trace(
      z = ~procedure, locations = ~State,
      color = ~procedure, colors = c("yellow","red"), hoverinfo = ~info, colors = 'Purples'
    ) %>%
    layout(
      title = paste0('Number of ', procedure, ' procedures by State*<br>(Hover for breakdown)'),
      geo = g
    ) 
  return(p)
}