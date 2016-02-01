library(shiny)
library(ggplot2)
library(gridExtra)
library(datasets)
library(quantmod)

data<-mtcars
data$am<-as.factor(data$am)
levels(data$am)<-c("automatic","manual")

shinyServer(function(input, output){

  
  vars1 <- c("mpg","wt","am") 
#  data1<- reactive({
#      #subset(mtcars, wt>input$wt[1] & wt<input$wt[2])[vars1]
#      subset(mtcars, wt>3 & wt<4)[vars1]
      
      
#  })
  #data1$am<-factor(data1$am, labels=c("Automatic","Manual"))
  
  vars2<-c("mpg","qsec","am")
#  data2<-reactive({
#      #subset(mtcars, qsec>input$qsec[1] & qsec<input$qsec[2])[vars2]
#      subset(mtcars, qsec>10 & qsec<20)[vars2]
#  })
  #data2$am<-factor(data2$am, labels=c("Automatic","Manual"))

  
  output$plot <- renderPlot({
     #input<-dataInput()
      minwt <- reactive({as.numeric(input$wt[1])})
      maxwt <- reactive({as.numeric(input$wt[2])})  
      minq <- reactive({as.numeric(input$qsec[1])})
      maxq <- reactive({as.numeric(input$qsec[2])})      
      
      
     
     plot1 <- ggplot(subset(data, wt > minwt() & wt < maxwt())[vars1], aes(x=wt, y=mpg, color=am)) +
         geom_point(shape=1) +
         scale_colour_hue(l=50) +
         geom_smooth(method=lm, se=FALSE, fullrange=TRUE)
     
     plot3 <- ggplot(subset(data, qsec > minq() & qsec < maxq())[vars2], aes(x=qsec, y=mpg, color=am)) +
         geom_point(shape=1) +
         scale_colour_hue(l=50) +
         geom_smooth(method=lm, se=FALSE, fullrange=TRUE)
     
     plot2 <- ggplot(subset(data, wt> minwt() & wt<maxwt())[vars1], aes(x=wt,fill=am)) +
         geom_histogram(color="black",binwidth=0.2) +
         facet_grid(am ~ .) +
         ggtitle("Weight, by Transmission Type")
     
     plot4 <- ggplot(subset(data, qsec>minq() & qsec<maxq())[vars2], aes(x=qsec,fill=am)) +
         geom_histogram(color="black",binwidth=1) +
         facet_grid(am ~ .) +
         ggtitle("Quarter Mile Time, by Transmission Type")       
     
     grid.arrange(plot1, plot2, plot3, plot4, ncol=2)
      #multiplot(plot1, plot2, plot3, plot4, cols=2)
  })
    
})