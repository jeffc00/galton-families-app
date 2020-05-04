library(shiny)

shinyUI(
  fluidPage(
    titlePanel("Prediction of Height"),
      sidebarLayout(
        sidebarPanel(
          helpText("Prediction of the child's height given gender and parents' heights."),
          helpText("Parameters:"),
          sliderInput(inputId = "inFh",
                      label = "father's height (inches):",
                      value = 70,
                      min = 60,
                      max = 80,
                      step = 1),
          sliderInput(inputId = "inMh",
                      label = "mother's height (inches):",
                      value = 70,
                      min = 60,
                      max = 80,
                      step = 1),
          radioButtons(inputId = "inGen",
                       label = "child's gender: ",
                       choices = c("female" = "female", "male" = "male"),
                       inline = TRUE)
          ),
        mainPanel(
          htmlOutput("pText"),
          htmlOutput("pred"),
          plotOutput("Plot", width = "50%")
          )
        )
    )
)