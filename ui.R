library(shiny)
library(ggplot2)

fluidPage(
    titlePanel("Pie chart pyramid"),
    sidebarPanel(
        sliderInput("alpha", "Angle", min=0, max=90, value=20)),
    mainPanel(
        plotOutput("plot"),
        helpText(
            "A paraphrase of ",
            a("http://flowingdata.com/2014/12/01/pie-chart-pyramid/",
                href="http://flowingdata.com/2014/12/01/pie-chart-pyramid/",
                target="_blank")),
        helpText(
            "Source code available at ",
            a("github.com/lovrot/pie-chart-pyramid",
                href="https://github.com/lovrot/pie-chart-pyramid",
                target="_blank")))
)
