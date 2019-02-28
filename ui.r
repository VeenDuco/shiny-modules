# Begin shinyUI -----------------------------------------------------------
# _________________________________________________________________________
tagList(
  tags$noscript(
    style = "color: orange; font-size: 30px; text-align: center;",
    "Please enable JavaScript to use ShinyStan."
  ), 
  shinyjs::useShinyjs(),
  includeCSS("css/ShinyStan.css"),
  
  navbarPage(
    tags$button(
      id = 'save_and_close_button',
      type = "button",
      class = "btn action-button",
      onclick = "window.close();",
      "Close"
    ), 
    id = "nav",
    position = "fixed-top",
    collapsible = TRUE,
    theme = shinythemes::shinytheme("flatly"),
    windowTitle = "ShinyStan",
    
    
    #### HOME ####
    tabPanel(
      title = strong(style = "color: #B2011D;", "ShinyStan"),
      value = "home",
      homepageUI("homepage")
    ),
    
    #### DIAGNOSE ####
    tabPanel(
      title = "Diagnose",
      icon = icon("medkit"),
      diagnoseUI("diagnoseHomepage")
      # source_ui("PAGE_diagnose.R")
    ),
    
    #### ESTIMATE ####
    tabPanel(
      title = "Estimate",
      icon = icon("stats", lib = "glyphicon"),
      estimateUI("estimateHomepage")
      # withMathJax()
      # source_ui("PAGE_estimate.R")
    ),
    
    #### EXPLORE ####
    tabPanel(
      title = "Explore",
      icon = icon("eye-open", lib = "glyphicon")
      # source_ui("PAGE_explore.R")
    )
    
    #### More ####
    # source_ui("PAGE_more_menu.R")
    
  ) # End navbarPage
) # End tagList

# End shinyUI -------------------------------------------------------------
# -------------------------------------------------------------------------
