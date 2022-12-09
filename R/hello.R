devtools::install_github("jdtrat/shinymarkdown")

library(shiny)
library(shinymarkdown)
ui <- fluidPage(
  shinymarkdown::mdInput(inputId = "investment_case", height = "500px", initial_edit_type = "wysiwyg",hide_mode_switch = TRUE),
  downloadButton("download_pdf", label = NULL,icon = shiny::icon("download"))
)

server <- function(input, output, session) {



  output$download_pdf <- downloadHandler(
    filename = function(){
      "this is a demo.html"
    },
    content = function(file) {

      outputList <- reactiveValuesToList(input)
      print(outputList)

      rmarkdown::render(input       = "demo.Rmd",
                        output_file = file,
                        params      = outputList)

    }
  )

}

shinyApp(ui, server)
