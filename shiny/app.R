# Load required packages 
library(shiny)
library(tidyverse)

# Define UI for application that generates a plot based on user selection input
ui <- fluidPage(
  
  # Application title & author name
  titlePanel("PSY 8960 Week 8 Shiny Project: Joy Zhou"),
  
  # Sidebar with the select inputs
  sidebarLayout(
    #Set select inputs to be in the sidebar
    sidebarPanel(
      #Set up selectInput for gender, errorband, and competion time to allow users to filter their data based on their selections
      selectInput("gender", "Select gender if you only want to see one gender's data",
                  selected = "All", choices = c("Male", "Female", "All")),
      selectInput("errorband", "Select display or suppress error band", 
                  selected = "Display Error Band", choices = c("Display Error Band",
                                                               "Suppress Error Band")),
      selectInput("completetime", "Select include or exclude participants who completed assessments before Aug. 1, 2017",
                  selected = "Include", choices = c("Include", "Exclude"))
    ),
    
    # Show the generated scatterplot in the main panel
    mainPanel(
      # Use plotOutput to create a non-interactive plot output 
      plotOutput("fig")
    )
  )
)

# Define server logic required to generate the plot
server <- function(input, output) {
  output$fig <- renderPlot({
    # Import the saved RDS dataset that is appropriate for shiny, did not need to specify path as the current wd is the same as the wd of app.R
    week8_tbl <- read_rds('./week8.rds')
    
    # Filter the dataset based on users' selections of the gender input
    if (input$gender != "All"){
      week8_tbl <- week8_tbl %>%
        filter(gender == input$gender)} 
    
    # Filter the dataset based on users' selections of the completion time input
    if (input$completetime == "Exclude"){
      week8_tbl <- week8_tbl %>% 
        filter(timeEnd > "2017-08-01")} 
    
    # Generate and edit the plot based on users' selections of the error band input and the dataset that is (un)filtered from previous selections
    if (input$errorband == "Suppress Error Band"){
      week8_tbl %>%
        ggplot(aes(q1_q6_mean, q8_q10_mean)) +
        geom_point(position = "jitter") +
        geom_smooth(method = "lm", color = "purple", se = F) +
        labs(x = "Mean scores of q1 to q6", y = "Mean scores of q8 to q10")} 
    # Generate am original, full sample plot if all the inputs are kept to the default 
    else {week8_tbl %>%
        ggplot(aes(q1_q6_mean, q8_q10_mean)) +
        geom_point(position = "jitter") +
        geom_smooth(method = "lm", color = "purple") +
        labs(x = "Mean scores of q1 to q6", y = "Mean scores of q8 to q10", 
             title = "Correlation Between q1 to q6 Mean Scores and q8 to q10 Mean Scores") +
        theme(plot.title = element_text(hjust = 0.5))
      }          
  })
}

# Run the application 
shinyApp(ui = ui, server = server)

# Load library for deploying app
#library(rsconenct)

# Deploy and name the app 
# rsconnect::deployApp(appName = "shinny_week8")


