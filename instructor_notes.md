
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


## Packages used

* knitr
    library(ggplot2)
    library(gridExtra)
    library(psych)
    library(dplyr)  # error
    library(scales)
    library(memisc)

## Code snippets

### Load data

    income <- read.csv("data/ACS_13_5YR_S1903/ACS_13_5YR_S1903.csv",
        stringsAsFactors=FALSE, sep=",", colClasses=c("GEO.id2"="character"))

### Review data

    head(income)
    dim(income)
    names(income)
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

