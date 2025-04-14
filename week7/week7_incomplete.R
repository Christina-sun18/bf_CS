library(fpp3)

## 1. -------------------------------------
# What sorts of transformations and differencing are needed 
# to make the `Cement` series from `aus_production` stationary? 
# Do the tests agree with your decisions? 
  

# Australia Cement production
aus_production |>
  autoplot(Cement) +
  labs(title = "Cement production in Australia")

# Stabilise variance


# Account for seasonality


# Let's get some help from gg_tsdisplay


# 2. ------------------------------------
# Generate the a10 and the h02 series from the PBS tsibble we explored 
# earlier using the code below.

a10 <- PBS |>
  filter(ATC2 == "A10") |>
  summarise(Cost = sum(Cost))

a10 |> autoplot(Cost)

# Difference without transformation - what do you see?


## h02
h02 <- PBS |>
  filter(ATC2 == "H02") |>
  summarise(Cost = sum(Cost))

h02 |>
  autoplot(Cost)



## 3. -------------------------------------
# Explore the the Algerian exports series from the `global_economy` 
# tsibble. Is the series stationary? Is the series white noise?
  
algeria <-global_economy |>
  filter(Country == "Algeria")

algeria |> 
  autoplot(Exports) +
  labs(y = "% of GDP", title = "Algerian Exports")

