# ui.R
library(shiny)
library(plotly)
library(stringr)
library(dplyr)
library(DT)
shinyUI(navbarPage('Procedures across USA in 2014',
                   # Create a tab panel for your charts
                   tabPanel('State level analyzation',
                            titlePanel('Analyztion of different kind of procedures in state level'),
                            # Create sidebar layout for the in-depth analyzation from different levels.
                            sidebarLayout(
                              
                              # Side panel for controls
                              sidebarPanel(
                                
                                # Input to select variable to chats
                                #In the state level, you choose the surgery you want to compare among all the states that are information available(Some hospital refused to offer their statistics)
                                
                                selectInput('ycol2', 'Type of Surgery for State level',
                                            choices = list("Gastrointestinal surgery" = 'Gastrointestinal', "Eye surgery" = 'Eye',
                                                           "Nervous System surgery"= 'Nervous.System', "Musculoskeletal surgery"= 'Musculoskeletal',
                                                           "Skin surgery" = 'Skin',"Genitourinary surgery" = 'Genitourinary',
                                                           "Cardiovascular surgery" = 'Cardiovascular', "Respiratory surgery" = 'Respiratory',
                                                           "Other kind of surgery" = 'Other'
                                            ),
                                            selected = "Gastrointestinal"
                                )
                              ),
                              
                              # Main panel: display plotly charts and a table that you can search for a certain hospital's information about surgery.
                              mainPanel(
                                plotlyOutput('bar.state')
                                
                              )
                            )
                          
                   ),
                   
                   tabPanel('Hopital level analyzation',
                            titlePanel('Analyztion of various procedures in the hospital level'),
                            # Create sidebar layout for the in-depth analyzation from different levels.
                            sidebarLayout(
                              
                              # Side panel for controls
                              sidebarPanel(
                                
                                # Input to select variable to chats
                                #In the hospital level, there are two ways to compare, the bubble chart offers you a way to compare certain surgery among all the hospitals that offered their statistics.
                                #The pie chart based on the hospital level offer you a choice of hospital you want to look into, and show the proportion of the procedures that the hospital had conducted.
                      
                                selectInput('ycol', 'Type of Surgery for hospital level',
                                            choices = list("Gastrointestinal surgery" = 'Gastrointestinal', "Eye surgery" = 'Eye',
                                                           "Nervous System surgery"= 'Nervous.System', "Musculoskeletal surgery"= 'Musculoskeletal',
                                                           "Skin surgery" = 'Skin',"Genitourinary surgery" = 'Genitourinary',
                                                           "Cardiovascular surgery" = 'Cardiovascular', "Respiratory surgery" = 'Respiratory',
                                                           "Other kind of surgery" = 'Other'
                                            ),
                                            selected = "Gastrointestinal"
                                ),
                                selectInput('ycol3', 'Hopital choice',
                                            choices = df2$Hospital.Name ,              
                                            
                                            selected = "CROSSROADS COMMUNITY HOSPITAL")
                              ),
                              
                              # Main panel: display plotly charts and a table that you can search for a certain hospital's information about surgery.
                              mainPanel(
                                
                                plotlyOutput('bubble'),DT::dataTableOutput('table1'),
                                plotlyOutput('pie.hospital')
                              )
                            )
                            
                   )
                   
))
