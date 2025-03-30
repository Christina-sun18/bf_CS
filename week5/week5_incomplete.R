library(fpp3)

## 1.-----------------------------------------
## Use the tsibble created from `tourism` 
## for holiday travel in Victoria and Queensland. 

## a. Plot the series to remind yourself what these look like. 

holidays <- tourism |>
  filter(State %in% c("Victoria", "Queensland")) |> 
  filter(Purpose == "Holiday") |>
  as_tibble() |>
  summarise(Trips = sum(Trips), .by = c("State", "Quarter")) |>
  as_tsibble(index = Quarter, key = State)

## b. Use the `ETS()` function to fit models to both series.
## Explore the resulting `mable` using `report()`, `glance()` 
## and `tidy()`

fit <- holidays |>
  model(ETS())

fit
  
fit |>
  report()
  
fit |> 
  glance() 
  
  # report for each model using filter
fit |>
  filter() |>
  report() 


  # Another useful function
fit |> 
  tidy()


## c. Plot the estimated components of each model.

fit |>
  components() |>
  autoplot() + 
  labs(subtitle="")

  # Plot for each model using filter()
fit |>
  filter(State == ) |>
  components() |>
  autoplot()

## d. Generate forecasts using `forecast()`.



## 2.-----------------------------------------
## Use the exports data exports data for Algeria from the `global_economy` tsibble.

## a. Plot the data. Is this time series white noise?
## What ETS model would be appropriate?

algeria_economy <- global_economy  |> 
  filter(Country == "Algeria")

algeria_economy |> autoplot() + geom_point() #Be careful at what you are plotting

  # Is the data WN?

## b. Use the `ETS()` function to fit appropriate models
## with both additive and multiplicative errors. What model
## is chosen automatically? Explore the estimated models.

fit <- algeria_economy |>
  model(
    ANN = ETS(Exports ~ error("A") + trend("N") + season("N")),
    MNN = ETS()
  )
  
fit
  # an MNN is automatically chosen

fit |> select(ANN) |> report()
fit |> select(MNN) |> report()
  # Notice the different parameters and sigma

fit |> tidy()
fit |> glance() 


## c. Plot the components of the two models. What do you see?

fit |>
  components() 


## d. Explore the residuals of the two models. What do you see? 

fit |> 
  select(ANN) |> 
  augment()

fit |> 
  select(MNN) |> 
  augment()
  # Notice the difference in .innov and .resid
  # Why the difference?

fit |> 
  select(ANN) |> 
  gg_tsresiduals()

fit |> 
  select(MNN) |> 
  gg_tsresiduals()

# e. Generate and plot forecasts.

  # Recall point forecasts are the mean of all possible futures
  # i.e., expected values. 
  # Notice the point forecasts are flat. 


## 3.-----------------------------------------
## Use the population data for Australia `ÀUS` from the `global_economy` tsibble.

## a. Scale the data to be in millions and plot it. 



## b. Fit both a model with a linear and a damped trend 
## and study the estimated parameters. 


## c. Generate forecasts for 30 years ahead from both 
## models and plot them. What do you see? 



# fpp3 8.8, Ex6

# Forecast the Chinese GDP from the `global_economy` data set using an ETS model. 
# Experiment with the various options in the `ETS()` function to see how much the 
# forecasts change with damped trend, or with a Box-Cox transformation. Try to 
# develop an intuition of what each is doing to the forecasts.

# Hint: use `h=20` when forecasting, so you can clearly see the differences 
# between the various options when plotting the forecasts.

china <- global_economy |>
  filter(Country == "China")

china |> autoplot(GDP)

  # It clearly needs a relatively strong transformation due to the increasing variance.

china |> autoplot(box_cox(GDP, 0.2))
china |> features(GDP, guerrero)

  # Making lambda=0.2 looks ok.
  # The Guerrero method suggests an even stronger transformation. 
  # Let's also try a log.
china |> autoplot(box_cox(GDP, 0))

fit <- china |>
  model(
    ets = ETS(GDP),
    ets_damped = ETS(GDP ~ trend("Ad")),
    ets_bc = ETS(box_cox(GDP, 0.2)),
    ets_log = ETS(log(GDP))
  )

fit

augment(fit)

fit |>
  forecast(h = "20 years") |>
  autoplot(china, level = NULL)

  # The transformations have a big effect, with small lambda values 
  # creating big increases in the forecasts. 
  
fit <- china |>
  model(
    ets = ETS(log(GDP)),
    ets_damped = ETS(log(GDP) ~ trend("Ad"))
  )

fit |>
  forecast(h = "20 years") |>
  autoplot(china, level = NULL)

# The damping has relatively a small effect.
