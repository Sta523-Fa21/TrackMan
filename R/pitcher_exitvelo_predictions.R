#' @name pitcher_exitvelo_predictions
#'
#' @title Pitcher Exit Velocity Predictions
#'
#' @description Predicts the exit velocity of a ball in play off of a pitch based on four key pitch design metrics.
#'
#' @param pitchtype The type of pitch thrown (fastball, slider, etc.)
#' @param relspeed The velocity of the pitch when it leaves the pitcher's hand in mph
#' @param spinrate The rate at which the ball is spinning in rpm
#' @param tilt The axis on which the ball spins, measured like hours and minutes on a clock, rounded to the nearest 15 minutes
#' @param inducedvertbreak The vertical difference in inches between where the ball is at home plate compared to where it would have been had it been affected by gravity alone
#' @param data A data frame corresponding to the data set
#'
#' @return Returns a tibble with the predicted exited velocity
#'
#'
#' @export

library(tidymodels)
library(magrittr)

pitcher_exitvelo_predictions = function(pitchtype, relspeed, spinrate, tilt, inducedvertbreak, data){

  set.seed(57)

  pitcher_data_model = data %>%
    filter(!is.na(ExitSpeed), PitchCall == "InPlay") %>%
    select(1,3:6,10)

  pitcher_folds = vfold_cv(pitcher_data_model, v=5)

  pitcher_swing_rf_model = rand_forest(mtry = tune(), min_n = tune(), trees = 250) %>%
    set_engine("ranger", num.threads = 4) %>%
    set_mode("regression")

  pitcher_rf_recipe = recipe(ExitSpeed ~ ., data = pitcher_data_model)

  pitcher_rf_workflow = workflow() %>%
    add_model(pitcher_swing_rf_model) %>%
    add_recipe(pitcher_rf_recipe)

  pitcher_rf_res = pitcher_rf_workflow %>%
    tune_grid(
      pitcher_folds,
      grid = expand.grid( mtry = c(1,2,3), min_n = c(5,10,15,20)),
      control = control_grid(save_pred = TRUE),
      metrics = metric_set(rmse)
    )

  pitcher_swing_rf_model_final <-
    finalize_workflow(pitcher_rf_workflow, select_best(pitcher_rf_res)) %>%
    fit(pitcher_data_model)

  test = data.frame(AutoPitchType = pitchtype , RelSpeed = relspeed, SpinRate = spinrate, Tilt= tilt, InducedVertBreak= inducedvertbreak)

  pitcher_swing_rf_model_final %>%
    predict(test) %>%
    `colnames<-`(c("Predicted Exit Velocity"))


  }



