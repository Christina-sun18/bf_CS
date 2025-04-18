library(fpp3)

## ---- GDP ----------------------------------------------------------------
  # An end to end process without evaluation

  # Build the variable you aim to forecast
  # You can do this for IA2 today
  # No need to do any adjustment in your assignments

  # Data preparation - Tidy
gdppc <- global_economy |>
  mutate(GDP_per_capita = GDP / Population) |>
  select(Year, Country, GDP, Population, GDP_per_capita)

  # Here is our tsibble
gdppc

  # Visualise
  # Lets pick a country just to have a look
gdppc |>
  filter(Country == "Sweden") |>
  autoplot(GDP_per_capita) +
  labs(title = "GDP per capita for Sweden", y = "$US")

# Specify and Estimate

  # Train models to data using model()
  # pass a tsibble into model() get a mable()
fit <- gdppc |>
  model(naive = NAIVE(GDP_per_capita),
        drift_method = RW(GDP_per_capita ~ drift())
        )

fit
  # is a mable() - model table

  # pass a mable() into forecast() get a fable()
fc <- fit |> forecast(h = 3) #"3 years"
fc  # is a fable() - forecast table

fc |>
  filter(Country == "Sweden") |> #, .model=="drift_method"
  autoplot(gdppc) +
  labs(title = "GDP per capita for Sweden", y = "$US")

  # process
  # tsibble |> model() |> forecast()
  # tsibble |> mable() |> fable()


# ---- Holiday tourism by state----

## 1.-----------------------------------------
## Create a tsibble with total Holiday travellers
## for Victoria and Queensland from the `tourism`
## data set. Plot the series. What do you see?

holidays <- tourism |>
  filter(State %in% ) |> 
  filter(Purpose == ) |>
  as_tibble() |>
  summarise(Trips = sum(Trips), .by = c("State", "Quarter")) |>
  as_tsibble(index = Quarter, key = State)

holidays |> autoplot()

holidays |> autoplot() + 
  facet_wrap(~State, ncol = 1, scales = "free")

## 2.------------------------------------------
## Generate 4 year ahead forecasts from all 
## four benchmarks. Plot them using autoplot().
## Comment in the resulting forecasts.

  # Fit benchmarks 





  # Generate forecasts and plots them 


## 3.---------------------------------------
## Plot the residuals from the most appropriate 
## benchmark using `gg_tsresiduals()`. What do you see? 
## 

  # Recall what the fit object contains
  # Hence we need to both filter() and select()

  # Let's start with Victoria






  # Why the Warning message? 

  # How about Queensland?


## 4.----------------------------------------
## Test if the residuals are white noise.
## What do you conclude? 
## 

  # Check the augment(fit)
  # Here only filter will work
  # as we are in long form
augment(fit)

augment(fit) |>
  filter(State == "Victoria", .model=="snaive") |> 
  features(.innov, ljung_box, lag = 8)

  # How about Queensland?


## 5.----------------------------------------
## Plot point and interval forecasts from the most 
## appropriate benchmark 




## 6.--------------------------------------- 
## Now try a decomposition forecasting model.

stl_fit <- holidays |>
  model(
    stlf = decomposition_model(
      STL(Trips),
      NAIVE(season_adjust)
    ))

stl_fit |>
  forecast(h = "4 years") |>
  autoplot(holidays)

## 7.----------------------------------------
## Use `accuracy()` to evaluate which model
## fits the data best

# Which model fits best?

left_join(fit, stl_fit) |> 
  accuracy() |>
  group_by(State,.model) |> 
  select(RMSE, MAPE, MASE, RMSSE) |> 
  arrange(State,RMSSE)

## 8.--------------------------------------- 
## Use a test set of last 3 years to check 
## forecast accuracy.

training <- holidays |>
  filter(Quarter <= max(Quarter) - 12)

training_fit <- training |>
  model(
    snaive = SNAIVE(Trips),
    drift = RW(Trips ~ drift()),
    stlf = decomposition_model(
      STL(Trips),
      NAIVE(season_adjust)
    )
  )

test_fc <- training_fit |>
  forecast(h = "4 years")

test_fc |>
  autoplot(holidays, level = NULL) 

test_fc |>
  accuracy(holidays) |>
  group_by(.model, State)  |>
  select(RMSE, MAPE, MASE, RMSSE) |> 
  arrange(State, RMSSE)

## 9.---------------------------------------------
## Now use time series cross-validation to check 
## forecast accuracy


