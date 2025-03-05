library(fpp3)

## Example: Pharmaceutical Benefits Scheme (PBS) is the Australian government drugs subsidy scheme. ----
# Costs are disaggregated by 
#    - drug type (ATC1 x15 / ATC2 84), 
#    - concession category (x2) 
#    - and patient type (x2), giving 84 × 2 × 2 = 336 time series.

PBS

# use filter() function to select rows - let's select A10.
PBS |> 
   filter(ATC2 == "A10")
   # 4 series

# use select() function to select columns - let's select Cost
PBS |> 
   filter(ATC2 == "A10") |> 
   select(Cost)
   #Notice index is always selected

PBS |>
   filter(ATC2 == "A10") |>
   select(Month, Concession, Type, Cost)

# use summarise() function to summarise over keys 
 PBS |>
   filter(ATC2 == "A10") |>
   select(Month, Concession, Type, Cost) |>
   summarise(total_cost = sum(Cost))
   # A single time series now

# use the mutate() function to create new variables
PBS |>
   filter(ATC2 == "A10") |>
   select(Month, Concession, Type, Cost) |>
   summarise(total_cost = sum(Cost)) |>
   mutate(total_cost = total_cost / 1e6) 
   # Turning into millions

PBS |>
   filter(ATC2 == "A10") |>
   select(Month, Concession, Type, Cost) |>
   summarise(total_cost = sum(Cost)) |>
   mutate(total_cost = total_cost / 1e6) -> a10

a10 <- PBS |>
   filter(ATC2 == "A10") |>
   select(Month, Concession, Type, Cost) |>
   summarise(total_cost = sum(Cost)) |>
   mutate(total_cost = total_cost / 1e6)

# Next week - let's plot and explore features
a10 |> autoplot()


## Example: Australian prison population ----
# Read a csv file and convert to a tsibble {-}

prison <- readr::read_csv("data/prison_population.csv") |> 
   # Notice we have a tibble - date has been automatically recognised as a date variable
   as_tsibble(
      index = date,
      key = c(state, gender, legal, indigenous)
   ) 

# Where is the problem? 
prison <- prison |> 
   mutate(date=yearquarter(date))


prison

prison |> distinct(state)
prison |> distinct(gender)
prison |> distinct(legal)
prison |> distinct(indigenous)

prison |> distinct(state, gender)

prison$state |> unique()
prison$state |> unique() |> as.matrix()

8*2*2*2

## Workshop activity ----
library(fpp3)

tourism |>
   as_tibble() |>
   group_by(Region, Purpose) |>
   summarise(Trips=mean(Trips)) |> #.groups = "drop"
   filter(Trips == max(Trips))

tourism |>
   group_by(State) |>
   summarise(Trips = sum(Trips)) |> 
   autoplot()
   