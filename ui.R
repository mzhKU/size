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
                        plotOutput("plot_survival")
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
                            numericInput(inputId="alpha_prop", "Alpha", value=0.05, step=0.01),
                            numericInput(inputId="lost_prop", "Lost", value=0.15, step=0.05)
                        )
                    )
                ),
                mainPanel(
                    wellPanel(
                        plotOutput("prop")
                    )
                )
            )
        ),
        tabPanel("Continuous",
            sidebarLayout(
                sidebarPanel(
                    fluidRow(
                        column(4,
                            numericInput(inputId="alpha_cont", "Alpha", 0.05, step=0.01),
                            numericInput(inputId="delta", "Delta", 5, step=1),
                            numericInput(inputId="sigma", "Sigma", value=20, step=1),
                            numericInput(inputId="lost_cont", "Lost", value=0.2, step=0.1)
                        )
                    )
                ),
                mainPanel(
                    wellPanel(
                        plotOutput("cont")
                    )
                )
            )
        )
    ),
    h4("Developed by M. Hediger")
)
