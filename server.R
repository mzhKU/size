#!/usr/bin/Rscript

library(shiny)
library(ggplot2)

# **********************************
# Calculate required number of patients give
# - median event free time for both conventional (t_c)
#   and experimental (t_e) treatment
# - Recruitment time K
# - Follow-up time M
# - Significance level alpha and power 1-beta
# **********************************

# First tab ("Survival"), second tab ("proportion"), third tab ("continuous").
function(input, output)
{
    out        <- reactiveValues()

    # Months.
    output$hazard_rate_conventional <- renderText({
        out$K <- input$recruitment_time
        out$M <- input$follow_up_time
        out$l_conv <- log(2)/input$time_conventional
    })

    output$hazard_rate_experimental <- renderText({
        out$l_exp  <- log(2)/input$time_experimental
    })

    # Events with conventional treatment.
    output$e_conv <- renderText({
        l_conv <- out$l_conv
        K      <- out$K
        M      <- out$M
        out$e_conv <- ( 1-1/(l_conv*K) * exp(-l_conv*M) * (1-exp(-l_conv*K)) )
    })

    # Events with experimental treatment.
    output$e_exp  <- renderText({
        l_exp  <- out$l_exp
        K      <- out$K
        M      <- out$M
        out$e_exp <- ( 1-1/(l_exp*K) * exp(-l_exp*M) * (1-exp(-l_exp*K)) )
    })

    # Hazard ratio.
    output$hr <- renderText({
        out$hr <- out$l_exp / out$l_conv
    })

    output$plot <- renderPlot({
        alpha_sur <- input$alpha_sur
        HR <- out$hr

        # Beta range.
        beta <- c(1.0:50.0)/100 

        k <- ceiling(4*(qnorm(1-alpha_sur/2) + qnorm(1-beta))^2/log(HR)^2)
        y <- ceiling(k/(out$e_conv + out$e_exp))

        d <- data.frame(x=beta, y=y)
        a <- ggplot(d, aes(x, y)) + geom_line(color="blue", size=2) +
                                    xlab("Beta") + ylab("Patients per Study arm") +
                                    ggtitle("Two-arm Study Size") + 
                                    theme(text=element_text(size=20)) +
                                    scale_x_continuous(breaks=c(0:100)/10,
                                                       minor_breaks=c(0:100)/100)
        print(a)
    })

    output$n <- renderPlot({
        prop1 <- input$prop1
        prop2 <- input$prop2
        alpha_prop <- input$alpha_prop
        prop <- (input$prop1 + input$prop2)/2
        
        # Beta range.
        beta <- c(1.0:50.0)/100 
        
        y <- ceiling( 
                      (qnorm(1-alpha_prop/2)*sqrt(2*prop*(1-prop)) +
                       qnorm(1-beta)*sqrt(prop1*(1-prop1) + prop2*(1-prop2))
                      )^2 / (prop1-prop2)^2
                    )

        d <- data.frame(x=beta, y=y)
        a <- ggplot(d, aes(x, y)) + geom_line(color="blue", size=2) +
                                    xlab("Beta") + ylab("Participants Total") +
                                    ggtitle("Comparison of Two Proportions") + 
                                    theme(text=element_text(size=20)) +
                                    scale_x_continuous(breaks=c(0:100)/10,
                                                       minor_breaks=c(0:100)/100)
        print(a)
    })
}
