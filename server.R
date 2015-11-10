library(shiny)
library(ggplot2)

function(input, output) {
    palette_part <- c(
        "Sky"="deepskyblue3",
        "Sunny side of pyramid"="yellow1",
        "Shady side of pyramid"="yellow3")

    h <- 1.1

    binoculars_view <- reactive({

        theta <- pi/4 - input$alpha/180*pi

        x_1 <- cos(theta)
        x_2 <- cos(theta - pi/2)

        beta <- atan(x_1/h)
        gamma <- atan(x_2/h)

        df <- data.frame(
            part=factor(names(palette_part), levels=names(palette_part)),
            radians=c(2*pi - 2*beta, beta + gamma, beta - gamma))

        attr(df,"beta") <- beta

        return(df)
    })

    output$plot <- renderPlot({

        theme_set(theme_bw())

        df <- binoculars_view()

        gg <- ggplot(data=df, aes(x=factor(1), y=radians, fill=part)) +
            geom_bar(width=1, stat="identity", position="fill") +
            coord_polar(theta="y", start=pi + attr(df, "beta"), direction=-1) +
            scale_x_discrete(breaks=NULL) +
            scale_y_continuous(breaks=NULL) +
            scale_fill_manual(values=palette_part) +
            theme(panel.grid.major.x=element_blank()) +
            theme(panel.border=element_blank()) +
            labs(x="", y="", fill="")

        plot(gg)
    }, height=300)
}
