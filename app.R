# Load libraries
library(shiny)
library(glue)
library(bslib)

# Set theme
theme <- bs_theme(version = 5)
theme <- bs_theme_update(theme = theme, primary = "#B77729")

# Declare utility functions
fmt_numb_steps <- function(steps){
  sprintf("%d. %s.", 1:length(steps), steps)
}

# Define UI
ui <- page_fluid(
  theme = theme,
  titlePanel("Sam's Chai (Indian tea) recipe calculator"),
  verbatimTextOutput("message", ),
  sidebarLayout(
    sidebarPanel(
      sliderInput("cups", "Number of Cups", 2, min = 2, max = 8, step = 2),
    ),
    mainPanel(
      card(
        full_screen = TRUE,
        strong("Ingredients"),
        verbatimTextOutput("ingredients"),
      ),
      card(
        full_screen = TRUE,
        strong("Directions"),
        verbatimTextOutput("directions")
      )
    )
  )
)

# Define server logic
server <- function(input, output) {
  # Message output
  output$message <- renderPrint({
    glue(
      "Welcome to my Chai recipe calculator!",
      "Two people usually drink a cup each.",
      .sep = "\n"
    )
  })
  # Ingredients output
  output$ingredients <- renderPrint({
    cups <- input$cups
    water <- 1/2 * cups # 0.5 cups of water per cup of tea
    milk <- 1/2 * cups # 0.5 cups of milk per cup of tea
    tea_leaves <- 2/2 * cups # 1 teaspoons of tea leaves per cup of tea
    sugar <- 1/2 * cups # 0.5 tablespoons of sugar per cup of tea
    ginger <- 1/2 * cups # 0.5 teaspoons of ginger per cup of tea
    cardamom <- 1 * cups # 1 cardamom per cup of tea
    cinnamon <- 1/2 * cups # 0.5 teaspoons of cinnamon per cup of tea

    ingredients <- glue(
      "{water} cup of water",
      "{milk} cup of milk",
      "{tea_leaves} teaspoon(s) of tea leaves or tea powder",
      "{sugar} tablespoon(s) of sugar",
      "{ginger} teaspoon(s) of ginger",
      "{cinnamon} teaspoon(s) of cinnamon (optional)",
      .sep = "\n"
    )
    return(ingredients)
  })

  # Directions output
  output$directions <- renderText({
    steps <- c(
      "Boil water",
      "Add tea leaves, ginger, and cardamom",
      "Boil for about 2 minutes",
      "Add milk and sugar",
      "Boil for about 5-7 minutes",
      "Strain the tea into cups and enjoy"
    )
    directions <- paste0(
      fmt_numb_steps(steps),
      collapse = "\n"
    )
    return(directions)
  })

}

# Run app
shinyApp(ui = ui, server = server)
