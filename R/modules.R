append_text_ui <- function(id) {
  ns <- NS(id)

  tagList(
    fluidRow(
      column(
        width = 6,
        verbatimTextOutput(ns("text"))
      ),
      column(
        width = 6,
        textInput(ns("text_append"), label = NULL)
      )
    )
  )
}

append_text_server <- function(user_text, id) {

  moduleServer(
    id = id,
    module = function(input, output, session) {

      output$text <- renderText({
        text_out()
      })

      text_out <- reactive({
        paste(user_text(), input$text_append)
      })

      return(text_out)

    }
  )

}

