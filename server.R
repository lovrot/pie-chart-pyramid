library(shiny)
library(ggplot2)

function(input, output) {
    palette_part <- c(
        "Sky"="deepskyblue3",
        "Sunny side of pyramid"="yellow1",
        "Shady side of pyramid"="yellow3")

    binoculars_view <- reactive({
        data.frame(
            part=factor(names(palette_part), levels=names(palette_part)),
            percentage=c(75, 25*(1 - input$alpha/90), 25*input$alpha/90))
    })

    output$plot <- renderPlot({
        theme_set(theme_bw())
        gg <- ggplot(data=binoculars_view(), aes(x=factor(1), y=percentage, fill=part)) +
            geom_bar(width=1, stat="identity", position="fill") +
            coord_polar(theta="y", start=(180+45)/360*2*pi, direction=-1) +
            scale_x_discrete(breaks=NULL) +
            scale_y_continuous(breaks=NULL) +
            scale_fill_manual(values=palette_part) +
            theme(panel.grid.major.x=element_blank()) +
            theme(panel.border=element_blank()) +
            labs(x="", y="", fill="")
        plot(gg)
    }, height=300)
}
