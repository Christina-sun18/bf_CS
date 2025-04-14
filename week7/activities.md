1. What sorts of transformations and differencing are needed to make the `Cement` series from `aus_production` stationary? Do the tests agree with your decisions? 

2. Generate the `a10` and the `h02` series from the `PBS` tsibble we explored earlier using the code below.

    ```r
    a10 <- PBS |>
      filter(ATC2 == "A10") |>
      summarise(Cost = sum(Cost))
      
    h02 <- PBS |>
      filter(ATC2 == "H02") |>
      summarise(Cost = sum(Cost))

    ```
What are the features of these series in terms of stationarity and what operations do you need to take to turn them into stationary series. 

3. Explore the the Algerian exports series from the `global_economy` tsibble. Is the series stationary? Is the series white noise?

4. Exam 2023

      - Section A: Q2, Q3
      - Section B: Q1, Q2, Q3 (a-f) 
      - Section C: all questions
