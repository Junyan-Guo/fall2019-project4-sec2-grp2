########################################
### Alternating Least Square (R3) ###
########################################

### Author: Chang Xu
### Project 4 group 2



#Define a function to calculate RMSE

RMSE <- function(rating, est_rating) {
  error <- rep(NA, nrow(rating))
  for (i in 1:nrow(rating)) {
    a <- as.character(rating[i,1])
    b <-as.character(rating[i,2])  
    error[i] <- (rating[i,3]-est_rating[a, b])^2
  }
  return(sqrt(mean(error)))
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
    q_idb <- rbind(rep(1,I), q)
    colnames(q_idb) <- levels(as.factor(data$movieId))
    p_idb <- rbind(bu, p)
    
    for (u in 1:U) {
      # find all the moives rated by user u
      i_ratedby_u <- as.character(train[train$userId==u,]$movieId)
      x<-train[train$userId==u,]$rating
      R_m_u <- matrix(x,ncol=length(x),nrow = 1)
      # update p.tilde
      p_idb[,u] <- solve(q_idb[,i_ratedby_u] %*% t(q_idb[,i_ratedby_u]) + lambda * diag(f+1)) %*%
        q_idb[,i_ratedby_u] %*% t(R_m_u - mu -bi[,i_ratedby_u])
    }
    
    # update bu and p
    bu[1,] <- p_idb[1, ]
    p <- p_idb[-1, ]
    
    # Step 3: Fix p, solve q
    # we need new factors to add bu, bi into calculation
    p.tilde <- rbind(rep(1,U), p)
    colnames(p.tilde) <- levels(as.factor(data$userId))
    q.tilde <- rbind(bi, q)
    
    for (i in 1:I) {
      # find all the users who rate movie i
      u.rated.i <- as.character(train[train$movieId==movie.id[i],]$userId)
      q.tilde[,i] <- solve(p.tilde[,u.rated.i] %*% t(p.tilde[,u.rated.i]) + lambda* diag(f+1)) %*%
        p.tilde[,u.rated.i] %*% (train[train$movieId==movie.id[i],]$rating - mu - bu[,u.rated.i])
      
    }
    
    # update bi and q
    bi[1,] <- q.tilde[1,]
    q <- q.tilde[-1,]
    
    ## update bit
    for (t in 1:30) {
      sub <- filter(train, Bin == t)
      for (i in 1:I) {
        ssub <- filter(sub, movieId == i) 
        r <- sum(ssub$rating)
        n <- length(unique(ssub$userId))+lambda
        bit[t, i] <- r/n
      }
    }
    
    # Rating Matrix
    mat <- matrix(rep(NA, U*I), ncol = I)
    for (u in 1:U) {
      for (i in 1:I) {
        mat[u, i] <- as.numeric(t(p[,u]) %*% q[,i])
      }
    }
    
    bu_ui <- matrix(rep(NA, U*I), ncol = I)
    for (i in 1:I) {
      bu_ui[,i] <- t(bu)
    }
    
    bi_ui <- matrix(rep(NA, U*I), ncol = I)
    for (u in 1:U) {
      bi_ui[u, ] <- bi
    }
    
    bit_ui <- matrix(rep(0, U*I), ncol = I)
    for (u in 1:U) {
      for (i in 1:I) {
          sub <- filter(train, userId == u, movieId == i)
          if (dim(sub)[1] > 0) {
            t <- as.numeric(sub$Bin)
            bit_ui[u, i] <- bit[t, i]
          }
        }
      }
    
    
  
    mu_ui <- matrix(rep(mu, U*I), ncol = I)
    
    R <- mu_ui + bu_ui + bi_ui + mat + bit_ui
    
    
  
   
     
  
    
    # Summerize
    cat("iter:", l, "\t")
    est_rating <- as.matrix(R) 
    colnames(est_rating) <- levels(as.factor(data$movieId))
    rownames(est_rating) <- levels(as.factor(data$userId))
    
    train_RMSE_cur <- RMSE(train, est_rating)
    cat("training RMSE:", train_RMSE_cur, "\t")
    train_RMSE <- c(train_RMSE, train_RMSE_cur)
    
    test_RMSE_cur <- RMSE(test, est_rating)
    cat("test RMSE:",test_RMSE_cur, "\n")
    test_RMSE <- c(test_RMSE, test_RMSE_cur)
    
  }
  return(list(p = p, q = q, bi = bi, bu = bu, mu= mu, 
              train_RMSE = train_RMSE, test_RMSE = test_RMSE,
              est_rating = est_rating))
}
