library(shiny)
library(ggplot2)

fluidPage(
    titlePanel("An interactive pyramid pie chart"),
    fluidRow(
        column(8,
            p(
                "A paraphrase of",
                a("flowingdata.com/2014/12/01/pie-chart-pyramid/",
                    href="http://flowingdata.com/2014/12/01/pie-chart-pyramid/",
                    target="_blank")),
            plotOutput("plot", width="619px", height="294px")
        ),
        column(4,
            wellPanel(
                sliderInput("alpha_degrees", "Viewing angle", min=0, max=90, value=20))
        )
    ),
    hr(),
    p(
        "© 2015 John Lövrot",
        br(),
        "This work is licensed under a",
        a("Creative Commons Attribution 4.0 International License",
            href="http://creativecommons.org/licenses/by/4.0/",
            target="_blank"),
        br(),
        "The source code is available at",
        a("github.com/lovrot/pie-chart-pyramid",
            href="https://github.com/lovrot/pie-chart-pyramid",
            target="_blank"),
        br(),
        "Version 0.5.4")
)
