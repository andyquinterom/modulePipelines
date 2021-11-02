library(shiny)
library(pipeR)

function(input, output, session) {

  initial_text <- reactive({
    "My name is:"
  })

  name_text <- initial_text %>>%
    append_text_server(id = "first_name") %>>%
    append_text_server(id = "second_name") %>>%
    append_text_server(id = "last_name")

}
