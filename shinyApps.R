library(shiny)
library(shinydashboard)
library(XML)
library(RCurl)
library(dplyr)
library(ggmap)
ui <- dashboardPage(
  dashboardHeader(),
  dashboardSidebar(
    
    selectInput("FromToo","Select From to",choices = filterData$FromTo, multiple = TRUE,selected = "Tangerang [18]-Karang Tengah [11]")
  ),
  dashboardBody(
 
    textOutput("selected_var"),
    plotOutput(outputId="mapOut",
               width="100%", height="500px",
               click = "plot_click"
    )
   
  )
)


server <- function(input, output){
  
  map <- get_map(location = 'tangerang', zoom =12 )
  
  output$selected_var <- renderText({ 
    paste("Prediction on congestion", input$FromToo,"With time",a$Time,"is : ",a$dl,"seconds")
  })
  output$mapOut <- renderPlot({
    
    mapPoints <- ggmap(map) + geom_point(aes(x = xya$latitude, y = xya$longitude, size = sqrt(dl)), data = xya, alpha = .5)
    mapPoints
    
  })
}

shinyApp(ui = ui, server = server)