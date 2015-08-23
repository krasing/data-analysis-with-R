# Your task is to investigate the distribution of your friends'
# birth months and days.

# Here some questions you could answer, and we hope you think of others.

# **********************************************************************

# How many people share your birthday? Do you know them?
# (Reserve time with them or save money to buy them a gift!)

# Which month contains the most number of birthdays?

# How many birthdays are in each month?

# Which day of the year has the most number of birthdays?

# Do you have at least 365 friends that have birthdays on everyday
# of the year?

# **********************************************************************

# You will need to do some data munging and additional research to
# complete this task. This task won't be easy, and you may encounter some
# unexpected challenges along the way. We hope you learn a lot from it though.

# You can expect to spend 30 min or more on this task depending if you
# use the provided data or obtain your personal data. We also encourage you
# to use the lubridate package for working with dates. Read over the documentation
# in RStudio and search for examples online if you need help.

# You'll need to export your Facebooks friends' birthdays to a csv file.
# You may need to create a calendar of your Facebook friends’ birthdays
# in a program like Outlook or Gmail and then export the calendar as a
# csv file.

# Once you load the data into R Studio, you can use the strptime() function
# to extract the birth months and birth days. We recommend looking up the
# documentation for the function and finding examples online.

# We've included some links in the Instructor Notes to help get you started.

# Once you've completed your investigation, create a post in the discussions that includes:
#       1. any questions you answered, your observations, and summary statistics
#       2. snippets of code that created the plots
#       3. links to the images of your plots

# You can save images by using the ggsave() command.
# ggsave() will save the last plot created.
# For example...
#                  qplot(x = price, data = diamonds)
#                  ggsave('priceHistogram.png')

# ggsave currently recognises the extensions eps/ps, tex (pictex),
# pdf, jpeg, tiff, png, bmp, svg and wmf (windows only).

# Copy and paste all of the code that you used for
# your investigation below the line. Submit it when you are ready.
# ===============================================================================

colClasses = c('numeric', 'character', 'character')
birthdays = read.table('facebook_birthdays.ics.csv', 
                       sep = "\t", colClasses = colClasses)
birthdays[birthdays[1]==min(birthdays[1])]
names(birthdays) <- c('id', 'name', 'date')
birthdays$date <- as.Date(birthdays$date, format = "%Y%m%d")

library(ggplot2)
qplot(x=date, data = birthdays) +
  scale_x_date(labels = date_format("%m"))
summary(birthdays$date)

# How many people share your birthday? Do you know them?
sum(birthdays$date == as.Date("0819", format = "%m%d"))
birthdays[birthdays$date == as.Date("0819", format = "%m%d"),]

# Extract month and weekday
birthdays$month = months(birthdays$date)
birthdays$weekday = weekdays(birthdays$date)

# Which month contains the most number of birthdays?
sort(table(birthdays$month))

library("lubridate")
Меbirthdays$day = day(birthdays$date)
birthdays$month = month(birthdays$date)
# birthdays per month
table(birthdays$month)

# some histograms. Why not constant distance beteen bars?
# Solved by converting to factor. Compare:

qplot(month, data = birthdays) + scale_x_discrete(breaks = seq(1,12,1))
qplot(factor(month), data = birthdays) + scale_x_discrete(breaks = seq(1,12,1))

qplot(day, data = birthdays) + scale_x_discrete()

# the days with most birthdays
tail(sort(table(birthdays$date)))
date_decimal(20141223)
year(birthdays$date) = 2000

# birthdays per day
qplot(x=date, data = birthdays, binwidth = 1)

# Some hints from the forum

birthdays$month <- ordered(strftime(birthdays$dates, '%b'), levels = month.abb)

birthdays2 <- dplyr::arrange(birthdays, date) # sort

# dates <- seq(min.date, max.date, by = "day")
# You could create such a sequence using the first and last dates in your data, convert the sequence to a data frame, and then use dplyr's anti_join to join the two data sets leaving only the dates that were not in your original data frame (I have tested this here in the console). For more information about anti_join, see the "Combine Data Sets" section of the dplyr cheat sheet here. Hope that helps!
dates <- seq(as.Date("2015-01-01"), as.Date("2015-12-31"), by = "day")
dates <- as.data.frame(dates, "dates")
dates$dates <- as.Date(dates$dates)
bdays <- birthdays$Date
bdays <- as.data.frame(bdays)
bdays$dates <- as.Date(bdays$bdays)
bdays <- select(bdays, -bdays)
aj <- anti_join(dates, bdays)

# As another option for approaching the problem, you could take your Date column and use string-formatting functions to convert it from a %m/%d/%Y format into a day of the year format (see the help page for strptime or strftime for the list of time format specifications). Then you can apply the unique() function to the column of days of the year and then use the setdiff() function against a reference vector of all possible year days (the numbers from 1 to 366, use the seq function) to get the list of unmatched days.
birthdays$YearDay <- strftime(birthdays$date, "%j")
unique(birthdays$YearDay)
daydiff <- setdiff(unique(birthdays$YearDay), 1:366)
strptime(daydiff, "%j")
