# Useful libraries used
library(skimr)
library(data.table)
library(RCurl)
library(VIM)
library(caret)
library(sos)
library(dplyr)
library(mice)
library(tidyr)
library(lubridate)
library(ggplot2)

# Increase the max amount of rows to display in console
options(max.print = 1000) # Up to 1000 rows

# Load the data set into a variable
mydata <- fread("/Users/Jairr/OneDrive/Desktop/region_12.csv") # Do not forget to implement your own path

# Check how the data is structured and inspect the statistics
str(mydata)
summary(mydata)
View(mydata) # Table view of the data (Easier to look at and understand)

# Check for missing data
missing_values <- is.na(mydata)
print(missing_values)
sum(is.na(mydata)) # Show the total amount of missing values within the data set
aggr(mydata, col=c('navyblue', 'red' ), sortVars=TRUE, labels=names(mydata), cex.axis=.7, gap=3) # Plot the distribution of missing data based on variables

# Check for duplicates within the file
duplicated_rows <- duplicated(mydata)
mydata[duplicated_rows, ] # Looks like no duped rows

# ---------------------------------------

# Now cleaning up the data set
# Remove columns with more than 75% NA
mydata[, which(colMeans(!is.na(mydata)) > 0.75)]
View(mydata)

# ---------------------------------------------------

# Lets take a different approach and select some variables
filtered_data <- mydata%>%
  filter(iday != 0) %>% # Filter out where iday = 0 (it makes no sense for a day to start at 0 // possible misleading data)
  select(iyear, imonth, iday, country_txt, city, latitude, longitude, success, attacktype1_txt, targtype1_txt, weaptype1_txt, nkill, nwound)%>% # Select variables we want to do an analysis done
  mutate(nkill = replace_na(nkill, round(mean(nkill, na.rm = TRUE)))) %>% # Fill in the missing data with the average (rounded because there can not be fraction of a whole entity)
  mutate(nwound = replace_na(nwound, round(mean(nwound, na.rm = TRUE)))) %>% # Same as above
  mutate(date = make_date(iyear, imonth, iday)) %>% # Combine the date to see the stats of a specific time (keeping the original 3)
  mutate(missing_coordinates = ifelse(is.na(longitude) | is.na(latitude), TRUE, FALSE))

data_with_coordinates <- filtered_data %>% # Full data where there are no missing values
  filter(!missing_coordinates)

data_with_missing <- filtered_data %>% # Complete data with some missing values
  filter(missing_coordinates)
  
write.csv(data_with_coordinates, "NM_filtered_data_region_12.csv", row.names = FALSE)
write.csv(data_with_missing, "M_filtered_data_region_12.csv", row.names = FALSE)

# We will be doing analysis on data that has no missing values (data_with_coordinates)
summary(data_with_coordinates)

# --------------------------------------------------------------------------------------------------------------------
# Plot 1

# Lets do an analysis on calculating the average number of kills and wounds per country.
data_with_coordinates %>%
  group_by(country_txt) %>%
  summarize(avg_kills = mean(nkill, na.rm = TRUE), avg_wounds = mean(nwound, na.rm = TRUE), total_attacks = n()) %>%
  arrange(desc(avg_kills))

# Lets proceed to visualize the data
data_with_coordinates %>%
  group_by(country_txt) %>%
  summarize(avg_kills = mean(nkill, na.rm = TRUE)) %>%
  ggplot(aes(x = reorder(country_txt, avg_kills), y = avg_kills)) + geom_bar(stat = "identity") + coord_flip() + labs(title = "Average Number of Kills per Country", x = "Country", y = "Average Kills")

# --------------------------------------------------------------------------------------------------------------------
# --------------------------------------------------------------------------------------------------------------------
# Plot 2

# Lets do an analysis on which attack types were most successful
data_with_coordinates %>%
  group_by(success) %>% 
  summarize(avg_kills = mean(nkill, na.rm = TRUE))

# --------------------------------------------------------------------------------------------------------------------
# --------------------------------------------------------------------------------------------------------------------
# Plot 3

# Lets do an analysis on the success rate for each attack type
attack_type_success <- data_with_coordinates %>%
  group_by(attacktype1_txt) %>%
  summarize(total_attacks = n(), successful_attacks = sum(success == 1, na.rm = TRUE), success_rate = (successful_attacks / total_attacks) * 100) %>%
  arrange(desc(success_rate))

summary(attack_type_success)

# Lets visualize it
ggplot(attack_type_success, aes(x = reorder(attacktype1_txt, success_rate), y = success_rate)) + geom_bar(stat = "identity", fill = "steelblue") + coord_flip() + labs(title = "Success Rate by Attack Type", x = "Attack Type", y = "Success Rate (%)") +
  theme_minimal()


# --------------------------------------------------------------------------------------------------------------------
# --------------------------------------------------------------------------------------------------------------------
# Plot 4

# Let do an analysis on the success rate for each weapon type
weapon_type_success <- data_with_coordinates %>%
  group_by(weaptype1_txt) %>%
  summarize(total_attacks = n(), successful_attacks = sum(success == 1, na.rm = TRUE), success_rate = (successful_attacks / total_attacks) * 100) %>%
  arrange(desc(success_rate))

summary(weapon_type_success)

# Lets visualize it
ggplot(weapon_type_success, aes(x = reorder(weaptype1_txt, success_rate), y = success_rate)) +
  geom_bar(stat = "identity", fill = "darkorange") +
  coord_flip() +
  labs(title = "Success Rate by Weapon Type", x = "Weapon Type", y = "Success Rate (%)") +
  theme_minimal()
  

