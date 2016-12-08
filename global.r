
#Load the library we need
library(dplyr)
library(plotly)
library(shiny)
library(zipcode)
library(rsconnect)
library(DT)
library(reshape2)
library(magrittr)

#df1 and df2 are two files that we are using
df1 <- read.csv('data/Survey.csv',stringsAsFactors = FALSE)
df2 <- read.csv('data/Procedures.csv',stringsAsFactors = FALSE)


#In df4, I select the state and the hospital and the state name, which is necessary, since we doesn't need evey data
#Also because we are using this later to combine it with df2, which I have checked, not all the data are matched.
df4 = df1 %>% distinct_(~Hospital.Name,~State,~City)

#df5 is the data frame that joined two sets of data. Our data is a little bit weird since the N/A part is not blank, we can not use the normal mathod to get rid of the N/A part.
#After observation, the N/A part will shown "Not available" in two parts. The first part is in every surgery, and one of the row only shown in the column of "Cardivascular".
# As a result, i can used filter to get rid off the hospital that refused to offered data, in order to let our plots publish succcessfully.
df5 <- left_join(df4,df2,by = "Hospital.Name") %>% filter_(~Gastrointestinal != "Not Available") %>%filter_(~Cardiovascular != "Not Available") %>% 
  select(Hospital.Name,State,City,Gastrointestinal,Eye,Nervous.System,Musculoskeletal,Genitourinary,Skin,Cardiovascular,Respiratory,Other)

#df3 was created for the state level, I grouped it according to states, and selected only the information I need for the bar graph.
df3 <- df5 %>% group_by_(~State) %>% select(State,Gastrointestinal,Eye,Nervous.System,Musculoskeletal,Genitourinary,Skin,Cardiovascular,Respiratory,Other) 
df6 <- df5 %>% group_by_(~City) %>% select(City,Gastrointestinal,Eye,Nervous.System,Musculoskeletal,Genitourinary,Skin,Cardiovascular,Respiratory,Other) 

# These are the datasets used for the map. We needed to re-create these for two reasons.
# First, the data used in the above dataframe differs from what we are plotting on the charts.
# Second, we don't want to reload the data each time, so it needs t
map.data <- as.data.frame(read.csv('data/Procedures.csv', stringsAsFactors = FALSE))
map.data <- left_join(map.data, as.data.frame(read.csv('data/Survey.csv', stringsAsFactors = FALSE)))
