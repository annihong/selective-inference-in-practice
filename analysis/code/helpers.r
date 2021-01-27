library(sandwich)
library(lmtest)
generate_formula <- function(outcome, covariates, remove=""){
  if (!remove == "") {
    remove <- paste0("-", remove, " +")
  }
  formula <- paste0(outcome, '~', remove, paste(covariates, collapse = ' + '))
  return(formula)
}

generate_quad_terms <- function(predictors){
  return(paste0("I(",predictors, "^2)"))
}

generate_interaction_terms <- function(predictors){
  return(paste0('(', paste(predictors, collapse = ' + '), ')^2', collapse = ' + '))  
}

#select_significant <- function()

select_remained <- function(model_object){
  return(names(model_object$coefficients)[-1])
}

# i.e. expander = generate_quad_terms
#      select_from = select_remained
# returns a selector function that executes model selection on the specified terms 
# (quadratic vs interactions)
# k = 3.84 ~ p = 0.05
selector_factory <- function(expander=generate_quad_terms, select_from=select_remained){
  selector <- function(data, base_var, add_var, outcome, remove=""){
    initial_model <- generate_formula(outcome, c(base_var, add_var), remove)
    full_model <- generate_formula(outcome, c(base_var, add_var, expander(add_var)), remove)
    res <- step(lm(as.formula(initial_model), data=data),
                scope=as.formula(full_model), scale = 0,trace = F, k=2,
                direction = "forward", test="F")
    return(select_from(res))
  }
  return(selector)
}

shuffle <- function(data, outcomes){
  shuffled <- data[sample(nrow(data)),]
  shuffled[,outcomes] <- data[,outcomes]
  return(shuffled)
}

bootstrap_sample <- function(to_sample, m){
  s <- to_sample[sample(1:nrow(to_sample), m, replace = T),]
  return(s)
}


sample_splitting <- function(data, train_fraction=0.5){
  train_num <- round(nrow(data) * train_fraction)
  train_idx <- sample(1:nrow(data), train_num)
  train <- data[train_idx,]
  test <- data[-train_idx,]
  return(list(train=train, test=test))
}
generate_full_model_dat <- function(data, base_var, add_var, outcomes){
  full_model <- generate_formula(outcomes[1], c(
                                             base_var, 
                                             add_var, 
                                             generate_quad_terms(add_var),
                                             generate_interaction_terms(add_var)
                                             ))
  df <- as.data.frame(model.matrix(lm(as.formula(full_model), data = data)))
  return(cbind(df,data))
}

get_result <- function(data, outcome, covariates, remove=""){
  f <- as.formula(generate_formula(outcome, covariates, remove))
  fit <- lm(f, data = data)
  return(fit)
}

get_num_sig <- function(fit, alpha=0.05, robust=F){
  if (robust) {
    p_vals <- lmtest::coeftest(fit, vcov=sandwich)[,4]
  } else {
    p_vals <- summary(fit)$coefficient[,4]
  }
  return(sum(p_vals[-1] <= alpha))
}

get_num_sig_quad_term <- function(fit, alpha=0.05, robust=F){
  if (robust) {
    p_vals <- coeftest(fit, vcov=sandwich)[,4]
  } else {
    p_vals <- summary(fit)$coefficient[,4]
  }
  quad_p_vals <- p_vals[grep("^I.*2", names(p_vals))]
  return(sum(quad_p_vals <= alpha))
}

# example 2
make_data <- function(m=1000){
  y <- rlnorm(m)
  X1 <- as.data.frame(purrr::map(1:5, rlnorm, n=m))
  X2 <- as.data.frame(purrr::map(1:5, rlnorm, n=m))
  X <- cbind(X1,X2)
  colnames(X) <- paste0("x",c(1:10))
  X$y <- y
  # X <- abs(X) + 10
  return(X)
}
boxcox_transform <- function(x, l){
  if (l != 0){
    x <- (x^l - 1)/l
  } else {
    x <- log(x)
  }
  return(x)
}

boxcox_dat_transform <- function(dat, ls){
  for (l in ls){
    dat[,names(l)] <- boxcox_transform(dat[,names(l)],l)
  }
  return(dat)
}

multivariate_boxcox <- function(i){
  dat <- make_data()
  
  s <- summary(a <- car::powerTransform(dat$X))
  lambdas <- s$result[,2]
  #testTransform(a, lambdas)
  X_trans <- boxcox_dat_transform(dat$X,lambdas)
  fit <- lm(dat$y ~., data = cbind(X_trans,y))
  s <- summary(a2 <- car::powerTransform(fit))
  lambda_y <- s$result[,2]
  y_trans <- boxcox_transform(y,lambda_y)
  fit <- lm(y_trans ~ ., data=cbind(X_trans,y_trans))
  return(fit)
}

#takes in the covariates to be transformed
#returns a list of lambda for the boxcox power transformation of the given covariates
multivariate_covariates_transform <- function(X){
  s <- summary(car::powerTransform(X))
  ls <- s$result[,2]
  names(ls) <- names(X)
  return(ls)
}

get_lambdas <- function(train, outcome){
  ls <- multivariate_covariates_transform(train[,-which(names(train) == outcome)])
  X_train_trans <- boxcox_dat_transform(train[,-which(names(train) == outcome)], ls)
  fit <- lm(y ~., data=cbind(X_train_trans, y=train[,outcome]))
  s <- summary(car::powerTransform(fit))
  l_y <- s$result[,2]
  names(l_y) <- outcome
  ls <- c(ls, l_y)
  return(ls)
}

post_transform_inference <- function(dat, outcome, covariates, ls){
  transformed <- boxcox_dat_transform(dat, ls)
  f <- as.formula(generate_formula(outcome, covariates))
  fit <- lm(f, data = transformed)
  return(fit)
}
