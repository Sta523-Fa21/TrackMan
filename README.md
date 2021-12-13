# TrackMan
Initially created as a  golf tracking technology, the TrackMan system has become ubiquitous across the highest levels of baseball. Major League Baseball has implemented TrackMan as part of its Statcast package and the metrics it provides have increasingly become a significant talking point in its TV broadcasts. With respect to college baseball, the vast majority of Power 5 schools have invested in the technology, using it either as a tool for recruitment or performance enhancement. The sudden increase in the popularity of TrackMan has brought about a swath of data that is still being investigated, but in our brief experience in examining the data, we believe that the effectiveness of a pitch can largely be reduced to its velocity, spin rate, tilt, and induced vertical break. Spin rate and tilt describe, respectively, the rate in rpm at which and axis, measured like the hands on a clock, on which the ball spins.  Induced vertical break describes the vertical difference in inches between where the ball crosses home plate and where it would have crossed if gravity alone acted on the ball. Similarly, we suppose that a swing can be summed up by its exit velocity and angle at which it exits the bat. Given these hypotheses, it seems natural to build a model to attempt to predict performance from these metrics alone. Due to the idiosyncracies inherent in baseball, the model we will employ will be a random forest and will predict three performance metrics: hitter exit velocity, pitcher exit velocity against, and pitcher swing and miss rate. These models will susbequently be created as functions to allow any pitch or swing to be predicted as well as to allow any training data set to be used and will be stored in a package aptly named TrackMan for wider use among fans in the baseball community.
