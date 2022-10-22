#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)

# Define UI for application that draws a histogram
ui <- fluidPage(

    # Application title
    titlePanel("Rootualism"),

    # Sidebar with a slider input for number of bins 
    sidebarLayout(
        sidebarPanel(
          h3("Actions"),
          actionButton("ps", "Photosynthesize!"),
          h4("Grow!"),
          helpText("Shoot Growth:"),
          radioButtons("s_grow", label = "Type:",
                       choices = (c("Grow Taller - 2 Sugar",
                                    "New Leaf (left) - 1 Sugar",
                                    "New Leaf (right) - 1 Sugar"))),
          actionButton("s_grow_but", "Grow!"),
          h4("Rootualize!"),
          actionButton("rhiz", "Trade")
        ),

        # Show a plot of the generated distribution
        mainPanel(
           plotOutput("garden_plot", click = "plot_click")
        )
    )
)

# Define server logic required to draw a histogram
server <- function(input, output) {

  garden <- tibble(tile = factor(rep(c("air", "ground"), each = size)),
                   x = rep(1:5, 8),
                   y = rep(8:1, each = 5))
  
  click_coords <- reactiveValues(xy = tibble(x = c(-1,-1),  y = c(-1,-1)))
  
  observeEvent(input$plot_click, {
    click_coords$xy$x <- round(input$plot_click$x, 0)
    click_coords$xy$y <- round(input$plot_click$y, 0)
  })
  
  
  output$garden_plot <- renderPlot({
    
    ggplot(data = garden) +
      geom_tile(aes(x = x, y = y, fill = tile),
                color = "black", alpha = 0.7) +
      geom_point(data = click_coords$xy, aes(x = x, y = y), size = 8) +
      coord_fixed(xlim = c(0,6), ylim = c(0,9), expand = FALSE) +
      scale_fill_manual(values = c("skyblue", "tan4"), guide = "none") +
      theme_void()
  })

}

# Run the application 
shinyApp(ui = ui, server = server)
