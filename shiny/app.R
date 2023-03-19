library(shiny)
# Load tidyverse package for data importing
library(tidyverse)

# Import the dataset using readr as it is an easy way for importing data 
week8_tbl <- read_csv(file = "../data/week8_tbl.csv")

ui <- fluidPage(

  # Use plotOutput to create a non-interactive plot output 
  plotOutput("fig")
)

server <- function(input, output) {
  output$fig <- renderPlot({
   
  })
}

shinyApp(ui = ui, server = server)
