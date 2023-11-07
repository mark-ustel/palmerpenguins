library(shiny)
library(shinyWidgets)
library(tidyverse)
library(palmerpenguins)

data <- penguins |> na.omit() |>
  mutate(bill_ratio = bill_length_mm / bill_depth_mm,
         flipper_bill_ratio = flipper_length_mm / bill_length_mm,
         flipper_length_cm = flipper_length_mm / 10,
         body_mass_kg = body_mass_g / 1000) |>
  mutate(mass_flipper = flipper_length_cm/ body_mass_kg) |>
  mutate(species = factor(species, levels=c("Adelie", "Gentoo", "Chinstrap")))

server <- function(input, output, session) {

  df <- reactive ({
    data %>%
      { if (is.null(input$species)) . else filter(., species %in% input$species)} %>%
      { if (is.null(input$island)) . else filter(., island %in% input$island)} %>%
      { if (is.null(input$sex)) . else filter(., sex %in% input$sex)} %>%
      { if (is.null(input$year)) . else filter(., year %in% input$year)}
  })
  
  sum_stats <- reactive({
    df() |> 
    group_by(species) |> 
    summarise(percentage = 100 * n() / nrow(df()),
              bill_ratio = mean(bill_ratio),
              body_mass_kg = mean(body_mass_kg)) |>
    column_to_rownames(var="species")
  })
  
  observe({updateProgressBar(session = session, id = "pb1", value = sum_stats()["Adelie", "percentage"])})
  observe({updateProgressBar(session = session, id = "pb2", value = sum_stats()["Adelie", "bill_ratio"] * 20 )})
  observe({updateProgressBar(session = session, id = "pb3", value = sum_stats()["Adelie", "body_mass_kg"] * 10 )})
  observe({updateProgressBar(session = session, id = "pb4", value = sum_stats()["Gentoo", "percentage"])})
  observe({updateProgressBar(session = session, id = "pb5", value = sum_stats()["Gentoo", "bill_ratio"] * 20 )})
  observe({updateProgressBar(session = session, id = "pb6", value = sum_stats()["Gentoo", "body_mass_kg"] * 10 )})
  observe({updateProgressBar(session = session, id = "pb7", value = sum_stats()["Chinstrap", "percentage"])})
  observe({updateProgressBar(session = session, id = "pb8", value = sum_stats()["Chinstrap", "bill_ratio"] * 20 )})
  observe({updateProgressBar(session = session, id = "pb9", value = sum_stats()["Chinstrap", "body_mass_kg"] * 10 )})

  output$PenguinViolin <- renderPlot({
    df() |>
      select(species, bill_ratio) |>
      ggplot( aes(x = species, y = bill_ratio, colour = species, fill=species)) +
      geom_violin(alpha = 0.2, linewidth = 0.25) +
      geom_jitter(size = 0.3, alpha = 0.45, width = 0.23, height = 0) + 
      scale_color_manual(name= "species", values=c("Adelie"="#826AED", 
                                                   "Gentoo"="#3185FC",
                                                   "Chinstrap"="#539987")) +
      scale_fill_manual(name= "species", values=c("Adelie"="#826AED", 
                                                  "Gentoo"="#3185FC",
                                                  "Chinstrap"="#539987")) +
      labs(title = "Bill shape can be utilised for penguin classification",
           subtitle = "Feature engineering (bll length/depth) proved more successful than any single variable",
           caption = "Caption 1: A violin plot showing the distribution for the three populations, jitter added to the individual datapoints for clarity") +
      xlab("Species") +
      ylab("Bill Length to Depth Ratio") +
      theme_minimal() +
      theme(legend.position = "none",
            panel.background = element_rect(color = NA, fill = "transparent"),
            panel.border = element_rect(colour = "grey60", fill = "transparent"),
            panel.grid.major.x = element_line(color = "grey80", size = 0.1),
            panel.grid.major.y = element_line(color = "grey80", size = 0.1),
            panel.grid.minor.x = element_line(color = "grey80", size = 0.1),
            panel.grid.minor.y = element_line(color = "grey80", size = 0.1),
            text = element_text(family = "Tahoma", colour = "grey40"),
            plot.title = element_text(size = 16, margin = margin(t = 4, r = 0, b = 4, l = 0)),
            plot.subtitle = element_text(size = 10, margin = margin(t = 0, r = 0, b = 10, l = 0)),
            plot.caption = element_text(colour = "grey50", face = "italic", hjust = 0, vjust = 2),
            axis.title.y = element_text(margin = margin(t = 0, r = 10, b = 0, l = 0)),
            axis.text.x = element_text(colour = "grey60"),
            axis.text.y = element_text(colour = "grey60")
      )
  })
  
  output$PenguinPoints <- renderPlot({
    df() |>
      select(species, flipper_length_cm, body_mass_kg) |>
      ggplot( aes(x = body_mass_kg, y = flipper_length_cm, colour = species, fill=species)) +
      geom_point(size = 2, alpha = 0.35) + 
      geom_smooth(method = "lm",  linewidth = 0.1, alpha = 0.1) +
      scale_color_manual(name= "species", values=c("Adelie"="#826AED", 
                                                   "Gentoo"="#3185FC",
                                                   "Chinstrap"="#539987")) +
      scale_fill_manual(name= "species", values=c("Adelie"="#826AED", 
                                                  "Gentoo"="#3185FC",
                                                  "Chinstrap"="#539987")) +
      labs(title = "Flipper length is a great predicter for body mass",
           subtitle = "Accuracy can be improved with the inclusion of species and sex into the regression model",
           caption = "Caption 2: Single variable linear regression highlighting the correlation between flipper length and body mass") +
      xlab("Body Mass (kg)") +
      ylab("Flipper Length (cm)") +
      theme_minimal() +
      theme(legend.position = "none",
            panel.background = element_rect(colour = NA, fill = "white"),
            panel.border = element_rect(colour = "grey60", fill = NA),
            panel.grid.major.x = element_line(color = "grey80", size = 0.1),
            panel.grid.major.y = element_line(color = "grey80", size = 0.1),
            panel.grid.minor.x = element_line(color = "grey80", size = 0.1),
            panel.grid.minor.y = element_line(color = "grey80", size = 0.1),
            text = element_text(family = "Tahoma", colour = "grey40"),
            plot.title = element_text(size = 16, margin = margin(t = 4, r = 0, b = 4, l = 0)),
            plot.subtitle = element_text(size = 10, margin = margin(t = 0, r = 0, b = 10, l = 0)),
            plot.caption = element_text(colour = "grey50", face = "italic", hjust = 0, vjust = 2),
            axis.title.y = element_text(margin = margin(t = 0, r = 10, b = 0, l = 0)),
            axis.text.x = element_text(colour = "grey60"),
            axis.text.y = element_text(colour = "grey60")
      )
  })
  
}

shinyApp(ui = htmlTemplate("www/index.html"), server = server)