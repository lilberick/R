#------------------ Packages ------------------
library(flexdashboard)
library(coronavirus)
data(coronavirus)
`%>%` <- magrittr::`%>%`
#---------data-------
daily_death <- coronavirus %>%
  dplyr::filter(type == "death") %>%
  dplyr::filter(date >= "2020-02-29") %>%
  dplyr::mutate(country = country) %>%
  dplyr::group_by(date, country) %>%
  dplyr::summarise(total = sum(cases)) %>%
  dplyr::ungroup() %>%
  tidyr::pivot_wider(names_from = country, values_from = total)

#----------------------------------------
# Plotting the data

daily_death %>%
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
    y = ~France,
    type = "scatter",
    mode = "lines+markers",
    name = "France"
  ) %>%
  plotly::add_trace(
    x = ~date,
    y = ~Spain,
    type = "scatter",
    mode = "lines+markers",
    name = "Spain"
  ) %>%
  plotly::add_trace(
    x = ~date,
    y = ~Italy,
    type = "scatter",
    mode = "lines+markers",
    name = "Italy"
  ) %>%
  plotly::add_trace(
    x = ~date,
    y = ~China,
    type = "scatter",
    mode = "lines+markers",
    name = "China"
  ) %>%
  plotly::layout(
    title = "",
    legend = list(x = 0.1, y = 0.9),
    yaxis = list(title = "Numero de muertos"),
    xaxis = list(title = "Fecha"),
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
