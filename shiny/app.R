# Load required packages 
library(shiny)
library(tidyverse)

ui <- fluidPage(
  
  # Application title
  titlePanel("PSY 8960 Week 8 Shiny Project"),
  
  # Sidebar with a select input for number of bins 
  sidebarLayout(
    sidebarPanel(
      selectInput("gender", "Select gender if you only want to see one gender's data",
                  selected = "All", choices = c("Male", "Female", "All")),
      selectInput("errorband", "Select display or suppress error band", 
                  selected = "Display Error Band", choices = c("Display Error Band",
                                                               "Suppress Error Band")),
      selectInput("completetime", "Select include or exclude participants who completed assessments before Aug. 1, 2017",
                  selected = "Include", choices = c("Include", "Exclude"))
    ),
    
    # Show a plot of the generated distribution
    mainPanel(
      # Use plotOutput to create a non-interactive plot output 
      plotOutput("fig")
    )
  )
)
