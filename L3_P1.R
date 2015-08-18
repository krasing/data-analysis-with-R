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

# Did you find normal-ish distributions and a slightly bimodal distribution for Very Good cuts?
# (If the Very Good facet looks smooth, try decreasing your bin width!
# If the data looks skewed, did you remember to perform a log10 transform?)

# ENTER YOUR CODE BELOW THIS LINE.
# ===========================================================================
qplot(x = price/carat, data = diamonds, binwidth = 0.05) +
  facet_wrap(~cut, scales="free_y") +
  scale_x_log10()


# Investigate the price of diamonds using box plots,
# numerical summaries, and one of the following categorical
# variables: cut, clarity, or color.

# There won’t be a solution video for this
# exercise so go to the discussion thread for either
# BOXPLOTS BY CLARITY, BOXPLOT BY COLOR, or BOXPLOTS BY CUT
# to share you thoughts and to
# see what other people found.

# Copy and paste all of the code that you used for
# your investigation, and submit it when you are ready.
# =================================================================
qplot(x = cut, y = price,
      data = diamonds,
      geom = 'boxplot')

qplot(x = color, y = price,
      data = diamonds,
      geom = 'boxplot')

qplot(x = clarity, y = price,
      data = diamonds,
      geom = 'boxplot')



by(diamonds$price/diamonds$carat, diamonds$cut, summary)

by(diamonds$price/diamonds$carat, diamonds$color, summary)

by(diamonds$price, diamonds$color, summary)
IQR(subset(diamonds, color == 'J')$price)
IQR(subset(diamonds, color == 'D')$price)

# Investigate the price per carat of diamonds across
# the different colors of diamonds using boxplots.

# SUBMIT YOUR CODE BELOW THIS LINE
# ===================================================================

qplot(x = cut, y = price/carat,
      data = diamonds,
      geom = 'boxplot')

qplot(x = color, y = price/carat,
      data = diamonds,
      geom = 'boxplot')

qplot(x = clarity, y = price/carat,
      data = diamonds,
      geom = 'boxplot')

