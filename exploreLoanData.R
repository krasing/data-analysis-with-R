# loans = read.csv('prosperLoanData.csv',    stringsAsFactors = FALSE)
loans <- read.csv('prosperLoanData.csv')
dict <- read.delim('Prosper Loan Data - Variable Definitions.tsv')
names(loans)
View(dict)
str(loans)
# 
summary(loans)

hist(loans$BorrowerAPR, 100) # merged several distr.

table(loans$Recommendations) # convert to 0, 1, 2, 3, 4, >4

hist(loans$InvestmentFromFriendsAmount[loans$InvestmentFromFriendsAmount>0], 40)

sum(loans$InvestmentFromFriendsAmount>0) # total with friend investment
# check the average investment per friend

hist(loans$LoanOriginalAmount, 100)
nonStandard = subset(loans, LoanOriginalAmount!=25000, c(LoanOriginalAmount))
hist(nonStandard$LoanOriginalAmount, 100)
# most popular amounts
tail(sort(table(loans$LoanOriginalAmount)), 20)
# most total cumulative
amountCount = tail(sort(table(loans$LoanOriginalAmount)), 20)
amountValues = as.double(names(amountCount))
cumulativeAmmount = amountValues*amountCount
sort(cumulativeAmmount)

# many variables has in their description
# "This value will be null if the borrower had no prior loans. "


m <- ggplot(data = loans, aes(x = DebtToIncomeRatio))
m + geom_histogram(binwidth = 0.05) + xlim(0, 1)
m + geom_histogram(aes(y = ..density..), binwidth = 0.02) + geom_density() + xlim(0, 1)

hist(loans$DebtToIncomeRatio, seq(0,12,0.05), xlim=c(0,1))
