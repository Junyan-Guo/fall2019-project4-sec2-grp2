#Define a function to calculate distance
#q1,q2 are 1*n matrixes where n is # of factors
s<-function(q1,q2){
    (q1%*%t(q2))/(norm(q1,"f") * norm(q2,"f"))
  }

#Function for Knn model
knn_vec<-function(test,train,k){
  #reorganize the data 
  nrow.test<-dim(test)[1]
  nrow.train<-dim(train)[1]
  train.data<-train[,-length(train)]
  train.rate<-train$rate
  test.rate<-c(1:nrow.test)
  
 ##calculate all rating from test set given train data---
  for (j in 1:nrow.test){
  q1<-as.matrix(test[j,],nrow = 1)
###calculate a single rating given train data 
  l_distance<-c(1:nrow.train)
  for (i in 1:nrow.train){
    q2<-as.matrix(train.data[i,],nrow = 1)
    l_distance[i]<- s(q1,q2)} 
###------------------------------------------
  test.rate[j]<-mean(train.rate[order(l_distance)[1:k]])
 ##------------------------------------------------------
  }
  return(test.rate)
}

#Sample code for runing knn_vec
#Creat mock train/test values
#train.mock<-data.frame(matrix(runif(1000*6),ncol=6,byrow = TRUE))
#test.mock<-  data.frame(matrix( runif(5*6), ncol=6, byrow = TRUE))
#rate.mock <- matrix(sample.int(10, 1000, replace = TRUE)/2,ncol=1)
#train.mock$rate<-rate.mock

#Run kNN
#knn_vec(test.mock,train.mock,k=10)
