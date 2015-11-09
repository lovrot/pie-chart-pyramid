library(shiny)
library(ggplot2)

fluidPage(
    titlePanel("Pie chart pyramid"),
    sidebarPanel(
        sliderInput("alpha", "Angle", min=0, max=90, value=20)),
    mainPanel(
        plotOutput("plot"),
        helpText(
            "Inspiration: ",
            a("http://flowingdata.com/2014/12/01/pie-chart-pyramid/",
                href="http://flowingdata.com/2014/12/01/pie-chart-pyramid/",
                target="_blank")))
)
