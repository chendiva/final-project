# ui.R
library(shinythemes)
library(shiny)
library(plotly)
library(stringr)
library(dplyr)
library(DT)
library(zipcode)
#This setting for taglist is used to make the theme of the internet
ui = tagList(
  shinythemes::themeSelector(),
  navbarPage(
    theme = "slate",        
    'Procedures across USA in 2014',
    tabPanel('Home',
             titlePanel("USA Outpatient Procedures in 2014"),
             h3("About the Project"),
             p("Our (INFO 201) project is based off a 2014 dataset of hospital names in the US with the aggregate count of selected outpatient procedures 
               performed within the outpatient department."),
             p("Outpatient proceures are defined as surgeries who are performed within the same day the patient is released from the hospital."),
             br(),
             p("Given this data, we are able to visually contruct different types of graphs and plots that allow us to see trends and correlations between specific hospital areas and illnesses."),
             p("Questions our data answers are: "),
             p(strong("1. What types of illnesses are most prevalent at the state level? (State Level Analyzation)")),
             p("Most Performed Surguries (State Level)"),
             p("Eye: California (~108.922k)"),
             p("Cardiovasular: Illonis (~163.946k)"),
             p("Nervous: Ohio (~207.384k)"),
             p("Respiratory: PA (~52.58k)"),
             p(strong("2. What type of procedures does each hospital have the most experience towards performing? (Hospital level analyzation)")),
             p(strong("University of Washington Medical Center")),
             p("Skin - 31.7% (8353 surguries)"),
             p("Gastrointestinal - 32.6% (8603 surguries)"),
             p("Musculoskeletal - 11.8% (3108 surguries)"),
             p("Genitourinary - 9.29% (2450 surguries)"),
             p("Cardiovascular - 4.51% (1189 surguries)"),
             p("Resiratory 3.96% (1045 surguries"),
             p("Nervous System - 3.82 (1009 surguries)"),
             p("Other - 2.28% (601 surguries"),
             strong("3. What is the proportion of the types of surgeries in comparison to one another? (Compare 2 Hospitals)"),
             p("Example: Comparing Nervous System and Gastrointestinal for Washington"),
             p("Nervous: 35.936k (pink) - Gastrointestinal 107.152k (blue) - About three times as many Gastrintestinal surguries as nervous system surguries"),
             br(),
             p("This data is collected by Centers for Medicare & Medicaid Services used on the Medicare.gov Compare Websites and Directories. The dataset for outpatient procedures in specific hospitals can be found",
               a("here", 
                 href = "https://data.medicare.gov/Hospital-Compare/Outpatient-Procedures-Volume/xbz4-gvaz"),
               "and the dataset for overall patient hospital data can be found ",
               a("here.", 
                 href = "https://data.medicare.gov/Hospital-Compare/Patient-survey-HCAHPS-Hospital/dgck-syfz"))
             ),
                   # Create a tab panel for your charts
                   tabPanel('State level analyzation',
                            titlePanel('Analyztion of different kind of procedures in state level'),
                            # Create sidebar layout for the in-depth analyzation from state level.
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
                         
    
                   tabPanel('Hospital level analyzation',
                            titlePanel('Analyztion of various procedures in the hospital level'),
                            # Create sidebar layout for the in-depth analyzation from hospital level.
                            sidebarLayout(
                              
                              # Side panel for controls
                              sidebarPanel(
                                
                                # Input to select variable to chats
                                #In the hospital level, there are two ways to compare, the bubble chart offers you a way to compare certain surgery among all the hospitals that offered their statistics.
                                
                                selectInput('ycol', 'Type of Surgery for hospital level',
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
                            
                                plotlyOutput('bubble')
                              )
                            )
                            
                   ),
                   tabPanel('Search a hospital',
                            titlePanel('Search specific hospital data'),
                            # Create sidebar layout for the hopital that the user want to look at.
                            sidebarLayout(
                              
                              # Side panel for controls
                              sidebarPanel(
                                
                               # Input to select variable to chats
                               #The pie chart based on the hospital level offer you a choice of hospital you want to look into, and show the proportion of the procedures that the hospital had conducted.
                               #A table contains the hospital name, state, and procedures' numbers 
                                
                                selectInput('ycol3', 'Hopital choice',
                                            choices = df2$Hospital.Name ,              
                                            
                                            selected = "CROSSROADS COMMUNITY HOSPITAL")
                              
                              ),
                              
                              # Main panel: display plotly charts and a table that you can search for a certain hospital's information about surgery.
                              mainPanel(
                                plotlyOutput('pie.hospital'),DT::dataTableOutput('table1')
                                
                                
                                
                              )
                            )
                            
                   ), 
                  tabPanel('Procedures by State (Map)',
                   titlePanel('Map representation of the Number of Procedures by State'),
                   # Create sidebar layout for the in-depth analyzation by state level.
                   sidebarLayout(
                     
                     # Side panel for controls
                     sidebarPanel(
                       
                       # Input to select variable to chats
                       
                       selectInput('map.variable', 'Type of Procedure',
                                   choices = list("Gastrointestinal surgery" = 'Gastrointestinal', "Eye surgery" = 'Eye',
                                                  "Nervous System surgery"= 'Nervous.System', "Musculoskeletal surgery"= 'Musculoskeletal',
                                                  "Skin surgery" = 'Skin',"Genitourinary surgery" = 'Genitourinary',
                                                  "Cardiovascular surgery" = 'Cardiovascular', "Respiratory surgery" = 'Respiratory',
                                                  "Other kind of surgery" = 'Other'
                                   ),
                                   selected = "Gastrointestinal"
                       ),
                       
                       sliderInput("display",
                                   "Only display states with # of procedures less than:",
                                   min = 0,  max = 600000,  value = 250000)
                      ), 
                     
                     # Main panel: display plotly charts and a table that you can search for a certain hospital's information about surgery.
                     mainPanel(
                       
                       plotlyOutput('map'),
                       
                       h5("*Data from Tennessee not available for some displays", align = "center")
                     )
                   )
             
                   
    )
  ,
  tabPanel("Compare Two Surgeries",
           titlePanel('Compare Surgeries By State'),
           
    sidebarLayout(
      sidebarPanel(
        titlePanel('Please Select Two Surgeries to Compare'),
        selectInput('select', label = 'Surgery 1',
                    choices = list('Gastrointestinal' = 'Gastrointestinal', 'Eye' = 'Eye', 'Nervous System' = 'Nervous.System', 
                                   'Musculoskeletal' = 'Musculoskeletal', 'Skin' = 'Skin', 'Genitourinary' = 'Genitourinary',
                                   'Cardiovascular' = 'Cardiovascular', 'Respiratory' = 'Respiratory',
                                   'Other' = 'Other')),
        selectInput('select1', label = 'Surgery 2', 
                    choices = list('Gastrointestinal' = 'Gastrointestinal', 'Eye' = 'Eye', 'Nervous System' = 'Nervous.System', 
                                   'Musculoskeletal' = 'Musculoskeletal', 'Skin' = 'Skin', 'Genitourinary' = 'Genitourinary',
                                   'Cardiovascular' = 'Cardiovascular', 'Respiratory' = 'Respiratory',
                                   'Other' = 'Other'))
      ),
      
      mainPanel(
        # Plot the output with the name "scatter"
        plotlyOutput('scatter'),
        p("When a patient is looking into getting two kinds of surgeries, this tool can help the patient get a 
          general sense of how often the two surgeries occur in each state. The patient would want to do their
          surgeries in states with hospitals that have good experience with both types of surgeries")
      )
    )
  ))
)
