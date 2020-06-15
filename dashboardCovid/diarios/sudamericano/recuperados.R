#------------------ Packages ------------------
library(flexdashboard)
library(coronavirus)
data(coronavirus)
`%>%` <- magrittr::`%>%`
#---------data-------
daily_recuperados <- coronavirus %>%
  dplyr::filter(type == "recovered") %>%
  dplyr::filter(date >= "2020-02-29") %>%
  dplyr::mutate(country = country) %>%
  dplyr::group_by(date, country) %>%
  dplyr::summarise(total = sum(cases)) %>%
  dplyr::ungroup() %>%
  tidyr::pivot_wider(names_from = country, values_from = total)

#----------------------------------------
# Plotting the data

daily_recuperados %>%
  plotly::plot_ly() %>%
  plotly::add_trace(
    x = ~date,
    y = ~Peru,
    type = "scatter",
    mode = "lines+markers",
    name = "Peru"
  ) %>%
  plotly::add_trace(
    x = ~date,
    y = ~Colombia,
    type = "scatter",
    mode = "lines+markers",
    name = "Colombia"
  ) %>%
  plotly::add_trace(
    x = ~date,
    y = ~Ecuador,
    type = "scatter",
    mode = "lines+markers",
    name = "Ecuador"
  ) %>%
  plotly::add_trace(
    x = ~date,
    y = ~Brazil,
    type = "scatter",
    mode = "lines+markers",
    name = "Brazil"
  ) %>%
  plotly::add_trace(
    x = ~date,
    y = ~Argentina,
    type = "scatter",
    mode = "lines+markers",
    name = "Argentina"
  ) %>%
  plotly::add_trace(
    x = ~date,
    y = ~Chile,
    type = "scatter",
    mode = "lines+markers",
    name = "Chile"
  ) %>%
  plotly::add_trace(
    x = ~date,
    y = ~Bolivia,
    type = "scatter",
    mode = "lines+markers",
    name = "Bolivia"
  ) %>%
  plotly::layout(
    title = "",
    legend = list(x = 0.1, y = 0.9),
    yaxis = list(title = "RECUPADOS (DIARIO)"),
    xaxis = list(title = "FECHA"),
    paper_bgcolor = "black",
    plot_bgcolor = "black",
    font = list(color = 'white'),
    hovermode = "compare",
    margin = list(
      # l = 60,
      # r = 40,
      b = 10,
      t = 10,
      pad = 2
    )
  )
