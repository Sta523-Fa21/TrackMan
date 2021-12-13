#'@name pitcher_swing_plot
#'
#'@title Pitcher Swing and Miss Plot
#'
#'@description Provides a plot of similar pitches as the one inputted
#'
#'
#'@param pitchtype The type of pitch thrown (fastball, slider, etc.)
#'@param relspeed The velocity of the pitch when it leaves the pitcher's hand in mph
#'@param spinrate The rate at which the ball is spinning in rpm
#'@param tilt The axis on which the ball spins, measured like hours and minutes on a clock, rounded to the nearest 15 minutes
#'@param inducedvertbreak The vertical difference in inches between where the ball is at home plate compared to where it would have been had it been affected by gravity alone
#'@param data A data frame corresponding to the training set
#'
#'
#'@return Returns a plot with pitches in the given training set that are within one standard deviation for each of the metrics listed, colored by the result
#'
#'@export

library(ggplot2)
library(dplyr)
library(magrittr)
pitcher_exitvelo_plot = function(pitchtype, relspeed, spinrate, tilt, inducedvertbreak, data){

  filter_pitcher =  data %>%
    mutate(Result = ifelse(PitchCall == "StrikeSwinging", "Swing and Miss", "No Swing and Miss")) %>%
    select(-PitchCall) %>%
    filter(AutoPitchType == pitchtype)

  filter_pitcher = filter_pitcher %>%
    filter(RelSpeed > relspeed - 0.5*sd(filter_pitcher$RelSpeed) & RelSpeed < relspeed + 0.5*sd(filter_pitcher$RelSpeed), SpinRate > spinrate - 0.5*sd(filter_pitcher$SpinRate) & SpinRate < spinrate + 0.5*sd(filter_pitcher$SpinRate), InducedVertBreak >  inducedvertbreak - 0.5*sd(filter_pitcher$InducedVertBreak) & InducedVertBreak <  inducedvertbreak + 0.5*sd(filter_pitcher$InducedVertBreak), Tilt %in% tilt_function(tilt))


  ggplot(filter_pitcher,mapping = aes(x=PlateLocSide, y=PlateLocHeight)) +
    geom_point(aes(color= as.factor(Result)), size = 2.5) +
    geom_segment(data.frame(x=c(-0.71,-0.71,0.71,0.71), y=c(1.5,1.5,1.5,3.6), xend=c(0.71,-0.71,0.71,-0.71), yend=c(1.5,3.6,3.6,3.6)), mapping = aes(x=x,y=y,yend=yend,xend=xend)) +
    scale_colour_viridis_c(option = "plasma") +
    labs(color = "Exit Velo") +
    ylim(c(0,5)) +
    xlim(c(-3,3)) +
    theme_void()
}
