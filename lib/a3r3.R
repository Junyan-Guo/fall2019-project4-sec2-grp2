########################################
### Alternating Least Square (R3) ###
########################################

### Author: Chang Xu
### Project 4 group 2



#Define a function to calculate RMSE
RMSE <- function(rating, est_rating){
  sqr_err <- function(obs){
    sqr_error <- (obs[3] - est_rating[as.character(obs[1]), as.character(obs[2])])^2
    return(sqr_error)
  }
  return(sqrt(mean(apply(rating, 1, sqr_err))))  
}



# Alternating least squares
# a function returns a list containing factorized matrices p and q, training and testing RMSEs.

ALS.R3 <- function(f = 10, lambda = 5, max.iter, data, train, test){
  
  # Step 1: Initialize Movie matrix (q), User matrix (p), Movie bias(bi) and User bias(bu)
  
  # Step 1: Initialize Movie matrix (q), User matrix (p), Movie bias(bi) and User bias(bu)
  p <- matrix(runif(f*U, -10, 10), ncol = U) 
  colnames(p) <- levels(as.factor(data$userId))
  
  q <- matrix(runif(f*I, -10, 10), ncol = I)
  colnames(q) <- levels(as.factor(data$movieId))
  
  bu <- matrix(rep(0, U), ncol=U)
  colnames(bu) <- levels(as.factor(data$userId))
  
  bi <- matrix(rep(0, I), ncol = I)
  colnames(bi) <- levels(as.factor(data$movieId))
  
  R <- matrix(rep(0, U*I), ncol = I)
  colnames(R) <- levels(as.factor(data$movieId))
  
  bit <- matrix(rep(NA, I*30), ncol = I)
  colnames(bi) <- levels(as.factor(data$movieId))
  
  

  
  #mean of all the ratings in train data set.
  mu <- mean(train$rating)
  
  
  # sort movie id to make sure that they are from small to large
  movie.id <- sort(unique(data$movieId))
  
  # sort the data by userid then by movie id
  train <- arrange(train, userId, movieId)
  
  
  # set vacant cells to record train and test rmse
  train_RMSE <- c()
  test_RMSE <- c()
  
  
  for (l in 1:max.iter){
    # Step 2: Fix q, solve p
    # we need new factors to add bu, bi into calculation
   
     
      #subtrain <- filter(train, Bin == t)
      
      q_idb <- rbind(rep(1,I), q)
      colnames(q_idb) <- levels(as.factor(data$movieId))
      p_idb <- rbind(bu, p)
      
      for (u in 1:U) {
        # find all the moives rated by user u
        i_ratedby_u <- as.character(train[train$userId==u,]$movieId)
        x<-train[train$userId==u,]$rating
        R_m_u <- matrix(x,ncol=length(x),nrow = 1)
        
        # update p(t).tilde
        p_idb[,u] <- solve(q_idb[,i_ratedby_u] %*% t(q_idb[,i_ratedby_u]) + lambda * diag(f+1)) %*%
          q_idb[,i_ratedby_u] %*% t(R_m_u - mu -bi[,i_ratedby_u])
      }
      
      # update bu and p 
      bu <- p_idb[1, ]
      p <- p_idb[-1, ]
      
      
      # Step 3: Fix p, solve q
      # we need new factors to add bu, bi into calculation
      p_idb <- rbind(rep(1,U), p)
      colnames(p_idb) <- levels(as.factor(data$userId))
      q_idb <- rbind(bi, q)
      
      for (i in 1:I) {
        # find all the users who rate movie i
        u_rated_i <- as.character(train[train$movieId==movie.id[i],]$userId)
        
        y<-train[train$movieId==movie.id[i],]$rating
        R_m_m <- matrix(y,ncol=length(y),nrow=1)
        
        q_idb[,i] <- solve(p_idb[,u_rated_i] %*% t(p_idb[,u_rated_i]) + lambda* diag(f+1)) %*%
          p_idb[,u_rated_i] %*% t(R_m_m - mu - bu[,u_rated_i])
        
      }
      
      # update bi and q
      bi[1,] <- q_idb[1,]
      q <- q_idb[-1,]
      
      ## update bit
      for (t in 1:30) {
        sub <- filter(train, Bin == t)
        for (i in 1:I) {
          ssub <- filter(sub, movieId == i) 
          bit[i, t] <- sum(ssub$rating)/(length(unique(ssub$userId))+lambda)
        }
      }
      
      predict <- function(P, Q, bi, bu) {
        for (u in 1:U) {
          for (i in 1:I) {
            sub <- filter(data, userId == u, movieId == i) 
            bin_num <- sub$Bin
            R[u, i] <- mu + bu[u] + bi[i] + bit[bin_num, i] + t(p[u, ]) %*% q[,i]
          }
        }
        return(R)
      }

      
      # Summerize
      cat("iter:", l, "\t")
      est_rating <- predict(P = p, Q = q, bi = bi, bu = bu)
      colnames(est_rating) <- levels(as.factor(data$movieId))
      
      train_RMSE_cur <- RMSE(train, est_rating)
      cat("training RMSE:", train_RMSE_cur, "\t")
      train_RMSE <- c(train_RMSE, train_RMSE_cur)
      
      test_RMSE_cur <- RMSE(test, est_rating)
      cat("test RMSE:",test_RMSE_cur, "\n")
      test_RMSE <- c(test_RMSE, test_RMSE_cur)
      
    return(list(p = p, q = q, bi = bi, bu = bu, mu= mu, train_RMSE = train_RMSE, test_RMSE = test_RMSE))
    
    }
  
}
