#4uzd
library(ggplot2)
library(dplyr)
library(readr)
library(shiny)

duom <- read_csv("D:/Emilija/Desktop/R/Laboratorinis2/laboratorinis/data/lab_sodra.csv")
duom <- duom[duom$ecoActCode == "522920",]

web <- fluidPage(
  titlePanel("Krovini� gabenimo agent� ir ekspeditori� veikla"),
  sidebarLayout(
    sidebarPanel(
      selectInput("imoniukodai", label = "�veskite �mon�s kod�", choices = unique(duom$code)),
    ),
    mainPanel(
      plotOutput("atlyginimai"),
      tableOutput("table")
    )
  ))

server <- function(input, output, session){
  dmn <- reactive({
    req(input$imoniukodai)
    df <- duom %>% filter(code %in% input$imoniukodai)
  })
  
  output$atlyginimai <- renderPlot({
    g <- ggplot(dmn(), aes(x = month, y = avgWage, group = name, color = name))
    g + geom_line()
  })
  
  output$table <- renderTable(dmn())
}

shinyApp(web, server)
