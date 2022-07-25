library(plumber)
library(plumbertableau)
library(ranger)

#* @apiTitle Regression Models
#* @apiDescription Fit simple regression models to input data

#* Fit linear regression to input data
#* @tableauArg x:numeric independent variable
#* @tableauArg y:numeric dependent variable
#* @tableauReturn numeric Predicted output from fit model
#* @post /lr
lm_fit <- function(x, y) {
  fit <- lm(y ~ x)
  predict(fit)
}

#* Fit random forest to input data
#* @tableauArg x:numeric independent variable
#* @tableauArg y:numeric dependent variable
#* @tableauReturn numeric Predicted output from fit model
#* @post /rf
rf_fit <- function(x, y) {
  train_data <- tibble(x = x, y = y)
  fit <- ranger(y ~ x, data = train_data)
  predictions(fit)
}

#* @plumber
tableau_extension
