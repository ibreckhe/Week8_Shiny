library(shiny)

##Function we just created.
overfit <- function(n_obs,n_covar,dir="both"){
  response <- rnorm(n_obs,0,10)
  covar_means <- rnorm(n_covar,40,20)
  cov_list <- lapply(covar_means,FUN=function(x){rnorm(n_obs,x,5)})
  covar <- matrix(unlist(cov_list),ncol=n_covar)
  varnames <- paste("X",1:n_covar,sep="")
  colnames(covar) <- varnames
  data <- data.frame(cbind(response,covar))
  cov_terms <- paste(varnames,"*",sep="",collapse="")
  form_text <- paste("response~",cov_terms,sep="")
  form <- formula(substr(form_text, 1, nchar(form_text)-1))
  lm1 <- lm(form,data=data)
  lm2 <- step(lm1,scope=c("response~1",form),trace=0,direction=dir)
  return(print(summary(lm2)))
}
##Communicates with UI
shinyServer(function(input, output) {
  ##Expression "fit" reacts when inputs to function "overfit change"
  fit <- reactive({overfit(input$n_obs,input$n_covar,input$sel_method)})
  ##Renders output
  output$print_fit <- renderPrint(fit())
})
