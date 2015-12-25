
library(shiny)

# Define UI for random distribution application 
shinyUI (pageWithSidebar(  
  # Application title
  mainPanel(""),
  
  sidebarPanel(
    p("Select additional variables to use in the regression model:"),
    checkboxInput('intercept', 'Intercept', TRUE),
    checkboxInput('cyl', 'Number of cylinders', FALSE),
    checkboxInput('disp', 'Displacement (cu.in.)', FALSE),
    checkboxInput('hp', 'Gross horsepower', FALSE),
    checkboxInput('drat', 'Rear axle ratio', FALSE),
    checkboxInput('wt', 'Weight (lb/1000)', FALSE),
    checkboxInput('qsec', '1/4 mile time', FALSE),
    checkboxInput('vs', 'V/S', FALSE),
    checkboxInput('gear', 'Number of forward gears', FALSE),
    checkboxInput('carb', 'Number of carburetors', FALSE)
    #actionButton(inputId = "clear_all", label = "Clear selection", icon = icon("check-square")),
    #actionButton(inputId = "select_all", label = "Select all", icon = icon("check-square-o"))
  ),
  

  mainPanel(navbarPage("My Application",
               tabPanel("Regression Formula", 
                        br(),
                        "The regression model:",
                        verbatimTextOutput("formula"),
                        br(),
               #"For this model the Root Mean Squared Error is:", verbatimTextOutput("MSE"),
               "For this model the R-Adjusted is:", verbatimTextOutput("RAdj"),
               "For this model the R-Squared is:", verbatimTextOutput("RSqr")),
               tabPanel("Variable importance", dataTableOutput("table2")),
               tabPanel("Correlation Table", plotOutput("plot2")),
               tabPanel("Regression Summary", verbatimTextOutput("summary")),
               navbarMenu("Regression Diagnostics",
                          tabPanel("Residual Plot", plotOutput("plot")),
                          tabPanel("Unusual Observations", plotOutput("plot3")),
                          tabPanel("Non-normality", plotOutput("plot4")),
                          tabPanel("Multi-collinearity", plotOutput("plot5")),
                          tabPanel("Non-constant Error Variance", plotOutput("plot6")),
                          tabPanel("Nonlinearity", plotOutput("plot7")))
  
    )
  )
))