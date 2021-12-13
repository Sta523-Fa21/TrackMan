#' @name hitter_predictions
#'
#' @title Hitter Predictions
#'
#' @description Predicts the result of a ball in play based on the exit velocity, launch angle, hit type, and pitch type.
#'
#' @param PitchType Type of pitch thrown (fastball, slider, etc.)
#' @param HitType Description of ball in play (groundball, line drive, flyball, popup)
#' @param ExitSpeed The exit velocity in mph
#' @param ExitAngle How steeply up or down the ball leaves the bat in degrees
#' @param data A data frame corresponding to the training set
#'
#'
#'
#'
#'
#' @return Returns a tibble with the predicted probability for the result being a single, double, triple, home run, or out
#'
#'
#' @export
#'

library(tidymodels)
library(magrittr)
hitter_predictions = function(pitchtype, hittype, exitspeed, exitangle, data){

set.seed(17)
hitter_folds = vfold_cv(data, v=5)

hitter_rf_model = rand_forest(mtry = tune(), min_n = tune(), trees = 250) %>%
  set_engine("ranger", num.threads = 4) %>%
  set_mode("classification")

hitter_rf_recipe = recipe(Result ~ ., data = data)

hitter_rf_workflow = workflow() %>%
  add_model(hitter_rf_model) %>%
  add_recipe(hitter_rf_recipe)

hitter_rf_res = hitter_rf_workflow %>%
  tune_grid(
    hitter_folds,
    grid = expand.grid( mtry = c(1,2,3), min_n = c(5,10,15,20)),
    control = control_grid(save_pred = TRUE),
    metrics = metric_set(accuracy)
  )

hitter_rf_model_final <-
  finalize_workflow(rf_workflow, select_best(hitter_rf_res)) %>%
  fit(data)

  test = data.frame(AutoPitchType =pitchtype, HitType=hittype, ExitSpeed =exitspeed, ExitAngle=exitangle)

  hitter_rf_model_final %>%
    predict(test, type = "prob")%>%
    `colnames<-`(c("Double", "Home Run", "Out", "Single",
                   "Triple"))
    }



