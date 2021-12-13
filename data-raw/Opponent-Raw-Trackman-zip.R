library(tidyverse)
library(splitstackshape)

RawTrackMan <- suppressWarnings(read.table("Opponent Raw Trackman.zip", header=F,sep="\t", quote="\""))
colnames(RawTrackMan) <- c("Trackman")
RawTrackMan <- as_tibble(RawTrackMan) %>% .[-1,]
RawTrackMan <- suppressWarnings(cSplit(RawTrackMan, "Trackman", sep=",")) %>%
  as_tibble() %>%
  mutate_if(is.factor,as.character)
colnames(RawTrackMan) <- c("PitchNo", "Date", "Time", "PAofInning", "PitchofPA", "PitcherLastName", "PitcherFirstName", "PitcherID", "PitcherThrows", "PitcherTeam", "BatterLastName", "BatterFirstName", "BatterID", "BatterSide", "BatterTeam", "PitcherSet", "Inning", "Top/Bottom", "Outs", "Balls", "Strikes", "TaggedPitchType", "AutoPitchType", "PitchCall", "KorBB", "HitType", "PlayResult", "OutsonPlay", "RunsScored", "Notes", "RelSpeed", "VertRelAngle", "HorzRelAngle", "SpinRate", "SpinAxis", "Tilt", "RelHeight", "RelSide", "Extension", "VertBreak", "InducedVertBreak", "HorzBreak", "PlateLocHeight", "PlateLocSide", "ZoneSpeed", "VertApprAngle", "HorzApprAngle", "ZoneTime", "ExitSpeed", "ExitAngle", "ExitDirection", "HitSpinRate", "Positionat110X", "Positionat110Y", "Positionat110Z", "Distance", "LastTrackedDistance", "Bearing", "Hangtime", "pfxx", "pfxz", "x0", "y0", "z0", "vx0", "vy0", "vz0", "ax0", "ay0", "az0", "HomeTeam", "AwayTeam", "Stadium", "Level", "League", "GameID", "PitchUID")

usethis::use_data(RawTrackMan, overwrite = TRUE)
