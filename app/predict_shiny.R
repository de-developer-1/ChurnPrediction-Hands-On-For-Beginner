library(shiny)
library(xgboost)
library(data.table)

model <- xgb.load("app/xgb_churn.model")
dummies <- readRDS("app/preproc.rds")

ui <- fluidPage(
  titlePanel("Churn Prediction Dashboard"),
  sidebarLayout(
    sidebarPanel(
      textInput("tenure", "Tenure (months):", "12"),
      selectInput("Contract", "Contract Type:", choices = c("Month-to-month", "One year", "Two year")),
      actionButton("predictBtn", "Predict")
    ),
    mainPanel(
      h3("Prediction Result"),
      verbatimTextOutput("result")
    )
  )
)

server <- function(input, output) {
  observeEvent(input$predictBtn, {
    newdata <- data.frame(
      tenure = as.numeric(input$tenure),
      Contract = input$Contract,
      stringsAsFactors = FALSE
    )

    newdata_prep <- predict(dummies, newdata = newdata)
    pred <- predict(model, as.matrix(newdata_prep))

    output$result <- renderPrint({
      paste("Churn Probability:", round(pred, 4))
    })
  })
}

shinyApp(ui = ui, server = server)