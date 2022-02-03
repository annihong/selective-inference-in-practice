library(sandwich)
library(lmtest)

#given the outcome and the covariates
#returns a string formula
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

#given a model_object (such as a stepwise selection model)
#returns the names of all the coefficients remain in the model (except the intercept)
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

#shuffle the covariates but keep the outcomes(a matrix) constant
shuffle <- function(data, outcomes){
  shuffled <- data[sample(nrow(data)),]
  shuffled[,outcomes] <- data[,outcomes]
  return(shuffled)
}

#given the data to be sampled and the sample size m
#returns a bootstrap sample of data
bootstrap_sample <- function(to_sample, m){
  if (is.vector(to_sample)){
    s <- sample(to_sample, m, replace = T)
  } else {
    s <- to_sample[sample(1:nrow(to_sample), m, replace = T),]
  }
  return(s)
}

# given the data to split, and the fraction of the trainning data (default 0.5)
# returns a list of the train and test sets
sample_splitting <- function(data, train_fraction=0.5){
  train_num <- round(nrow(data) * train_fraction)
  train_idx <- sample(1:nrow(data), train_num)
  train <- data[train_idx,]
  test <- data[-train_idx,]
  return(list(train=train, test=test))
}

# specific to example_1
# given:
  # data: the dataset to be expanded
  # base_var: the variables that remain the same, not expanded
  # add_var: the variables that will be expanded into quadratic and interaction terms
# returns a full dataset through model.matrix
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

#given the outcome and covariates
#returns the fitted model object 
get_result <- function(data, outcome, covariates, remove=""){
  f <- as.formula(generate_formula(outcome, covariates, remove))
  fit <- lm(f, data = data)
  return(fit)
}

#given a model object, sig level (default = 0.05), and using robust variance or not (default = F)
# returns the number of significant coefs not counting the intercept
get_num_sig <- function(fit, alpha=0.05, robust=F){
  if (robust) {
    p_vals <- lmtest::coeftest(fit, vcov=sandwich)[,4]
  } else {
    p_vals <- summary(fit)$coefficient[,4]
  }
  return(sum(p_vals[-1] <= alpha))
}

# specific to example 1
# given given a model object, sig level (default = 0.05), and using robust variance or not (default = F)
# returns the number of quad terms significant in the model
get_num_sig_quad_term <- function(fit, alpha=0.05, robust=F){
  if (robust) {
    p_vals <- coeftest(fit, vcov=sandwich)[,4]
  } else {
    p_vals <- summary(fit)$coefficient[,4]
  }
  quad_p_vals <- p_vals[grep("^I.*2", names(p_vals))]
  return(sum(quad_p_vals <= alpha))
}

# given the model object and the name of the variable of interest
# returns a list of the coef estimates for the variable
get_coef_est <- function(fit, var_name){
  estimates <- summary(fit)$coefficient[,1]
  return(estimates[var_name])
}


# example 2


make_data <- function(outcome="y", m=1000, to_shuffle=F, y_dist=rnorm, x_dist=rnorm, n_x = 10){
  y <- y_dist(m)
  X <- as.data.frame(purrr::map(1:n_x, x_dist, n=m))
  covariates <- paste0("x",c(1:n_x))
  colnames(X) <- covariates
  X[,outcome] <- y
  # X <- abs(X) + 10
  if (to_shuffle) {
    X <- cbind(bootstrap_sample(X[,-which(names(X) == outcome)], m),
               bootstrap_sample(X[,outcome], m))
    colnames(X) <- c(covariates, outcome)
  }
  return(X)
}

# given the variable x to be transformed and the power of transformation
# returns the boxcox transformed x
boxcox_transform <- function(x, l){
  #assertthat::assert_that(is.vector(x))
  if (l != 0){
    x <- (x^l - 1)/(l)
  } else {
    x <- log(x)
  }
  return(x)
}

# given a matrix/dataframe and a vector of powers for transformation
# returns the transformed dataframe
boxcox_dat_transform <- function(dat, ls){
  for (l in ls){
    dat[,names(l)] <- boxcox_transform(dat[,names(l)],l)
  }
  return(dat)
}

# multivariate_boxcox <- function(i){
#   dat <- make_data()
#   
#   s <- summary(a <- car::powerTransform(dat$X))
#   lambdas <- s$result[,2]
#   #testTransform(a, lambdas)
#   X_trans <- boxcox_dat_transform(dat$X,lambdas)
#   fit <- lm(dat$y ~., data = cbind(X_trans,y))
#   s <- summary(a2 <- car::powerTransform(fit))
#   lambda_y <- s$result[,2]
#   y_trans <- boxcox_transform(y,lambda_y)
#   fit <- lm(y_trans ~ ., data=cbind(X_trans,y_trans))
#   return(fit)
# }

#takes in the covariates to be transformed
#returns a list of lambda for the boxcox power transformation of the given covariates
multivariate_covariates_transform <- function(X){
  s <- summary(car::powerTransform(X))
  ls <- s$result[,2]
  names(ls) <- names(X)
  return(ls)
}

# given the training data and the outcome name
# returns a list of lambdas for transformation (for covariates and the outcome)
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

#given a dataset, the outcome name, the list of covariates and lambdas
# return the model object fitted post transformation
post_transform_inference <- function(dat, outcome, covariates, ls){
  transformed <- boxcox_dat_transform(dat, ls)
  f <- as.formula(generate_formula(outcome, covariates))
  fit <- lm(f, data = transformed)
  return(fit)
}

# given a dataset
# returns a function that allows bootstrap draws from the dataset, where shuffle is set to true. 
bootstrap_shuffle_factory <- function(dataset){
  
  # given outcome name, sample size, and shuffle or not
  # returns the sample dataset
  sample_function <- function(outcome, m, to_shuffle=T){
    if (to_shuffle){
      covariates <- names(dataset)[-which(names(dataset) == outcome)]
      dat <- cbind(bootstrap_sample(dataset[,covariates], m), bootstrap_sample(dataset[,outcome], m))
      colnames(dat) <- c(covariates, outcome)
    } else {
      dat <- bootstrap_sample(dataset, m)
    }
    return(dat)
  }
  return(sample_function)
}

