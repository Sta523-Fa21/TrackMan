data <- suppressWarnings(read.table("Opponent Raw Trackman.zip", header=F,sep="\t", quote="\""))
colnames(data) <- c("Trackman")
data <- as_tibble(data) %>% .[-1,]
data <- suppressWarnings(cSplit(data, "Trackman", sep=",")) %>%
  as_tibble() %>%
  mutate_if(is.factor,as.character)
colnames(data) <- c("PitchNo", "Date", "Time", "PAofInning", "PitchofPA", "PitcherLastName", "PitcherFirstName", "PitcherID", "PitcherThrows", "PitcherTeam", "BatterLastName", "BatterFirstName", "BatterID", "BatterSide", "BatterTeam", "PitcherSet", "Inning", "Top/Bottom", "Outs", "Balls", "Strikes", "TaggedPitchType", "AutoPitchType", "PitchCall", "KorBB", "HitType", "PlayResult", "OutsonPlay", "RunsScored", "Notes", "RelSpeed", "VertRelAngle", "HorzRelAngle", "SpinRate", "SpinAxis", "Tilt", "RelHeight", "RelSide", "Extension", "VertBreak", "InducedVertBreak", "HorzBreak", "PlateLocHeight", "PlateLocSide", "ZoneSpeed", "VertApprAngle", "HorzApprAngle", "ZoneTime", "ExitSpeed", "ExitAngle", "ExitDirection", "HitSpinRate", "Positionat110X", "Positionat110Y", "Positionat110Z", "Distance", "LastTrackedDistance", "Bearing", "Hangtime", "pfxx", "pfxz", "x0", "y0", "z0", "vx0", "vy0", "vz0", "ax0", "ay0", "az0", "HomeTeam", "AwayTeam", "Stadium", "Level", "League", "GameID", "PitchUID")

usethis::use_data(Opponent Raw Trackman.zip, overwrite = TRUE)
