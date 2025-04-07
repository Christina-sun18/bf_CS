1. Use the tsibble created from `tourism` for holiday travel in Victoria and Queensland. Plot the series to remind yourself what these look like.

2. Use the `ETS()` function to fit models with additive and multiplicative errors to both series. Also let `ETS()` auto select models. Explore the fitted models and their residuals. 

3. Generate forecasts from the fitted models. Why is the multiplicative model needed for Victoria? 

4. Generate the `h02` series from the `PBS` tsibble using the code below. Plot the data and study it's features. What ETS model would be appropriate for forecasting this data?

    ```r
    h02 <- PBS |>
    filter(ATC2 == "H02") |>
    summarise(Cost = sum(Cost))
    ```

5. Find an `ETS` model and study it.

6. Generate forecasts for the next few years. 

7. Combine `STL` decomposition with `ETS` to forecast the `h02` series.

8. Exam 2024

      - Section A: Q1, Q2
      - Section B: Q3d, Q3e, Q3f 
      - Section C: all questions
