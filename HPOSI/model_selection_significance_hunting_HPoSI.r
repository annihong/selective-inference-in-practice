if (!require("pacman")) install.packages("pacman")
pacman::p_load(optparse, pracma, data.table, 
               matrixStats, MASS, sandwich, jtools, dplyr,Rcpp)
if (!require("tmax")) install.packages("./tmax_1.0.tar.gz", repos=NULL, dependencies=T)

source("utilities.R")

option_list = list(
  make_option(c("-o", "--out"), type="character", default="mboot", 
              help="output file name [default= %default]", metavar="character"),
  make_option(c("-b", "--nboot"), type="integer", default="1000", 
              help="number of bootstrap [default= %default]", metavar="number"),
  make_option(c("-n", "--nrow"), type="integer", default="500", 
              help="nrow [default= %default]", metavar="number"),
  make_option(c("-d", "--ncol"), type="integer", default="20", 
              help="nrow [default= %default]", metavar="number"),
  make_option(c("--seed_eps"), type="integer", default="1", 
              help="random seed [default= %default]", metavar="number"),
  make_option(c("-k", "--maxk"), type="integer", default="1", 
              help="number of variables", metavar="number"),
  make_option(c("-x", "--xmat"), type="character", default="a", 
              help="number of variables", metavar="number")
); 

opt_parser = OptionParser(option_list=option_list);
opt = parse_args(opt_parser);


# Setup ---------------------------------------------------------------------

opt$xmat <- "c"
opt$nrow <- 500

p <- opt$ncol 
beta0 <- rep(0, opt$ncol)

# Sigma
if(opt$xmat == "a") {
  Sigma <- diag(rep(1, opt$ncol))
} else if(opt$xmat == "b") {
  rho <- -1/(opt$ncol + 2)
  Sigma <- (1 - rho)*diag(rep(1, opt$ncol)) + rho*matrix(1, nrow = opt$ncol, ncol = opt$ncol) 
} else {
  Sigma <- cbind(rbind(diag(rep(1,p-1)),rep(1/sqrt(2*(p-1)), p-1)), c(rep(1/sqrt(2*(p-1)), p-1),1/2))
} 
nsim <- 1000
sig <- 1

# Results
## regular CI
ci_mat <- matrix(0, ncol = 2, nrow = nsim)
## PoSI
ci_maxt <- matrix(0, ncol = 2, nrow = nsim)
## HPoSI
ci_maxt_norm <- matrix(0, ncol = 2, nrow = nsim)
true_beta <- rep(0, nsim)

# Main ---------------------------------------------------------------------

for(isim in 1:nsim) {
  if(!(isim %% 10)) print(isim)
  opt$eps <- isim
  set.seed(opt$eps)
  
  X <- mvrnorm(opt$nrow, mu = rep(0, opt$ncol), Sigma = Sigma)
  Y <- rnorm(opt$nrow, 0, sig)
  pval <- rep(0, opt$ncol)
  
  for(j in 1:opt$ncol){
    tmp <- lm(Y ~ X[,c(j)])
    pval[j] <- abs(summary(tmp)$coeff[2,3]) #getting the t-stats
  }
  Mhat <- c(which.max(pval))
  
  lmfit_Mhat <- lm(Y ~ X[,Mhat])
  se <- vcovHC(lmfit_Mhat, "HC0")
  true_beta[isim] <- solve(Sigma[Mhat, Mhat], Sigma[Mhat, ]%*%beta0)[1]
  
  ##  usual CI
  ci_lmfit_Mhat <- summ(lmfit_Mhat, confint = T)$coeftable
  ci_mat[isim,] <- ci_lmfit_Mhat[2, 2:3]
  
  ## maxt
  Hm <- matrix(NA, nrow = opt$maxk, ncol = opt$nboot)
  ## maxt rank
  Hs <- matrix(NA, nrow = opt$maxk, ncol = opt$nboot)
  
  ks <- 1:opt$maxk
  for(i in seq_along(ks)) {
    k <- ks[i]
    
    # get the bootstrap sample
    tmp <- max_t_mul_boot_k(X, Y, k,
                            sandwich = T, return_sample = T,
                            Nboot = opt$nboot, intercept = T)
    
    Hs[i, ] <- colMax(tmp$BootSample)
    Hm[i, ] <- colMax(tmp$BootRank)
  }
  
  K <- get_T(Hm = Hs)
  K_norm <- get_T(X, Y, Mhat, NULL, Hm, maxk = opt$maxk, Nboot = opt$nboot, intercept = T, adjust = T)
  
  
  ci_maxt[isim, ] <- lmfit_Mhat$coef[2] - c(K, -K) * sqrt(se[2,2])
  ci_maxt_norm[isim, ] <- lmfit_Mhat$coef[2] - c(K_norm, -K_norm) * sqrt(se[2,2])
  
}

mean(ci_mat[,2] * ci_mat[,1] <= 0)
mean(ci_maxt[,2] * ci_maxt[,1] <= 0)
mean(ci_maxt_norm[,2] * ci_maxt_norm[,1] <= 0) 

# output CI
ci <- data.frame(isim = rep(1:nsim, 3),
                 beta  = rep(true_beta, 3),
                 lower = c(ci_mat[,1], ci_maxt[,1], ci_maxt_norm[,1]),
                 upper = c(ci_mat[,2], ci_maxt[,2], ci_maxt_norm[,2]),
                 covered = c((ci_mat[,2] * ci_mat[,1] <= 0),
                             (ci_maxt[,2] * ci_maxt[,1] <= 0),
                             (ci_maxt_norm[,2] * ci_maxt_norm[,1] <= 0)),
                 method = factor(rep(c("t", "maxt", "maxt_norm"), each = nsim),
                                 levels = c("t", "maxt", "maxt_norm")))

write.csv(ci, paste0("./sig_hunt_xmat_", opt$xmat, 
                     "_n", opt$nrow, 
                     "_sim", nsim, "_p", p, ".csv"))



