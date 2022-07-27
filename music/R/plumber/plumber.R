library(plumber)
library(plumbertableau)
library(ranger)

#* @apiTitle Tableau Random Forest
#* @apiDescription Fit simple random forest model to input data

#* Fit random forest to input data
#* @tableauArg x:numeric independent variable
#* @tableauArg y:any dependent variable
#* @tableauReturn numeric Predicted output from fit model
#* @post /rf
rf_fit <- function(x, y) {
  train_data <- data.frame(x = x, y = y)
  fit <- ranger(y ~ x, data = train_data)
  predictions(fit)
}

#* @plumber
tableau_extension
