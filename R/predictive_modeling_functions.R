#'@title hitter_predictions
#'
#'
#'
#'
#'
#'
#'
#'
#'
#'
#'
#'
#'
#'

hitter_predictions = function(PitchType, HitType, ExitSpeed, ExitAngle, data){

set.seed(17)
hitter_folds = vfold_cv(data, v=10)

hitter_rf_model = rand_forest(mtry = tune(), min_n = tune(), trees = 500) %>%
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

  test = data.frame(PitchType, HitType, ExitSpeed, ExitAngle)

  hitter_rf_model_final %>%
    predict(test, type = "prob")%>%
    `colnames<-`(c("Double", "Home Run", "Out", "Single",
                   "Triple"))
    }

#'@title pitcher_swing_predictions
#'
#'
#'
#'
#'
#'
#'
#'
#'
#'
#'
#'
#'
#'

