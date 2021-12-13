#' @title pitcher_data
#'
#' @description TrackMan metrics corresponding to every pitch thrown for 60 games during the 2018 college baseball season.
#'
#' @format A data frame consisting of 16828 observations with 10 variables.
#'
#' \describe{
#' \item{AutoPitchType}{Pitch type as determined by TrackMan}
#' \item{PitchCall}{Result of pitch, i.e. called strike, ball, in play, etc.}
#' \item{RelSpeed}{Initial velocity of the ball out of the pitcher's hand in mph}
#' \item{SpinRate}{How fast the ball is spinning as it leaves the pitcher’s hand, reported in the number of times the pitched ball would spin per minute (“revolutions per minute” or “rpm”)}
#' \item{Tilt}{Direction the ball is spinning converted into clock time, rounded to the nearest 15 minutes}
#' \item{InducedVertBreak}{Distance, measured in inches, between where the pitch actually crosses the front of home plate height-wise, and where it would have crossed home plate height-wise if had it traveled in a perfectly straight line from release, but affected by gravity.}
#' \item{HorzBreak}{Distance, measured in inches, between where the pitch actually crosses the front of home plate side-wise, and where it would have crossed home plate side-wise if had it traveled in a perfectly straight line from release. A positive number means the break was to the right from the pitcher’s perspective, while a negative number means the break was to the left from the pitcher’s perspective.}
#' \item{PlateLocHeight}{The height of the ball relative to home plate, measured in feet, as the ball crosses the front of the plate.}
#' \item{PlateLocSide}{Distance from the center of the plate to the ball, measured in feet, as it crosses the front of the plate. Negative numbers are to the left of center from the pitcher’s perspective (outside to a right-handed batter). Positive numbers to the right of center from the pitcher’s perspective (inside to a right-handed batter).}
#' \item{ExitSpeed}{Initial velocity of the ball off the bat in mph (missing if the pitch was not put into play)}
#' }
#'
#' @source Duke Baseball coaching staff
#'
"pitcher_data"

