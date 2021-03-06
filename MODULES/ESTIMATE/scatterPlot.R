scatterPlotUI <- function(id){
  ns <- NS(id)
  tagList(
    wellPanel(
      fluidRow(
        column(width = 3),
        column(width = 4, h5("Parameter")),
        column(width = 4, h5("Transformation"))
      ),
      fluidRow(
        column(width = 3),
        column(
          width = 4,
          selectizeInput(
            inputId = ns("diagnostic_param"),
            label = NULL,
            multiple = TRUE,
            choices = sso@param_names,
            selected = c(sso@param_names[1],sso@param_names[which(sso@param_names == "log-posterior")]),
            options = list(maxItems = 2)
          )
        ),
        column(
          width = 4,
          uiOutput(ns("transform"))
        )
      )
    ),
    plotOutput(ns("plot1"))
  )
}


scatterPlot <- function(input, output, session){
  
  param <- reactive(input$diagnostic_param)
  
  output$transform <- renderUI({
    
    validate(
      need(length(param()) == 2, "Select two parameters.")
    )
    inverse <- function(x) 1/x
    cloglog <- function(x) log(-log1p(-x))
    square <- function(x) x^2
    
    transformation_choices <- c(
      "abs", "atanh",
      cauchit = "pcauchy", "cloglog",
      "exp", "expm1",
      "identity", "inverse", inv_logit = "plogis",
      "log", "log10", "log2", "log1p", logit = "qlogis",
      probit = "pnorm", "square", "sqrt"
    )
    fluidRow(
      selectInput(
        inputId = session$ns("transformation"),
        label = NULL,
        choices = transformation_choices,
        selected = "identity"
      ),
      selectInput(
        inputId = session$ns("transformation2"),
        label = NULL,
        choices = transformation_choices,
        selected = "identity"
      )
    )
  })
  
  transform1 <- reactive({input$transformation})
  transform2 <- reactive({input$transformation2})
  
  transform <- reactive({
    out <- list(transform1(), transform2())
    names(out) <- c(param())
    out
  })
  
  
  
  output$plot1 <- renderPlot({
    
    color_scheme_set("darkgray")
    validate(
      need(length(param()) == 2, "Select two parameters.")
    )
    mcmc_scatter(
      sso@posterior_sample[(1 + sso@n_warmup) : sso@n_iter, , ],
      pars = param(),
      transformations = transform()
    )
  })
}