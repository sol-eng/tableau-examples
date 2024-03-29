# filetype: shinyApp

library(shiny)
library(shinytableau)
library(promises)
library(shinyvalidate)
library(ggplot2)

manifest <- tableau_manifest_from_yaml()

ui <- function(req) {
  fillPage(theme = shinytableau_theme(),
           plotOutput("plot", height = "100%")
  )
}

server <- function(input, output, session) {
  df <- reactive_tableau_data("data_spec",
                              options = list(includeAllColumns = TRUE)
  )

  output$plot <- renderPlot({
    xvar <- tableau_setting("xvar")

    df() %...>% {
      ggplot(., aes(x = !!as.symbol(xvar))) +
        geom_density() +
        theme_void() +
        coord_flip()
    }
  })
}

config_ui <- function(req) {
  sidebarLayout(
    sidebarPanel(
      choose_data_ui("data", "Choose data"),
      uiOutput("var_selection_ui")
    ),
    mainPanel(
      tableOutput("preview")
    )
  )
}

config_server <- function(input, output, session, iv) {
  iv$add_rule("xvar", sv_required())

  data_spec <- choose_data("data", iv = iv)


  data <- reactive_tableau_data(data_spec,
                                options = list(includeAllColumns = TRUE, maxRows = 5)
  )

  output$preview <- renderTable({
    data()
  })


  schema <- reactive_tableau_schema(data_spec)

  output$var_selection_ui <- renderUI({
    vars <- schema()$columns$fieldName
    tagList(
      selectInput("xvar", "Dimension", vars)
    )
  })


  save_settings <- function() {
    update_tableau_settings_async(
      data_spec = data_spec(),
      xvar = input$xvar
    )
  }
  return(save_settings)
}

tableau_extension(
  manifest, ui, server, config_ui, config_server,
  options = ext_options(config_width = 900, config_height = 600, port = 2468)
)
