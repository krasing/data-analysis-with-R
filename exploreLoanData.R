# loan = read.csv('prosperLoanData.csv',    stringsAsFactors = FALSE)
loan = read.csv('prosperLoanData.csv')
names(loan)
str(loan)
# 
summary(loan)

hist(loan$BorrowerAPR, 100) # merged several distr.

table(loan$Recommendations) # convert to 0, 1, 2, 3, 4, >4

hist(loan$InvestmentFromFriendsAmount[loan$InvestmentFromFriendsAmount>0], 40)

sum(loan$InvestmentFromFriendsAmount>0) # total with friend investment
# check the average investment per friend

hist(loan$LoanOriginalAmount, 100)
nonStandard = subset(loan, LoanOriginalAmount!=25000, c(LoanOriginalAmount))
hist(nonStandard$LoanOriginalAmount, 100)
# most popular amounts
tail(sort(table(loan$LoanOriginalAmount)), 20)
# most total cumulative
amountCount = tail(sort(table(loan$LoanOriginalAmount)), 20)
amountValues = as.double(names(amountCount))
cumulativeAmmount = amountValues*amountCount
sort(cumulativeAmmount)

# many variables has in their description
# "This value will be null if the borrower had no prior loans. "