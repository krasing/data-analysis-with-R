# load 'diamonds' dataset

library(ggplot2)
data(diamonds)

dim(diamonds)
str(diamonds)
?diamonds
levels(diamonds$color)

# Create a histogram of the price of
# all the diamonds in the diamond data set.

# TYPE YOUR CODE BELOW THE LINE
# =======================================

qplot(x = price, data = diamonds)
summary(diamonds$price)


sum(diamonds$price < 500)
sum(diamonds$price >= 15000)

# Explore the largest peak in the
# price histogram you created earlier.

# Try limiting the x-axis, altering the bin width,
# and setting different breaks on the x-axis.

# There won’t be a solution video for this
# question so go to the discussions to
# share your thoughts and discover
# what other people find.

# You can save images by using the ggsave() command.
# ggsave() will save the last plot created.
# For example...
#                  qplot(x = price, data = diamonds)
#                  ggsave('priceHistogram.png')

# ggsave currently recognises the extensions eps/ps, tex (pictex),
# pdf, jpeg, tiff, png, bmp, svg and wmf (windows only).

# Submit your final code when you are ready.

# TYPE YOUR CODE BELOW THE LINE
# ======================================================================

qplot(x = price, data = diamonds, binwidth = 1) +
  coord_cartesian(xlim = c(350,1600)) +
  scale_x_continuous(breaks = seq(400, 1600, 100))

ggsave('priceHistogram.png')
ggsave('priceHistogram.pdf')

  
g1 = ggplot(data = diamonds, aes(x=price)) + coord_cartesian(xlim = c(350,1600))
g1 = g1 + scale_x_continuous(breaks = seq(400, 1600, 100))
g1 + geom_histogram(binwidth = 20)
g1 + geom_histogram(binwidth = 1)

# Break out the histogram of diamond prices by cut.

# You should have five histograms in separate
# panels on your resulting plot.

# TYPE YOUR CODE BELOW THE LINE
# ======================================================

g1 = ggplot(data = diamonds, aes(x=price))
g1 = g1 + scale_x_log10() + geom_histogram()
g1 + facet_wrap(~cut)

# Which cut has the highest priced diamond? And lowest? Lowest median?
by(diamonds$price, diamonds$cut, summary)
by(diamonds$price, diamonds$cut, max)
by(diamonds$price, diamonds$cut, min)

max(getOption('digits'))

# In the two last exercises, we looked at
# the distribution for diamonds by cut.

# Run the code below in R Studio to generate
# the histogram as a reminder.

# ===============================================================

qplot(x = price, data = diamonds) + facet_wrap(~cut)

# ===============================================================

# In the last exercise, we looked at the summary statistics
# for diamond price by cut. If we look at the output table, the
# the median and quartiles are reasonably close to each other.

# diamonds$cut: Fair
#    Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
#     337    2050    3282    4359    5206   18570 
# ------------------------------------------------------------------------ 
# diamonds$cut: Good
#    Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
#     327    1145    3050    3929    5028   18790 
# ------------------------------------------------------------------------ 
# diamonds$cut: Very Good
#    Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
#     336     912    2648    3982    5373   18820 
# ------------------------------------------------------------------------ 
# diamonds$cut: Premium
#    Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
#     326    1046    3185    4584    6296   18820 
# ------------------------------------------------------------------------ 
# diamonds$cut: Ideal
#    Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
#     326     878    1810    3458    4678   18810 

# This means the distributions should be somewhat similar,
# but the histograms we created don't show that.

# The 'Fair' and 'Good' diamonds appear to have 
# different distributions compared to the better
# cut diamonds. They seem somewhat uniform
# on the left with long tails on the right.

# Let's look in to this more.

# Look up the documentation for facet_wrap in R Studio.
# Then, scroll back up and add a parameter to facet_wrap so that
# the y-axis in the histograms is not fixed. You want the y-axis to
# be different for each histogram.

# If you want a hint, check out the Instructor Notes.

qplot(x = price, data = diamonds) + facet_wrap(~cut, scales="free_y")


# Create a histogram of price per carat
# and facet it by cut. You can make adjustments
# to the code from the previous exercise to get
# started.

# Adjust the bin width and transform the scale
# of the x-axis using log10.

# Submit your final code when you are ready.

# ENTER YOUR CODE BELOW THIS LINE.
# ===========================================================================




# ===========================================================================
summary(diamonds$carat)

qplot(data = diamonds, x = carat, geom = 'freqpoly')

qplot(data = diamonds, x = carat, geom = 'freqpoly', binwidth = 0.1) +
scale_x_continuous(limits = c(0, 3), breaks = seq(0, 3, 0.2))

qplot(data = diamonds, x = carat, geom = 'freqpoly', binwidth = 0.001) +
scale_x_continuous(limits = c(0.9, 1.1))

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
