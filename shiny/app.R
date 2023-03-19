library(shiny)
# Load tidyverse package for data importing
library(tidyverse)
week8_tbl <- readRDS("../shiny/week8_tbl.Rds")
ui <- fluidPage(
  selectInput("gender", "Select gender if you only want to see one gender's data",
              selected = "All", choices = c("Male", "Female", "All")),
  selectInput("errorband", "Select display or suppress error band", 
              selected = "Display Error Band", choices = c("Display Error Band",
                                                           "Suppress Error Band")),
  selectInput("completetime", "Select include or exclude participants who completed assessments before Aug. 1, 2017",
              selected = "Include", choices = c("Include", "Exclude")),
  # Use plotOutput to create a non-interactive plot output 
  plotOutput("fig")
)

server <- function(input, output) {
  output$fig <- renderPlot({
    if (input$completetime == "Include"){
      if (input$errorband == "Display Error Band"){
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
        }} else {
          if (input$gender == "All") {
            week8_tbl %>%
              ggplot(aes(q1_q6_mean, q8_q10_mean)) +
              geom_point(position = "jitter") +
              geom_smooth(method = "lm", color = "purple", se = F)
          } else {
            week8_tbl %>%
              filter(gender == input$gender) %>%
              ggplot(aes(q1_q6_mean, q8_q10_mean)) +
              geom_point(position = "jitter") +
              geom_smooth(method = "lm", color = "purple", se = F)
          }}} else {
            if (input$errorband == "Display Error Band"){
              if (input$gender == "All") {
                week8_tbl %>%
                  filter(timeEnd > "2017-08-01") %>%
                  ggplot(aes(q1_q6_mean, q8_q10_mean)) +
                  geom_point(position = "jitter") +
                  geom_smooth(method = "lm", color = "purple")
              } else {
                week8_tbl %>%
                  filter(timeEnd > "2017-08-01") %>%
                  filter(gender == input$gender) %>%
                  ggplot(aes(q1_q6_mean, q8_q10_mean)) +
                  geom_point(position = "jitter") +
                  geom_smooth(method = "lm", color = "purple") 
              }} else {
                if (input$gender == "All") {
                  week8_tbl %>%
                    filter(timeEnd > "2017-08-01") %>%
                    ggplot(aes(q1_q6_mean, q8_q10_mean)) +
                    geom_point(position = "jitter") +
                    geom_smooth(method = "lm", color = "purple", se = F)
                } else {
                  week8_tbl %>%
                    filter(timeEnd > "2017-08-01") %>%
                    filter(gender == input$gender) %>%
                    ggplot(aes(q1_q6_mean, q8_q10_mean)) +
                    geom_point(position = "jitter") +
                    geom_smooth(method = "lm", color = "purple", se = F)
                }}}
  })
}

shinyApp(ui = ui, server = server)

library(rsconnect)
rsconnect::setAccountInfo(name='joyzhou', 
                          token='2590A8DB5F2C12C2946B93E305228F9D', 
                          secret='Fr2jmw3fmOMtVIOpKGiVsENgS+9a0TTG/dOe+ll9')

rsconnect::deployApp(appName = "shiny_week8", appDir = "../shiny")


