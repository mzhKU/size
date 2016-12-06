#!/usr/bin/Rscript

fluidPage(
    headerPanel("Sample Size / Power calculation"),
    tabsetPanel(
        tabPanel("Survival",
            sidebarLayout(
                sidebarPanel(
                    fluidRow(
                        column(4, 
                            numericInput("time_conventional", "Median Free Time Conv.", 14),
                            numericInput("time_experimental", "Median Free Time Exp.", 19),
                            numericInput(inputId="recruitment_time", "Recruitment Time", 36),
                            numericInput(inputId="follow_up_time", "Follow-up Time", 24),
                            numericInput(inputId="alpha_sur", "Alpha", value=0.05, step=0.01)
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
        ),
        tabPanel("Proportion",
            sidebarLayout(
                sidebarPanel(
                    fluidRow(
                        column(4,
                            numericInput("prop1", "Prop. 1", 0.2, step=0.05),
                            numericInput("prop2", "Prop. 2", 0.5, step=0.05),
                            numericInput(inputId="alpha_prop", "Alpha", value=0.05, step=0.01)
                        )
                    )
                ),
                mainPanel(
                    wellPanel(
                        plotOutput("n")
                    )
                )
            )
        )
    ),
    h4("Developed by M. Hediger")
)
