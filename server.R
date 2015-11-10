library(shiny)
library(ggplot2)

function(input, output) {

    palette_part <- c(
        "Sky"="deepskyblue3",
        "Sunny side of pyramid"="yellow1",
        "Shady side of pyramid"="yellow3")

    h <- 1.1

    derive_beta_angles <- reactive({

        alpha <- input$alpha_degrees/180*pi

        x_1 <- cos(pi/4 - alpha)
        x_2 <- sin(pi/4 - alpha)

        beta_1 <- atan(x_1/h)
        beta_2 <- atan(x_2/h)

        c(beta_1, beta_2)
    })

    output$plot <- renderPlot({

        theme_set(theme_bw())

        beta <- derive_beta_angles()

        binoculars_view <- data.frame(
            part=factor(names(palette_part), levels=names(palette_part)),
            radians=c(2*pi - 2*beta[1], beta[1] + beta[2], beta[1] - beta[2]))

        gg <- ggplot(data=binoculars_view,
            aes(x=factor(1), y=radians, fill=part)) +
            geom_bar(width=1, stat="identity", position="fill") +
            coord_polar(theta="y", start=pi + beta[1], direction=-1) +
            scale_x_discrete(breaks=NULL) +
            scale_y_continuous(breaks=NULL) +
            scale_fill_manual(values=palette_part) +
            theme(panel.grid.major.x=element_blank()) +
            theme(panel.border=element_blank()) +
            labs(x="", y="", fill="")

        plot(gg)
    }, height=300)

}
