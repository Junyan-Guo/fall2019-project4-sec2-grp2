## split dataset




data$timestamp <- anydate(data$timestamp)
data <- arrange(data, timestamp)

bins <- as.numeric(max(data$timestamp) - min(data$timestamp))
cut <- seq(0, 1, by=1/30)
quan <- quantile(c(1:bins), cut)
Bin <- rep(NA, nrow(data)-1)
for (i in 1:nrow(data)) {
  dev <- as.numeric(data$timestamp[i] - data$timestamp[1]) + 1
  for (j in 1:30) {
    if (quan[j] <= dev & dev <= quan[j+1]) Bin[i] = j
  }
}
data$Bin <- c(Bin, 30)

set.seed(0)
## shuffle the row of the entire dataset
data <- data[sample(nrow(data)),]
## get a small dataset that contains all users and all movies
unique.user<-duplicated(data[,1])
unique.movie<-duplicated(data[,2])
index<-unique.user & unique.movie
all.user.movie <- data[!index,]

## split training and test on the rest
rest <- data[index,]
test_idx <- sample(rownames(rest), round(nrow(data)/5, 0))
train_idx <- setdiff(rownames(rest), test_idx)

## combine the training with the previous dataset, which has all users and all movies
data_train <- rbind(all.user.movie, data[train_idx,])
data_test <- data[test_idx,]

## sort the training and testing data by userId then by movieId, 
## so when we update p and q, it is less likely to make mistakes
data_train <- arrange(data_train, userId, movieId)
data_test <- arrange(data_test, userId, movieId)


