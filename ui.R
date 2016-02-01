library(shiny)

shinyUI(
    fluidPage(
        headerPanel("Interactive Exploration of mtcars Dataset"),
        
        wellPanel(tags$small(paste0(         
        "This application is designed to explore the effect that vehicle weight
                 and quarter mile time variables have on mpg within the mtcars dataset.
                 To explore, adjust the weight and qsec sliders. Each slider controls the two plots  
                immediately to the right of the slider, one of which has a scatterplot and regression line
                for mpg vs. the given variable.  The other contains a histogram to show how many data points 
                fall within the chosen range.  Each plot separates automatic and manual transmissions"))
        ),
        
    
        
        sidebarPanel(

            sliderInput(inputId="wt",
                label=h5("Weight of Vehicle"),
                min = min(1.5),
                max = max(5.5),
                value=c(2,4)               
            ),
            
            sliderInput(inputId="qsec",
                label=h5("Quarter Mile Time"),
                min=min(14),
                max=max(23),
                value=c(16, 19)
            )
        ),
        
        mainPanel(plotOutput("plot"))
        
    )
)