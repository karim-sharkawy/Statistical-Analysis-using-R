
# prepare ggplot library
library(ggplot2)

# set working directory and import US Data
setwd("C:/Users/jordan/Google Drive/Courses Spring 2018/STAT 350/STAT 350 Labs/Lab 02")
USData <- read.table("USData_Spring.txt", header=TRUE, sep="\t")

# clean US Data
USData_clean <- USData[complete.cases(USData),]

# use clean dataset
attach(USData_clean)


### PART B: TestScore ###

# print five-number summary
FNS <- fivenum(TestScore)
FNS

# print 1.5 IQR limits and find outliers
IQR <- FNS[4] - FNS[2]
IF_U <- FNS[4] + 1.5*IQR  # upper limit
IF_L <- FNS[2] - 1.5*IQR  # lower limit
IF_U
IF_L
Outlier_Index <- which(TestScore < IF_L | TestScore > IF_U)
Outliers <- TestScore[Outlier_Index]
Outliers

# make modified boxplot
windows()
ggplot(USData_clean, aes(x = "", y = TestScore)) +
  stat_boxplot(geom = "errorbar") +
  geom_boxplot() +
  ggtitle("Test Scores in the US") +
  stat_summary(fun.y = mean, col = "black", geom = "point", size = 3)

# make histogram
windows()
xbar <- mean(TestScore)
xmed <- median(TestScore)
s <- sd(TestScore)
ggplot(USData_clean, aes(TestScore)) +
  geom_histogram(aes(y = ..density..),
                 bins = sqrt(nrow(USData_clean))+2,
                 fill = "grey", col = "black") +
  geom_density(col = "red", lwd = 1) +
  stat_function(fun = dnorm, args = list(mean = xbar,
                                         sd = s),
                col = "blue", lwd = 1) +
  ggtitle("Test Scores in the US")

xbar
xmed
s
range(TestScore)

### PART C: Larcenies ###

# print five-number summary
FNS <- fivenum(LarceniesPerPopulation)
FNS

# print 1.5 IQR limits and find outliers
IQR <- FNS[4] - FNS[2]
IF_U <- FNS[4] + 1.5*IQR  # upper limit
IF_L <- FNS[2] - 1.5*IQR  # lower limit
IF_U
IF_L
Outlier_Index <- which(LarceniesPerPopulation < IF_L | LarceniesPerPopulation > IF_U)
Outliers <- LarceniesPerPopulation[Outlier_Index]
Outliers

# make modified boxplot
windows()
ggplot(USData_clean, aes(x = "", y = LarceniesPerPopulation)) +
  stat_boxplot(geom = "errorbar") +
  geom_boxplot() +
  ggtitle("Larcenies per Population in the US") +
  stat_summary(fun.y = mean, col = "black", geom = "point", size = 3)

# make histogram
windows()
xbar <- mean(LarceniesPerPopulation)
xmed <- median(LarceniesPerPopulation)
s <- sd(LarceniesPerPopulation)
ggplot(USData_clean, aes(LarceniesPerPopulation)) +
  geom_histogram(aes(y = ..density..),
                 bins = sqrt(nrow(USData_clean))+2,
                 fill = "grey", col = "black") +
  geom_density(col = "red", lwd = 1) +
  stat_function(fun = dnorm, args = list(mean = xbar,
                                         sd = s),
                col = "blue", lwd = 1) +
  ggtitle("Larcenies per Population in the US")

xbar
xmed
s
range(LarceniesPerPopulation)

### Part D: Bonus ###
so <- length(which(Region == "SO"))
we <- length(which(Region == "WE"))
ne <- length(which(Region == "NE"))
nc <- length(which(Region == "NC"))
pie(c(so, we, ne, nc), c("SO", "WE", "NE", "NC"), main="Regions in US")
