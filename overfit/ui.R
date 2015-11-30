library(shiny)
shinyUI(pageWithSidebar(
  headerPanel("Overfitting"),
  sidebarPanel(
    numericInput("n_obs", "Number of Random Observations:", 
                min=1,max=500,value=50),
    sliderInput("n_covar", "Number of Random Covariates:", 
                min=1,max=5,value=4),
    selectInput("sel_method", "Model Selection Direction", 
                choices = c("backward", "both"),
                selected="both"),
    helpText("Remember von Neumann!"),
    img(src="http://upload.wikimedia.org/wikipedia/commons/5/5e/JohnvonNeumann-LosAlamos.gif",
        width=150)),
  mainPanel(
    h4("Step-wise selected best model:"),
    verbatimTextOutput("print_fit"))
))
