library(shiny)
library(HistData)
library(dplyr)
library(ggplot2)

data(GaltonFamilies)

gf <- GaltonFamilies

model1 <- lm(childHeight ~ father + mother + gender, data=gf)

shinyServer(function(input, output) {
   output$pText <- renderText({
      paste("If father's height is", strong(round(input$inFh, 2)),
            "inches, and mother's height is", strong(round(input$inMh, 2)),
            "inches, then:")
      })
      output$pred <- renderText({
            df <- data.frame(father=input$inFh,
                             mother=input$inMh,
                             gender=factor(input$inGen, levels=levels(gf$gender)))
            ch <- predict(model1, newdata=df)
            kid <- ifelse(input$inGen=="female", "daugther", "son")
            paste0(em(kid), "'s predicted height is around ",
                   strong(round(ch)), " inches.")
      })
      output$Plot <- renderPlot({
            kid <- ifelse(input$inGen=="female", "daugther", "son")
            df <- data.frame(father=input$inFh,
                             mother=input$inMh,
                             gender=factor(input$inGen, levels=levels(gf$gender)))
            ch <- predict(model1, newdata=df)
            yvals <- c("father", kid, "mother")
            df <- data.frame(x = factor(yvals, levels = yvals, ordered = TRUE),
                             y = c(input$inFh, ch, input$inMh))
            ggplot(df,
                   aes(x,
                       y,
                       color = c("red", "green", "blue"),
                       fill = c("red", "green", "blue"))) +
               geom_bar(stat="identity", width = 0.5) +
               xlab("") +
               ylab("height (inches)") +
               theme_minimal() +
               theme(legend.position="none")
      })
})