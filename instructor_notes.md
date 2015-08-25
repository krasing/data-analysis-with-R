
## Swirl

We recommend anyone new to R and RStudio to try Swirl (statistics with interactive R learning). Swirl is a software package for the R statistical programming language. Its purpose is to teach statistics and R commands interactively.

Type the following commands in the Console, pressing Enter or Return after each line: 

    install.packages("swirl") 
    library(swirl) 
    swirl()

Note that the > symbol at the beginning of the line is R's prompt for you type something into the console. We include it here so you know that the above commands are to be typed into the console and not elsewhere. The part you type begins after >. 

## Usefull links

[Loading data into R by Nathan Yau] (http://flowingdata.com/2015/02/18/loading-data-and-basic-formatting-in-r/)

[Factor variables] (http://statistics.ats.ucla.edu/stat/r/modules/factor_variables.htm)

Data mungling, [Tidy Data by Hadley Wickham] (http://vita.had.co.nz/papers/tidy-data.pdf)

[Tidy Data Presentation by Hadley Wickham, June 2012] (http://courses.had.co.nz.s3-website-us-east-1.amazonaws.com/12-rice-bdsi/slides/07-tidy-data.pdf)


## People

[Eytan Bakshy](http://www-personal.umich.edu/~ebakshy/)

[Sean Taylor] (http://seanjtaylor.com/)

[Lada Adamic] (http://www.ladamic.com/)


## Packages used

    * knitr
    library(ggplot2)
    library(gridExtra)
    library(psych)
    library(dplyr)  # error
    library(scales)
    library(memisc)

    
    install.packages("dplyr")
    Error: package ‘Rcpp’ 0.11.3 was found, but >= 0.11.6 is required by ‘dplyr’
    install.packages("~/Downloads/Rcpp_0.12.0.tar.gz", repos = NULL, type = "source")
    install.packages("dplyr")
    install.packages("tidyr")

## First steps

### Load data
    
    getwd()
    list.files()
    income <- read.csv("data/ACS_13_5YR_S1903/ACS_13_5YR_S1903.csv",
        stringsAsFactors=FALSE, sep=",", colClasses=c("GEO.id2"="character"))

### Review data

    head(income)
    dim(income)
    names(income) # get all variables
    str(income)
    summary(income)

### Merge datasets

    income0813 <- merge(income2008p, income2013p, by="FIPS")
    
### Write dataframe in file

    write.table(income_total, "data/income-totals.csv",
    row.names=FALSE, sep=",")


### Ordered factors
    ses.order <- ordered(ses, levels = c("low", "middle", "high"))
    levels = c("low", "middle", "high")
    reddit$age.range <- factor(reddit$age.range, levels=levels, ordered = TRUE)

## Single variables

Basic statistics (mean, median, boxplots, and histograms) and the qplot syntax in R

Let the data surprise you! What is going on with youd data? Which are the most central variables?
Define a question you are trying to answer, e.g. comparison of two groups,
Whether people perception for their audience matches the reality, who actually is seeing the content they are sharing.
Detecting anomalities is important. As example, more values for a default value in a survey

    qplot(x = dob_day, data = pf) +
      scale_x_discrete(breaks = 1:31) +
      facet_wrap(~dob_month, ncol = 3)
      
      facet_grid(vertical ~ horizontal, ncol = 3)
      
    ggplot(data = pf, aes(x = dob_day)) + 
      geom_histogram() + 
       scale_x_discrete(breaks = 1:31) + 
       facet_wrap(~dob_month)

### Facets
[Facets link] (http://www.cookbook-r.com/Graphs/Facets_(ggplot2)/)
By default all graphs have the same axes scales.
This can be changed - [free scales] (http://www.cookbook-r.com/Graphs/Facets_(ggplot2))
add parameter scales="free_y"


### Limiting the axes

    qplot(data = pf, x = friend_count, xlim = c(0, 1000))
    
    qplot(data = pf, x = friend_count) +
      scale_x_continuous(limits = c(0, 1000))
    # layer was added
    # limit removes data points from the calculations, not just adjust the axes!
    
### Adjusting the bin width and brakes

    qplot(data = pf, x = friend_count, binwidth = 25) +
      scale_x_continuous(limits = c(0, 1000), breaks = seq(0, 1000, 50))
      
    ggplot(aes(x = friend_count), data = pf) + 
      geom_histogram(binwidth = 25) + 
      scale_x_continuous(limits = c(0, 1000), breaks = seq(0, 1000, 50))

[Scales in ggplot2](http://docs.ggplot2.org/current/scale_continuous.html)

### Omitting NA observations

    # in the equation abobe use:
    data = subset(pf, !is.na(gender))  # remove records with missing gender info
    data = na.omit(pf)  # remove records with any missing data
    
### *Statistics by category*

    by(pf$friend_count, pf$gender, summary)
    
    # find the interquartile range    
    IQR(subset(diamonds, price <1000)$price)


### Adding color

    qplot(x = tenure, data = pf, binwidth = 30,
          color = I('black'), fill = I('#099DD9'))
          
    # binwidth = 30 - visualize by months
    # binwidth = 365 - visualize by years
    
    qplot(x = tenure/365, data = pf, binwidth = 0.25,
          color = I('black'), fill = I('#F79420')) +
          scale_x_continuous(limits = c(0, 7), breaks = seq(1, 7, 1))

The parameter `color` determines the color *outline* of objects in a plot. 

The parameter `fill` determines the color of the *area* inside objects in a plot. 

You might notice how the color `black` and the hex code color of `#099DD9` (a shade of blue) are wrapped inside of `I()`. The `I()` functions stand for 'as is' and tells qplot to use them as colors. 

Learn more about what you can adjust in a plot by reading the [ggplot theme documentation] (http://docs.ggplot2.org/0.9.2.1/theme.html) 

Equivalent ggplot syntax: 

    ggplot(aes(x = tenure), data = pf) + 
       geom_histogram(binwidth = 30, color = 'black', fill = '#099DD9')
       
### Labels
xlab(), ylab()

    qplot(x = tenure/365, data = pf, binwidth = 0.25,
          xlab = 'Number of years using facebook',
          ylab = 'Number of users in sample',
          color = I('black'), fill = I('#F79420')) +
          scale_x_continuous(limits = c(0, 7), breaks = seq(1, 7, 1))
          
Equivalent ggplot syntax:

    ggplot(aes(x = tenure / 365), data = pf) + 
      geom_histogram(color = 'black', fill = '#F79420') + 
      scale_x_continuous(breaks = seq(1, 7, 1), limits = c(0, 7)) +
      xlab('Number of years using Facebook') + 
      ylab('Number of users in sample')
      
### Transforming Data

    summary(pf$friend_count)
    summary(log10(pf$friend_count + 1))
    summary(sqrt(pf$friend_count))
    
"Around 0:25 Chris mentions that the data is over-dispersed. "Over-dispersed" is always relative to some particular posited distribution. For example, data might be over-dispersed compared with a Poisson distribution with that mean."

[Create Multiple Plots in One Image Output] (http://lightonphiri.org/blog/ggplot2-multiple-plots-in-one-graph-using-gridextra)

[Add Log or Sqrt Scales to an Axis] (http://docs.ggplot2.org/current/scale_continuous.html)

    install.packages("gridExtra")
    # define individual plots
    p1 = ggplot(...)
    p2 = ggplot(...)
    p3 = ggplot(...)
    p4 = ggplot(...)
    # arrange plots in grid
    grid.arrange(p1, p2, p3, p4, ncol=2)

### Frequency Polygons
Notes: Frequency polygon is used to present two or more distributions on one plot for comparison

Looking at:

    qplot(x = friend_count, data = pf, binwidth = 10) +
      scale_x_continuous(limits = c(0, 1000),
                         breaks = seq(0, 1000, 50)) +
      facet_wrap(~gender)
      
By default qplot creates frequency histogram when passed one variable. Use geom parameter to tell it to do something else, e.g. `geom = 'freqpoly'` to generate fequency poligon.

The layer `facet_wrap(~gender)` can be replaced by parameter `color = gender` to have both lines on a single plot.

To show proportions instead of counts add y axes: `y = ..count../sum(..count..)`

### Box Plots

    geom = 'boxplot'
    
The continuous variable is used as y and the categorical variable as x!!!

```{r}
    qplot(x = gender, y = friend_count,
          data = subset(pf, !is.na(gender)),
          geom = 'boxplot')
```

Adjusting the code to focus on users who have friend counts between 0 and 1000.
Using ylim parameter or limits in scale_y layer removes data and can change the plot.
Need `coord_cartesian` layer to be used:

    coord_cartesian(ylim = c(0,1000))

View numbers

    by(pf$friend_count, pf$gender, summary)

### Getting Logical
Transformation to binary variable

```{r Getting Logical}
summary(pf$mobile_likes)

summary(pf$mobile_likes > 0)

pf$mobile_check_in <- NA
pf$mobile_check_in <- ifelse(pf$mobile_likes > 0, 1, 0)
pf$mobile_check_in <- factor(pf$mobile_check_in)
summary(pf$mobile_check_in)

summary(pf$mobile_check_in) / sum(summary(pf$mobile_check_in))

sum(pf$mobile_check_in == 1) / length(pf$mobile_check_in)
```

### Summary

  - Take a close look at the individual variables in your datasets
    - types of values
    - distribution shape
    - are there missing values or outliers

### Save image

`ggsave()` will save the last plot created. Recognised the extensions:
eps/ps, tex (pictex), pdf, jpeg, tiff, png, bmp, svg and wmf (windows only).

    ggsave('priceHistogram.png')

## Data Wrangling with R

Data munging or data wrangling can take up much of a data scientist's or data analyst's time. There are two R packages that make these tasks easier in R: tidyr and dplyr.

`tidyr` - a package that reshapes the layout of your data

`dplyr` - a package that helps you transform tidy, tabular data

Review [Data Wrangling in R](#) to get a sense of how these packages allow you to manipulate data. You can use these packages to help you in the next programming task and in your future investigations.

You may also download this useful [Data Wrangling Cheat Sheet] (http://www.rstudio.com/wp-content/uploads/2015/02/data-wrangling-cheatsheet.pdf). There are some other useful cheat sheets at [RStudio] (http://www.rstudio.com/resources/cheatsheets/).

Colapse multiple columns into two columns:

    gather(dataframe, 'new_key', 'new_value', col2:col4)

Spread - generate multiple columns from two columns:

    spread(dataset, keys_column, values_column)
    
Separate - split a column by a character string separator:

    separate(storms, date, c("year", "month", "day"), sep = "-")

Unite columns into a single column.

    unite(storms2, "date", year, month, day, sep = "-")


### Gapminder Data 

[Gapminder Data](http://www.gapminder.org/data/)

[Hans Rosling's 200 Countries, 200 Years, 4 Minutes] (https://www.youtube.com/watch?v=jbkSRLYSojo) 

Save plots using ggsave()

The following command may be helpful for some of the Gapminder Data sets, once it's been converted to csv format: `read.csv('data.csv', header = T, row.names = 1, check.names = F)`. You may want to look at additional function arguments in the help file for the `read.table()` family for additional tools that can help you read in data.

If you want to exchange the rows and columns of your dataframe, it will also be useful to know the transpose function, `t()`.

### Exploring Your Friends' Birthdays

[Download Your Friends' Birthdays from Facebook] (https://www.facebook.com/help/152652248136178/)

[Date Formats in R] (http://www.r-bloggers.com/date-formats-in-r)

[Export a Google Calendar] (https://support.google.com/calendar/answer/37111?hl=en)

[Google Calendar to Excel: Free Trial](http://www.gcal2excel.com/)

### Dates

    birthdays$month <- ordered(strftime(birthdays$dates, '%b'), levels = month.abb)
    

## Two variables

```r
qplot(x = age, y = friend_count, data = pf)

qplot(age, friend_count, data = pf)

ggplot(aes(x = age, y = friend_count), data = pf) + 
  geom_point(alpha = 1/20, position=position_jitter(h=0))  +
  xlim(30,90) +
  coord_trans()
```

    geom_point(position='jitter')

### ggplot

[ggplot2 graphics] (http://docs.ggplot2.org/current/)

[ggplot2 tutorial by Ramon Saccilotto] (http://www.ceb-institute.org/bbs/wp-content/uploads/2011/09/handout_ggplot2.pdf)

geom_point(alpha = 1/20) 

[coord_trans()](http://docs.ggplot2.org/current/coord_trans.html)

### Instructor notes

*Important Notice!* Please note that in newer versions of dplyr (0.3.x+), the syntax %.% has been deprecated and replaced with %>%. To run your code in the Udacity IDE you must use %.%, but if you are following along on your local machine and using R, this may produce warning messages, in which case you should use %>% instead.

Another warning: Version 0.4 of R has a bug when using the median function on the summarize layer, depending on the nature of the data being summarized. You may need to cast the data as a numeric (float) type when using it on your local machine, e.g. `median(as.numeric(var))`.

Learn more about the [dplyr package](http://blog.rstudio.org/2014/01/17/introducing-dplyr/). 

[Introduction to dplyr] (http://rstudio-pubs-static.s3.amazonaws.com/11068_8bc42d6df61341b2bed45e9a9a3bf9f4.html) (knitted html file)

The following tutorials are presented by Hadley Wickham at useR 2014.

 - [Introduction of dplyr] (http://www.r-bloggers.com/hadley-wickham-presents-dplyr-at-user-2014/)
 - [dplyr Tutorial Part 1] (http://www.r-bloggers.com/hadley-wickhams-dplyr-tutorial-at-user-2014-part-1/)
 - [dplyr Tutorial Part 2] (http://www.r-bloggers.com/hadley-wickhams-dplyr-tutorial-at-user-2014-part-2/)
 
There are other ways to work with data and create new data frames without using the dplyr package. Learn about the R functions `lapply`, `tapply`, and `split` in a [blog post] (http://rollingyours.wordpress.com/2014/10/20/the-lapply-command-101/).

### Instructor Notes

To zoom in, the code should use `thecoord_cartesian(xlim = c(13, 90))` layer rather than `xlim(13, 90)` layer.

Look up documentation for `coord_cartesian()` and `quantile()` if you're unfamiliar with them. 

Try an example and practice problem for calculating [quantiles (percentiles)] (http://www.r-tutor.com/elementary-statistics/numerical-measures/percentile).

See Moira's final plot and how she aligned the histograms with the scatterplots in the published paper.

[Bernstein, M. S., Bakshy, E., Burke, M., & Karrer, B. (2013). Quantifying the invisible audience in social networks. In Proceedings of the SIGCHI Conference on Human Factors in Computing Systems (CHI 2013), pp. 21-30.] (http://hci.stanford.edu/publications/2013/invisibleaudience/invisibleaudience.pdf)

### Correlations

[Correlation Methods: Pearson's r, Spearman's rho, and Kendall's tau] (http://www.statisticssolutions.com/correlation-pearson-kendall-spearman/)

### Instructor Notes

Argument matching (when not providing them by name) in R is a bit complex.

First, arguments (or parameters) can be matched by name. If a parameter matches exactly, it is "removed" from the argument list and the remaining unnamed arguments are matched in the order that they are listed in the function definition.

R does the following to match arguments... 

checks for exact match of named argument
checks for a partial match of the argument
checks for a positional match
If R does not find a match for a parameter, it typically throws an "unused" parameter error.

Type `str(functionName)` to find the order of the parameters and learn more about the parameters of an R function. 

The example covered in the next few videos comes from a practice problem in [Weisberg, S. (2005). Applied Linear Regression, 3rd edition. New York: Wiley] (http://users.stat.umn.edu/~sandy/alr3ed/website/).

### Instructor notes


The cor and cor.test functions determine the strength of a linear relationship, but they may miss other relationships in the data, e.g. if there is a cyclical pattern.

    ggplot(aes(x=(Month%%12),y=Temp),data=Mitchell)+ geom_point() 

**Data Visualization Pioneers**

 - [John Tukey] (http://en.wikipedia.org/wiki/John_Tukey)
 - [William Playfair] (http://en.wikipedia.org/wiki/William_Playfair)
 - [William Playfair and the Psychology of Graphs](http://www.psych.utoronto.ca/users/spence/Spence%20(2006).pdf)

There are other measures of associations that can detect this. The `dcor.ttest()` function in the energy package implements a non-parametric test of the independence of two variables. The test correctly rejects the independence.

### Smoothing conditional means

[Local Regression (LOESS)] (http://simplystatistics.org/2014/02/13/loess-explained-in-a-gif/) explained visually on the [Simply Statistics] (http://simplystatistics.org/) blog.

The Details of [Loess and Lowess] (http://en.wikipedia.org/wiki/Local_regression)