library(fpp3)

## 1. --------
# Use the tsibble created from `tourism` for holiday travel in Victoria and Queensland. 
# Plot the series to remind yourself what these look like.
# Australian holiday tourism 

holidays <- tourism |>
  filter(State %in% c("Victoria", "Queensland")) |> 
  filter(Purpose == "Holiday") |>
  as_tibble() |>
  summarise(Trips = sum(Trips), .by = c("State", "Quarter")) |>
  as_tsibble(index = Quarter, key = State)



## 2. ---------------------
# Use the `ETS()` function to fit models with additive and 
# multiplicative errors to both series. Also let `ETS()` 
# auto select models. Explore the fitted models and their residuals. 

# Recall the syntax:
# tsibble |> model(ETS(y~error(" ")+trend(" ")+season(" ")))



## 3. ----------------------
# Generate forecasts from the fitted models. Why is the 
# multiplicative model needed for Victoria? 

# Recall the syntax:
# mable |> forecast() |> autoplot()



## 4. ------------------------- 
# Generate the `h02` series from the `PBS` tsibble we explored earlier using the code below.
# Plot the data and study it's features. What ETS model would be appropriate?

h02 <- PBS |>
  filter(ATC2 == "H02") |>
  summarise(Cost = sum(Cost))


## 5. -------------------------
# Find an `ETS` model and study it. 



## 6. -------------------------
# Generate forecasts for the next few years. 


## 7. --------------------------
# Combine `STL` decomposition with `ETS` to forecast the `h02` series. Explore
# Using

# Recall the syntax
# h02 |> model(decomposition_model(DECOMP(), MODEL(season_adjust), MODEL(season_year)))


