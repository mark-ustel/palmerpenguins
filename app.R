library(shiny)
library(shinyWidgets)
library(shinycssloaders)
library(dplyr)
library(ggplot2)
library(tibble)
library(palmerpenguins)

css_code <- "
* {
  padding: 0;
  margin: 0;
  background: #E5E5E5;
  font-family: Tahoma, Helvetica, Arial, sans-serif;
}

.img { grid-area: img; }
.adelie { grid-area: adelie; }
.chinstrap { grid-area: gentoo; }
.gentoo { grid-area: chinstrap; }
.filter { grid-area: filter; }
.chart { grid-area: chart; }

.grid-container {
  display: grid;
  grid-template-areas:
    'img adelie chinstrap gentoo'
    'filter chart chart chart' ;
  grid-template-columns: 1fr 1fr 1fr 1fr;
  grid-template-rows: 1fr 3fr;
  gap: 40px;
  height: 90vh;
  padding: 40px;
}

.item {
  text-align: center;
  padding: 0 0;
  border-radius: 20px;
  position: relative;
}

:root {
  --dk-sd: rgba(70,70,70,    0.08);
  --lt-sd: rgba(255,255,255, 0.65);
}

.img {
  overflow: hidden;
  border-radius: 100px;
  box-shadow: 
    -1px -1px 1px rgba(255,255,255,0.4),
    -1px 0px 1px rgba(255,255,255,0.4),
    0px -1px 1px rgba(255,255,255,0.4),
    1px 1px 1px rgba(70,70,70,0.12);
}

.pop-down {
  box-shadow: 4px 4px 8px var(--dk-sd) inset,
    -4px -4px 8px var(--lt-sd) inset;
}

.pop-up {
  box-shadow: -10px -10px 10px rgba(255,255,255,0.6),
    -10px 1px 10px rgba(255,255,255,0.6),
    1px -10px 10px rgba(255,255,255,0.6),
    0px 10px 10px rgba(70,70,70,0.08),
    10px 0px 10px rgba(70,70,70,0.12);
}

.chart {
  display: flex;
  overflow: hidden;
  background: white;
  gap: 40px;
  border: 0px solid #EFEFEF;
}

.chart-side{
  width: 50%;
  height: 100%;
}

.left-chart {
  border-radius-topleft: 0px;
  border-radius-bottomleft: 0px;
}
.right-chart {
  border-radius-topright: 0px;
  border-radius-bottomright: 0px;
}

.penguin-img {
  padding: 0;
  object-fit: cover;
  left: 0;
  right: 0;
  top: 0;
  height: 100%;
  opacity: 1;
  z-index: -99;
}

.container {
  width: 80%;
  margin: auto auto;
  margin-top: 2vh;
  display: flex;
  align-items: center;
  justify-content: center;
}

.button {
  width: 50%;
  height: 50px;
  border-radius: 1px;
  cursor: pointer;
  position: relative;
  border: 1px solid #E5E5E5;
  box-shadow: 10px 10px 8px rgba(255,255,255,0.5) inset,
               -10px -10px 8px rgba(70,70,70,0.03) inset;
  transition: 200ms;
}

.button:hover {
  background: rgba(200,200,200, 0.3);
}

.button-3 {width: 33%}
.button-left {border-radius: 8px 1px 1px 8px;}
.button-right {border-radius: 1px 8px 8px 1px;}

.button:before {
  position: relative;
  display: flex;
  align-items: center;
  justify-content: center;
  font-weight: 900;
  font-size: 30px;
  font-size: clamp(14px, 1.7vw, 24px);
  color: rgba(180, 180, 180, 1);
  margin: 0;
  height: 100%;
  margin-left: 10%;
  margin-right: 10%;
  width: 80%;
  transition: 440ms ease;
}

