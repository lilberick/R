#------------------ Packages ------------------
library(flexdashboard)
library(coronavirus)
data(coronavirus)
`%>%` <- magrittr::`%>%`
#------------------ Parameters ------------------
# Set colors
# https://www.w3.org/TR/css-color-3/#svg-color
confirmed_color <- "purple"
active_color <- "#1f77b4"
recovered_color <- "forestgreen"
death_color <- "red"
#------data-----------
df_daily <- coronavirus %>%
  dplyr::filter(country == "Peru") %>%
  dplyr::group_by(date, type) %>%
  dplyr::summarise(total = sum(cases, na.rm = TRUE)) %>%
  tidyr::pivot_wider(
    names_from = type,
    values_from = total
  ) %>%
  dplyr::arrange(date) %>%
  dplyr::ungroup() %>%
  dplyr::mutate(active = confirmed - death - recovered) %>%
  #dplyr::mutate(active = confirmed - death) %>%
  dplyr::mutate(
    confirmed_cum = cumsum(confirmed),
    death_cum = cumsum(death),
    recovered_cum = cumsum(recovered),
    active_cum = cumsum(active)
  )
#---------plot data-------
plotly::plot_ly(data = df_daily) %>%
  plotly::add_trace(
    x = ~date,
    # y = ~active_cum,
    y = ~confirmed_cum,
    type = "scatter",
    mode = "lines+markers",
    # name = "Active",
    name = "Confirmed",
    line = list(color = confirmed_color),
    marker = list(color = confirmed_color)
  ) %>%
  plotly::add_trace(
    x = ~date,
    y = ~death_cum,
    type = "scatter",
    mode = "lines+markers",
    name = "Death",
    line = list(color = death_color),
    marker = list(color = death_color)
  ) %>%
  plotly::add_trace(
    x = ~date,
    y = ~active_cum,
    type = "scatter",
    mode = "lines+markers",
    name = "Active",
    line = list(color = active_color),
    marker = list(color = active_color)
  ) %>%
  plotly::add_trace(
    x = ~date,
    y = ~recovered_cum,
    type = "scatter",
    mode = "lines+markers",
    name = "Recovered",
    line = list(color = recovered_color),
    marker = list(color = recovered_color)
  ) %>%
  plotly::add_annotations(
    x = as.Date("2020-03-06"),
    y = 1,
    text = paste("First case"),
    xref = "x",
    yref = "y",
    arrowhead = 5,
    arrowhead = 3,
    arrowsize = 1,
    showarrow = TRUE,
    ax = -10,
    ay = -90
  ) %>%
  plotly::add_annotations(
    x = as.Date("2020-03-20"),
    y = 3,
    text = paste("First death"),
    xref = "x",
    yref = "y",
    arrowhead = 5,
    arrowhead = 3,
    arrowsize = 1,
    showarrow = TRUE,
    ax = -10,
    ay = -90
  ) %>%
  plotly::layout(
    title = "",
    yaxis = list(title = "Número de casos en Perú (Acumulado)"),
    xaxis = list(title = "Fecha"),
    paper_bgcolor = "black",
    plot_bgcolor = "black",
    font = list(color = 'white'),
    legend = list(x = 0.1, y = 0.9),
    hovermode = "compare"
  )
