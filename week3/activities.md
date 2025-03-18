
1. Find an appropriate Box-Cox transformation in order to stabilise the variance for Gas production from `aus_production`.

2. Why is a Box-Cox transformation unhelpful for the `canadian_gas` data?

3. Produce the following decomposition for the number (in thousands) of of people employed in Retail Trade in the US

    ```r
    us_retail_employment <- us_employment |>
      filter(year(Month) >= 1990, Title == "Retail Trade") |>
      select(-Series_ID)

    dcmp <- us_retail_employment |>
            model(stl = STL(Employed)) 
    ```
    
    a. Plot the decomposition.
    
    b. Fit the trend component over the data [Hint: you can use `autolayer()` to add `trend` to the plot above. `trend` is one of the variables returned by `STL()`. ]
    
    c. Fit the trend and the seasonally adjusted [Hint: `seas_adjust` is one of the variables returned by `STL`. ]
    
    d. How does the seasonal shape change over time? [Hint: Try plotting the seasonal component using `gg_season()`.]
    
    e. What happens as you change the values of the two `window` arguments?
    
    f. Can you produce a plausible seasonally adjusted series? 

4. Exam 2024 

    - Section A: Q6 (just for information at the moment)
    - Section B: Q1, Q2
    - Solutions [[week3_Exam2024_solutions.pdf](week3_Exam2024_solutions.pdf)]
