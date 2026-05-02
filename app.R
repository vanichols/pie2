library(shiny)
library(bslib)
library(praise)
library(cowsay)
library(randomNames)

#rsconnect::writeManifest()

ui <- page_sidebar(
  title = "Strange Libraries Test App",
  sidebar = sidebar(
    actionButton("generate", "Generate Random Content", class = "btn-primary"),
    hr(),
    selectInput(
      "animal",
      "Choose an animal:",
      choices = c("cat", "cow", "chicken", "frog", "pig", "rabbit")
    ),
    checkboxInput("show_praise", "Show praise message", value = TRUE)
  ),
  card(
    card_header("Random Person"),
    verbatimTextOutput("random_name")
  ),
  card(
    card_header("Animal Says..."),
    verbatimTextOutput("cowsay_output")
  ),
  card(
    card_header("Motivation Corner"),
    uiOutput("praise_output")
  )
)

server <- function(input, output, session) {
  
  # Generate a random name
  output$random_name <- renderText({
    input$generate
    randomNames(1, which.names = "both")
  })
  
  # Generate cowsay output
  output$cowsay_output <- renderText({
    input$generate
    message <- paste("Hello! Random number:", round(runif(1, 1, 100)))
    say(message, by = input$animal)
  })
  
  # Generate praise
  output$praise_output <- renderUI({
    if (input$show_praise) {
      input$generate
      tagList(
        h4(praise()),
        p(praise("You are ${adjective}! Your work is ${adjective}!"))
      )
    } else {
      p("Enable praise to see motivational messages!")
    }
  })
}

shinyApp(ui, server)
