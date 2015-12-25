##Loading needed packages
packages <- c("dplyr", "leaps", "ggvis", "ggplot2", "shiny","glmulti","car")
sapply(packages, require, character.only = TRUE, quietly = TRUE)
library(dplyr)
library(shiny)
library(GGally)
library(ggplot2)
library(leaps)
library(glmulti)
library(car)
data(mtcars)


# Define server logic for random distribution application
shinyServer(function(input, output) {
  
  data(mtcars)
  
  mtcars$am <- factor(mtcars$am, levels=c(0, 1), labels=c("Automatic", "Manual"))

  
  # Reactive expression to generate the requested distribution.
  
  fit <- reactive({
    SelectFeature <- ""
    SelectFeature <- c( SelectFeature, ifelse( input$cyl, 'I(cyl)', '' ) )
    SelectFeature <- c( SelectFeature, ifelse( input$disp, 'disp', '' ) )
    SelectFeature <- c( SelectFeature, ifelse( input$hp, 'I(hp)', '' ) ) 
    SelectFeature <- c( SelectFeature, ifelse( input$drat, 'drat', '' ) ) 
    SelectFeature <- c( SelectFeature, ifelse( input$wt, 'I(wt)', '' ) )
    SelectFeature <- c( SelectFeature, ifelse( input$qsec, 'qsec', '' ) ) 
    SelectFeature <- c( SelectFeature, ifelse( input$vs, 'vs', '' ) ) 
    SelectFeature <- c( SelectFeature, ifelse( input$gear, 'I(gear)', '' ) ) 
    SelectFeature <- c( SelectFeature, ifelse( input$carb, 'I(carb)', '' ) )
    SelectFeature <- c('am', SelectFeature)
    lm_inputs <- reformulate(termlabels = SelectFeature[SelectFeature!=""], response = 'mpg', intercept = input$intercept )
    lm( lm_inputs, data=mtcars)

  })
  
    ##kable(summary(lm( reformulate(termlabels = SelectFeature_var[SelectFeature_var!=""], response = 'mpg', intercept = input$intercept ), data=mtcars))$coef,  format = 'markdown')
  
  output$plot <- renderPlot({
    par(mfrow=c(2,2))
    plot(fit())
  })
  
  # Generate a formula of the regression
  output$formula <- renderPrint({
    formula(fit())
  })
  
  # Generate a r-adjusted of the regression
  output$RAdj <- renderPrint({
    summary(fit())$adj.r.squared
  })
  

  
  # Generate a r-squared of the regression
  output$RSqr <- renderPrint({
    summary(fit())$r.squared
  })
  # Generate a mean squared error of the regression 
  #output$MSE <- renderPrint({
    #rmse((fit())$residuals)
  #})
  
  # Generate a summary of the regression summary(fit)$r.squared
  output$summary <- renderPrint({
    kable(summary(fit())$coef, format = 'markdown')
  })
  
  # Generate an HTML table view of the data
  output$plot2 <- renderPlot({
    g = ggpairs(mtcars, lower = list(continuous = "smooth"), params = c(method = "loess", colours = "steelblue"))
    g
   })
  
  output$plot3 <- renderPlot({
    influencePlot(fit(), id.method="identify", main="Influence Plot",
                  sub="Circle size is proportional to Cook’s distance")
   })
  
  
  output$plot4 <- renderPlot({
    # Normality of Residuals
    # qq plot for studentized resid
    qqPlot(fit(), main="QQ Plot")
  })
  
  
  output$plot5 <- renderPlot({
    # Evaluate Collinearity
    vif(fit()) # variance inflation factors 
    ##sqrt(vif(fit())) > 2 # problem?
  })
  
  
  output$plot6 <- renderPlot({
    # Evaluate homoscedasticity
    # non-constant error variance test
    ncvTest(fit())
  })
  
  output$plot7 <- renderPlot({
    # Evaluate Nonlinearity
    # component + residual plot 
    crPlots(fit())
  })
  
  # Generate an HTML table view of the data
  output$table2 <- renderDataTable({
    data(mtcars)
    mtcars$am <- as.factor(mtcars$am)
    regsubsets.model <-
      regsubsets(mpg ~ ., data = mtcars, nbest = 1, nvmax = NULL, 
                 force.in = NULL, force.out = NULL,
                 method = "exhaustive")
    summary.model <- summary(regsubsets.model)
    as.data.frame(summary.model$outmat)
  })
  # Generate a summary of the regression
  output$help <- renderPrint({
    help_console(mtcars, "text")
  })
  
})