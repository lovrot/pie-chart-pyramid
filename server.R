library(shiny)
library(ggplot2)

function(input, output) {

    palette_part <- c(
        "Sky"="deepskyblue3",
        "Sunny side of pyramid"="yellow2",
        "Shady side of pyramid"="yellow4")

    ## Use dimensions of the Great Pyramid of Giza
    ## https://en.wikipedia.org/wiki/Great_Pyramid_of_Giza
    h <- 146.5/230.4*sqrt(2)

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

        binoculars <- data.frame(
            part=factor(
                c("Sky", "Sunny side of pyramid",
                    "Shady side of pyramid", "Sky"),
                levels=c("Sky", "Sunny side of pyramid",
                    "Shady side of pyramid")),
            radians=c(pi - beta[1], beta[1] + beta[2],
                beta[1] - beta[2], pi - beta[1]))

        gg <- ggplot(data=binoculars,
            aes(x=factor(1), y=radians, fill=part)) +
            geom_bar(width=1, stat="identity", position="fill") +
            scale_x_discrete(breaks=NULL, name="") +
            scale_y_continuous(breaks=NULL, name="") +
            scale_fill_manual(values=palette_part, name="") +
            theme(
                legend.text=element_text(size=16),
                panel.grid.major.x=element_blank(),
                panel.border=element_blank()) +
            coord_polar(theta="y", direction=-1)

        plot(gg)
    }, width=619, height=294)

}