input:checked + .button::before {
  color: white;
}
input:checked + .btn-blu::before {
  text-shadow: 0 0 3px #acf, 0 0 6px #acf, 0 0 8px #acf;
}
input:checked + .btn-pnk::before {
  text-shadow: 0 0 2px #fac, 0 0 7px #fac, 0 0 10px #fac;
}
input:checked + .btn-grn::before {
  text-shadow: 0 0 1px #afa, 0 0 3px #afa, 0 0 5px #afa;
}
input:checked + .btn-pur::before {
  text-shadow: 0 0 3px #daf, 0 0 6px #daf, 0 0 8px #daf;
}

.btn-txt::before {font-size: clamp(8px, 1.0vw, 12px);}
.btn-ade:before {content: 'Adelie';}
.btn-gen:before {content: 'Gentoo';}
.btn-chn:before {content: 'Chinstrap';}
.btn-mal:before {content: 'Male';}
.btn-fem:before {content: 'Female';}
.btn-bis:before {content: 'Biscoe';}
.btn-drm:before {content: 'Dream';}
.btn-tor:before {content: 'Torgersen';}
.btn-2007:before {content: '2007';}
.btn-2008:before {content: '2008';}
.btn-2009:before {content: '2009';}

input:checked + .button {
  box-shadow: -5px -5px 10px 5px rgba(255,255,255,0.5) inset,
    -10px -10px 10px 5px rgba(255,255,255,0.5) inset,
    5px 5px 10px 5px rgba(70,70,70,0.05) inset,
    10px 10px 10px 5px rgba(70,70,70,0.05) inset;
}

input{
  display: none;
}

p {
  margin-top: 4vh;
  margin-left: 10%;
  width: 80%;
  color: #666;
  text-align: center;
}

.sum-stat {
  padding: 15px;
}

.ss-hd {
  margin: auto auto;
  padding: 0;
  width: 100%;
  text-align: center;
}

.ss-label {
  margin: 0;
  margin-left: 10%;
  padding-top: 14px;
  font-size: 10px;
  text-align: left;
  width: 80%;
}

.ss-label > div {
  color: #666;
  font-style: oblique;
}

#AdePerTxt, #AdeBlRTxt, #AdeBMTxt,
#GenPerTxt, #GenBlRTxt, #GenBMTxt,
#ChnPerTxt, #ChnBlRTxt, #ChnBMTxt {
  color: #666;
  margin: 0;
  margin-left: 10%;
  padding-top: 14px;
  font-size: 10px;
  text-align: left;
  width: 80%;
}

.progress-group {
  width: 80%;
  height: 6px;
  margin: auto auto;
  margin-top: 6px;
  background-color: #eee;
  background-image: linear-gradient(90deg, 
    #CCC 0px 1px,
    transparent 1px 100% );
  border-radius: 20px;
  box-shadow: 0 2px 3px rgba(0, 0, 0, 0.25) inset,
    0 -2px 3px rgba(255, 255, 255, 0.25) inset;
}

#pb1.progress-bar,
#pb4.progress-bar,
#pb7.progress-bar {
  background-size: 50% 50%;
}
#pb2.progress-bar,
#pb5.progress-bar,
#pb8.progress-bar {
  background-size: 20% 50%;
}
#pb3.progress-bar,
#pb6.progress-bar,
#pb9.progress-bar {
  background-size: 10% 50%;
}

.progress {
  width: 100%;
  height: 100%;
  background: rgba(0,0,0,0);
}

.progress-bar {
  height: 100%;
  box-shadow: 0 -2px 3px rgba(0, 0, 0, 0.25) inset,
    0 2px 3px rgba(255, 255, 255, 0.25) inset;
  border-radius: 20px;
}

#pb1.progress-bar,
#pb2.progress-bar,
#pb3.progress-bar {
  background-color: rgba(130, 106, 237, 0.6);
}
#pb4.progress-bar,
#pb5.progress-bar,
#pb6.progress-bar {
  background-color: rgba(49, 133, 252, 0.51);
}
#pb7.progress-bar,
#pb8.progress-bar,
#pb9.progress-bar {
  background-color: rgba(83, 153, 135, 0.55);
}

.pen-title {
  position: absolute ;
  width: 100%;
  top: 1%;
  margin: 0;
  align-text: center;
  background: rgba(0,0,0,0);
  font-size: clamp(14px, 1.5vw, 20px);
}

