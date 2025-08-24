# h0e7_craft_a_minimal.R

# Security Tool Simulator

# Load required libraries
library(shiny)
library(DT)

# Define UI
ui <- fluidPage(
  titlePanel("Minimal Security Tool Simulator"),
  
  sidebarLayout(
    sidebarPanel(
      textInput("username", "Username:"),
      passwordInput("password", "Password:"),
      actionButton("login", "Login")
    ),
    
    mainPanel(
      DT::dataTableOutput("log")
    )
  )
)

# Define server logic
server <- function(input, output) {
  # Initialize login attempt log
  log <- reactiveValues(attempts = data.frame(time = character(), username = character(), success = logical()))
  
  # Handle login attempts
  observeEvent(input$login, {
    username <- input$username
    password <- input$password
    
    if (username == "admin" && password == "password123") {
      log$attempts <- rbind(log$attempts, data.frame(time = Sys.time(), username = username, success = TRUE))
    } else {
      log$attempts <- rbind(log$attempts, data.frame(time = Sys.time(), username = username, success = FALSE))
    }
  })
  
  # Output login attempt log
  output$log <- DT::renderDataTable({
    log$attempts
  })
}

# Run the application
shinyApp(ui = ui, server = server)