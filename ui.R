# ui.R
library(shiny)
library(plotly)
library(stringr)
library(dplyr)
library(DT)
shinyUI(navbarPage('Procedures across USA in 2014',
                   # Create a tab panel for your map
                   tabPanel('In-depth data analyzation',
                            titlePanel('analyztion by levels'),
                            # Create sidebar layout
                            sidebarLayout(
                              
                              # Side panel for controls
                              sidebarPanel(
                                
                                # Input to select variable to map
                                selectInput('ycol', 'Type of Surgery',
                                            choices = list("Gastrointestinal surgery" = 'Gastrointestinal', "Eye surgery" = 'Eye',
                                                           "Nervous System surgery"= 'Nervous.System', "Musculoskeletal surgery"= 'Musculoskeletal',
                                                           "Skin surgery" = 'Skin',"Genitourinary surgery" = 'Genitourinary',
                                                           "Cardiovascular surgery" = 'Cardiovascular', "Respiratory surgery" = 'Respiratory',
                                                           "Other kind of surgery" = 'Other'
                                                           ),
                                            selected = "Gastrointestinal"
                                )
                              ),
                              
                              # Main panel: display plotly map
                              mainPanel(
                                plotlyOutput('bubble.state'),DT::dataTableOutput('table1')
                              )
                            )
                          
                   )
                    
))
