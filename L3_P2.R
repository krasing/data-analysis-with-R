# The Gapminder website contains over 500 data sets with information about
# the world's population. Your task is to download a data set of your choice
# and create 2-5 plots that make use of the techniques from Lesson 3.

# You might use a simple histogram, a boxplot split over a categorical variable,
# or a frequency polygon. The choice is yours!

# You can find a link to the Gapminder website in the Instructor Notes.

# Once you've completed your investigation, create a post in the discussions that includes:
#       1. any questions you answered, your observations, and summary statistics
#       2. snippets of code that created the plots
#       3. links to the images of your plots

# Copy and paste all of the code that you used for
# your investigation, and submit it when you are ready.
# ====================================================================================

alcohol = read.csv('indicator alcohol consumption.csv', header = T, row.names = 1, check.names = F)

summary(alcohol)
qplot(data = alcohol, x = alcohol$'2008', binwidth = 2)

summary(alcohol$'2008')

library(tidyr)
alcohol$country = rownames(alcohol)
alcohol <- gather(alcohol, 'year', 'quantity', 1:24)
alcohol = subset(alcohol, !is.na(quantity))

qplot(x = quantity, data = subset(alcohol, year==2005 | year==2008),
      geom = 'freqpoly', color = year, binwidth = 2.5,
      xlab = 'Alcohol consumption per adult (15+), litres',
      ylab = 'Number of countries')
ggsave('alcohol_by_year.png')
head(alcohol)

# install.packages("countrycode")
library(countrycode)

alcohol$continent = countrycode(alcohol$country, "country.name", "continent")
alcohol$region = countrycode(alcohol$country, "country.name", "region")

qplot(x = continent, y = quantity, data = alcohol, geom = 'boxplot')
ggsave('alcohol_by_continent.png')
