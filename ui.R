#!/usr/bin/Rscript

fluidPage(
    headerPanel("Sample Size / Power calculation"),
    sidebarLayout(
        sidebarPanel(
            fluidRow(
                column(4, 
                    numericInput("time_conventional", "Median Free Time Conv.", 14),
                    numericInput("time_experimental", "Median Free Time Exp.", 19),
                    numericInput(inputId="recruitment_time", "Recruitment Time", 36),
                    numericInput(inputId="follow_up_time", "Follow-up Time", 24),
                    numericInput(inputId="alpha", "Alpha", value=0.05, step=0.01)
                ),
                column(8, 
                    # Hazard rates.
                    h6("Hazard Rate Conventional [1/month]:"),
                    textOutput(outputId="hazard_rate_conventional"),

                    h6("Hazard Rate Experimental [1/month]:"),
                    textOutput(outputId="hazard_rate_experimental"),
                    tags$br(),

                    # Event rates.
                    h6("Av. Event Rate Conventional:"),
                    textOutput(outputId="e_conv"),
                    h5("Av. Event Rate Experimental:"),
                    textOutput(outputId="e_exp"),
                    tags$br(),

                    # Hazard ratio.
                    h6("Hazard ratio:"),
                    textOutput(outputId="hr")
                )
            )
        ),
        mainPanel(
            wellPanel(
                plotOutput("plot")
            )
        )
    )
)
