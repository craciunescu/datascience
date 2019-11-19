#Load package arule
#installed.packages("arules")
#search()

#######################################################################
#                  S H O P P I N G      B A S K E T S                 #
#######################################################################

# Load matrix with data which has been converted into 1 and 0's
sample <- Matrix(c(1,1,0,1,1, 1,1,1,1,0, 1,1,0,1,0, 1,0,1,1,0, 1,1,0,0,0, 0,0,0,1,0), 6, 5, byrow = T,  dimnames = list(c("event1", "event2", "event3", "event4", "event5", "event6"), c("Bread", "Water", "Coffee", "Milk", "Oranges")), sparse = T)
sample

# Convert data into data frame
samplengCMatrix <- as(sample, "nsparseMatrix")

# Matrix is transposed
transpsamplengCMatrix <- t(samplengCMatrix)

# Creating transactions and making a summary of them
transactions <- as(transpsamplengCMatrix, "transactions")
summary(transactions)

# Applying apriori's algorithm
associations <- apriori (transactions, parameter=list(support=0.5, confidence=0.8))
inspect(associations)

#######################################################################
#                         C A R     S A L E S                         #
#######################################################################

# Creating car.txt which contains the data
data <- paste(
          "X C N B",
          "X C B S",
          "X C N",
          "X N B S",
          "X C B",
          "N",
          "X C B",
          "S A",
          sep="\n")

cat(data)
write(data,file = "cars.txt")

# Reading the file and creating the transactions
car_transactions <- read.transactions(file="cars.txt",rm.duplicates=FALSE, format="basket", sep=",");
summary(car_transactions)


# Applying apriori's algorithm
associations<- apriori(car_transactions,parameter = list(sup = 0.4, conf = 0.9, target="rules"));
inspect(associations)
