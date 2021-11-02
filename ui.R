library(shiny)

fluidPage(

  titlePanel("Module pipelines"),

  sidebarLayout(
    sidebarPanel(
      width = 6,
      append_text_ui("first_name"),
      append_text_ui("second_name"),
      append_text_ui("last_name")
    ),
    mainPanel(
      verbatimTextOutput("fullname")
    )
  )

)
