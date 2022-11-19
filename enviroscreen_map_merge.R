library(tidyverse)

library(readr)
census_tract <- read_csv("census_tract.csv")
View(census_tract)

library(readr)
environ_creen_tract_data_for_map_merge <- read_csv("environ_creen_tract_data_for_map_merge.csv")
View(environ_creen_tract_data_for_map_merge)

# I actually found Census data that is closer to the environ data. 1249 rows. 
  # Download from TIGER Census database: https://www.census.gov/geographies/mapping-files/time-series/geo/tiger-line-file.2018.html#list-tab-QKL48SE7HLNA9KOA57
  # Download from here: https://www2.census.gov/geo/tiger/TIGER2018/TRACT/ 
  # Pull 08 because that's the CO state code
  # Convert from shapefile to GeoJSON using Mapshaper and then upload to Flourish
    # https://mapshaper.org/ 

library(readr)
census_tract_2 <- read_csv("census_tract_2.csv")
View(census_tract_2)

left_join(census_tract_2, environ_creen_tract_data_for_map_merge, by = "geoid") %>% 
  View()

  # matched on 1249 rows. 

# What didn't match?

geoid_environ_creen_tract_data_for_map_merge <- environ_creen_tract_data_for_map_merge %>% 
    select(geoid)
  

anti_join(census_tract_2, geoid_environ_creen_tract_data_for_map_merge, by = "geoid") %>% 
  View()

  # Only a handful of Census tracts that isn't in 
    # 8007940400
    # 8083941100
    # 8067940300
    # 8067940400

# CDPHE said they actually used 2010 Census tract files and will likely update to 2020 next year
  # Did the same conversion process as above but for 2010 and not 2018: https://www2.census.gov/geo/tiger/TIGER2010/TRACT/2010/ 
  # File name: tl_2010_08_tract10.zip

library(readr)
census_tract_3 <- read_csv("census_tract_3.csv")
View(census_tract_3)

left_join(census_tract_3, environ_creen_tract_data_for_map_merge, by = "geoid") %>% 
  View()

  # Still 1249 rows, same in 2018 as 2010

anti_join(census_tract_3, geoid_environ_creen_tract_data_for_map_merge, by = "geoid") %>% 
  View()

  # Same 4 rows aren't in either. 

      # geoid
        # 8067940300
        # 8067940400
        # 8083941100
        # 8007940400

  # Possibility could be tribal land not submitting data to CDPHE for EnviroScreen

# Time to export

merged_census_2010_environ <- left_join(census_tract_3, environ_creen_tract_data_for_map_merge, by = "geoid")

merged_census_2010_environ %>% write_csv("merged_census_2010_environ.csv", na = "")
