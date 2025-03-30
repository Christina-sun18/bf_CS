1. Use the tsibble created from `tourism` for holiday travel in Victoria and Queensland. 

    a. Plot the series to remind yourself what these look like.
    b. Use the `ETS()` function to fit models to both series. Explore the resulting `mable` using `report()`, `glance()` and `tidy()`
    c. Plot the estimated components of each model.
    d. Generate forecasts using `forecast()`.

2. Use the exports data exports data for Algeria from the `global_economy` tsibble. 

    a. Plot the data. Is this time series white noise? What ETS model would be appropriate?
    b. Use the `ETS()` function to fit appropriate models with both additive and multiplicative errors. What model is chosen automatically? Explore the estimated models.
    c. Plot the components of the two models. What do you see?
    d. Explore the residuals of the two models. What do you see?
    e. Generate and plot forecasts.

3. Use the population data for Australia `(country == "AUS")` from the `global_economy` tsibble.

    a. Scale the data to be in millions and plot it. 
    b. Fit both a model with a linear and a damped trend and study the estimated parameters. 
    c. Generate forecasts for 30 years ahead from both models and plot them. What do you see? 
    d. Fit both models using data up to 2010. Generate forecasts for the remainder of the sample and evaluate their accuracy.
    
4. Do Exercise 6 from [Section 8.8](https://otexts.com/fpp3/expsmooth-exercises.html).
