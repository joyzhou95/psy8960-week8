library(shiny)
# Load tidyverse package for data importing
library(tidyverse)

# Import the dataset using readr as it is an easy way for importing data 
week8_tbl <- read_csv(file = "../data/week8_tbl.csv")

ui <- fluidPage(
  selectInput("gender", "Select gender if you only want to see one gender's data",
              selected = "All", choices = c("Male", "Female", "All")),
  # Use plotOutput to create a non-interactive plot output 
  plotOutput("fig")
)

server <- function(input, output) {
  output$fig <- renderPlot({
    if (input$gender == "All") {
      week8_tbl %>%
        ggplot(aes(q1_q6_mean, q8_q10_mean)) +
        geom_point(position = "jitter") +
        geom_smooth(method = "lm", color = "purple")
    } else {
      week8_tbl %>%
        filter(gender == input$gender) %>%
        ggplot(aes(q1_q6_mean, q8_q10_mean)) +
        geom_point(position = "jitter") +
        geom_smooth(method = "lm", color = "purple") 
  }
 })
}

shinyApp(ui = ui, server = server)