.pen-footer {
  position: absolute;
  width: 60%;
  margin: 0;
  margin-left: 20%;
  bottom: 0;
  color: #777;
  align-text: center;
  background: rgba(0,0,0,0);
  font-size: clamp(8px, 1vw, 10px);
}
"

data <- penguins |> na.omit() |>
  mutate(bill_ratio = bill_length_mm / bill_depth_mm,
         flipper_bill_ratio = flipper_length_mm / bill_length_mm,
         flipper_length_cm = flipper_length_mm / 10,
         body_mass_kg = body_mass_g / 1000) |>
  mutate(mass_flipper = flipper_length_cm/ body_mass_kg) |>
  mutate(species = factor(species, levels=c("Adelie", "Gentoo", "Chinstrap")))

ui <- fluidPage(
  # tags$head( tags$link(rel = "stylesheet", type = "text/css", href = "main.css") ),
  tags$head(
    tags$style(HTML(css_code))  # Include CSS code within the <style> tag
  ),
  tags$div(tags$div(class = "item img",
                    tags$img(src = "Penguins.png", class="penguin-img", `role`="abc"),
                    tags$h1("Palmer Penguins", class = "pen-title"),
                    tags$p("Meet and explore three penguins species from islands in the Palmer Archipelago, Antarctica.", class="pen-footer")
  ),
  
  tags$div(class = "item pop-down sum-stat adelie",
           tags$p("Adelie", class = "ss-hd"),
           textOutput("AdePerTxt"),
           progressBar(id = "pb1", value = 100),
           textOutput("AdeBlRTxt"), 
           progressBar(id = "pb2", value = 100),
           textOutput("AdeBMTxt"),
           progressBar(id = "pb3", value = 100),
           ),
  
  tags$div(class = "item pop-down sum-stat gentoo",
           tags$p("Gentoo", class = "ss-hd"),
           textOutput("GenPerTxt"),
           progressBar(id = "pb4", value = 100),
           textOutput("GenBlRTxt"), 
           progressBar(id = "pb5", value = 100),
           textOutput("GenBMTxt"),
           progressBar(id = "pb6", value = 100),
  ),
  
  tags$div(class = "item pop-down sum-stat chinstrap",
           tags$p("Chinstrap", class = "ss-hd"),
           textOutput("ChnPerTxt"),
           progressBar(id = "pb7", value = 100),
           textOutput("ChnBlRTxt"), 
           progressBar(id = "pb8", value = 100),
           textOutput("ChnBMTxt"),
           progressBar(id = "pb9", value = 100),
  ),
  
  tags$div(class = "filter item pop-up",
           tags$p("Species"),
           tags$div(id="species", class="container shiny-input-checkboxgroup shiny-input-container shiny-bound-input", role="group",
                    tags$input(type = "checkbox", id = "check-ade", name = "species", value = "Adelie"),
                    tags$label(`for` = "check-ade", class = "button btn-pur button-left btn-txt btn-ade"),

                    tags$input(type = "checkbox", id = "check-gen", name = "species", value = "Gentoo"),
                    tags$label(`for` = "check-gen", class = "button btn-blu btn-txt btn-gen"),

                    tags$input(type = "checkbox", id = "check-chn", name = "species", value = "Chinstrap"),
                    tags$label(`for` = "check-chn", class = "button btn-grn button-right btn-txt btn-chn")
                    ),
                    
      
           tags$p("Gender"),
           tags$div(id="sex", class="container shiny-input-checkboxgroup shiny-input-container shiny-bound-input", role="group",
                    tags$input(type = "checkbox", id = "check-mal", name = "sex", value = "male"),
                    tags$label(`for` = "check-mal", class = "button btn-blu button-left btn-txt btn-mal"),
                    
                    tags$input(type = "checkbox", id = "check-fem", name = "sex", value = "female"),
                    tags$label(`for` = "check-fem", class = "button btn-pnk button-right btn-txt btn-fem")
           ),
           
           tags$p("Island"),
           tags$div(id="island", class="container shiny-input-checkboxgroup shiny-input-container shiny-bound-input", role="group",
                    tags$input(type = "checkbox", id = "check-bis", name = "island", value = "Biscoe"),
                    tags$label(`for` = "check-bis", class = "button btn-blu button-left btn-txt btn-bis"),
                    
                    tags$input(type = "checkbox", id = "check-drm", name = "island", value = "Dream"),
                    tags$label(`for` = "check-drm", class = "button btn-blu btn-txt btn-drm"),
                    
                    tags$input(type = "checkbox", id = "check-tor", name = "island", value = "Torgersen"),
                    tags$label(`for` = "check-tor", class = "button btn-blu button-right btn-txt btn-tor")
           ),
           
           tags$p("Year"),
           tags$div(id="year", class="container shiny-input-checkboxgroup shiny-input-container shiny-bound-input", role="group",
                    tags$input(type = "checkbox", id = "check-2007", name = "year", value = "2007"),
                    tags$label(`for` = "check-2007", class = "button btn-blu button-left btn-txt btn-2007"),
                    
                    tags$input(type = "checkbox", id = "check-2008", name = "year", value = "2008"),
                    tags$label(`for` = "check-2008", class = "button btn-blu btn-txt btn-2008"),
                    
                    tags$input(type = "checkbox", id = "check-2009", name = "year", value = "2009"),
                    tags$label(`for` = "check-2009", class = "button btn-blu button-right btn-txt btn-2009")
           ),
  ),
  tags$div(class = "item pop-up chart",
           tags$div(class = "chart-side left-chart shiny-plot-output",
                    withSpinner(plotOutput("PenguinViolin", width = "100%", height = "500px"),
                                type = 3,
                                color = "#89A3D5",
                                color.background = "#E5E5E5")
                    ),
           tags$div(class = "chart-side right-chart shiny-plot-output",
                    withSpinner(plotOutput("PenguinPoints", width = "100%", height = "500px"), 
                                type = 3,
                                color = "#89A3D5",
                                color.background = "#E5E5E5")
                    )
           ),
  class = "grid-container")
)


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
  
  output$AdePerTxt <- renderText({
    percentage <- sum_stats()["Adelie", "percentage"]
    if (is.na(percentage)) {
      "Population of total: 0%"
    } else {
      sprintf("Population of total: %.1f%%", percentage)
    }
  })
  output$AdeBlRTxt <- renderText({  sprintf("Bill length to depth ratio: %.2f", sum_stats()["Adelie", "bill_ratio"])  })
  output$AdeBMTxt <- renderText({  sprintf("Flipper length to body mass ratio: %.2f ", sum_stats()["Adelie", "body_mass_kg"])  })
  
  output$GenPerTxt <- renderText({
    percentage <- sum_stats()["Gentoo", "percentage"]
    if (is.na(percentage)) {
      "Population of total: 0%"
    } else {
      sprintf("Population of total: %.1f%%", percentage)
    }
  })
  output$GenBlRTxt <- renderText({  sprintf("Bill length to depth ratio: %.2f", sum_stats()["Gentoo", "bill_ratio"])  })
  output$GenBMTxt <- renderText({  sprintf("Flipper length to body mass ratio: %.2f ", sum_stats()["Gentoo", "body_mass_kg"])  })
  
  output$ChnPerTxt <- renderText({
    percentage <- sum_stats()["Chinstrap", "percentage"]
    if (is.na(percentage)) {
      "Population of total: 0%"
    } else {
      sprintf("Population of total: %.1f%%", percentage)
    }
  })
  output$ChnBlRTxt <- renderText({  sprintf("Bill length to depth ratio: %.2f", sum_stats()["Chinstrap", "bill_ratio"])  })
  output$ChnBMTxt <- renderText({  sprintf("Flipper length to body mass ratio: %.2f ", sum_stats()["Chinstrap", "body_mass_kg"])  })
  
  
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
           subtitle = "Feature engineering (bill length/depth) proved more successful than any single variable",
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

shinyApp(ui = ui, server = server)
