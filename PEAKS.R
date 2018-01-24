# This script uses code found on the internet for identifying peaks and valleys
# in the data. This is what I'm looking for in the context of the BBQ sessions,
# but also in connection with the Pipowagen project.
#
# In both cases there's a lot of data that we are trying to analyze and make
# sense of. Being able to identify the peaks / valleys should help. We could
# point to trend reversals, but in the case of sharper up- / downturns we could
# identify special situations (like the opening of the BBQ, or switching on the
# heater).

# This is the source of the code:
# https://stackoverflow.com/questions/22583391/peak-signal-detection-in-realtime-timeseries-data

# The algorythm is contained within a function:

ThresholdingAlgo <- function(y,lag,threshold,influence) {
  signals <- rep(0,length(y))
  filteredY <- y[0:lag]
  avgFilter <- NULL
  stdFilter <- NULL
  avgFilter[lag] <- mean(y[0:lag])
  stdFilter[lag] <- sd(y[0:lag])
  for (i in (lag+1):length(y)){
    if (abs(y[i]-avgFilter[i-1]) > threshold*stdFilter[i-1]) {
      if (y[i] > avgFilter[i-1]) {
        signals[i] <- 1;
      } else {
        signals[i] <- -1;
      }
      filteredY[i] <- influence*y[i]+(1-influence)*filteredY[i-1]
    } else {
      signals[i] <- 0
      filteredY[i] <- y[i]
    }
    avgFilter[i] <- mean(filteredY[(i-lag):i])
    stdFilter[i] <- sd(filteredY[(i-lag):i])
  }
  return(list("signals"=signals,"avgFilter"=avgFilter,"stdFilter"=stdFilter))
}

# Using it requires defining y, lag, threshold, and influence as inputs:
#
# Since the function doesn't work with NA's, the dataset should be free
# from them (otherwise the data and the result will consist of different
# numbers of observations).
y         <- na.omit(ambient$Temperature)
lag       <- 30
threshold <- 5
influence <- 0


# Running the algorythm, but note that the dataset contains NA's and those are
# incompatible with the algorithm. So they should be omitted:
result <- ThresholdingAlgo(y, lag, threshold, influence)


# Code for plotting the result:
par(mfrow = c(2,1),oma = c(2,2,0,0) + 0.1,mar = c(0,0,2,1) + 0.2)
plot(1:length(y),y,type="l",ylab="",xlab="") 
lines(1:length(y),result$avgFilter,type="l",col="cyan",lwd=2)
lines(1:length(y),result$avgFilter+threshold*result$stdFilter,type="l",col="green",lwd=2)
lines(1:length(y),result$avgFilter-threshold*result$stdFilter,type="l",col="green",lwd=2)
plot(result$signals,type="S",col="red",ylab="",xlab="",ylim=c(-1.5,1.5),lwd=2)

# Evaluation:
#
# This functions needs extensive tweaking for it to be useful. The idea of flagging
# a peak or a valley if the value in the data differs from the average value plus or
# minus a number of times the standard deviation seems OK, though.
#
# We need a function that:
#
# 1.
# Assesses if the (smoothed) temp value is lower than the mean minus 1x the
# standard deviation or higher than the mean plus 1x the standard deviation.
# When its lower we can flag the value as part of a valley, if it's higher
# we can mark it as member of a peak.

# First set Peak- and ValleyLimits:
PeakLimit <- mean(ambient$Temperature, na.rm = T) + sd(ambient$Temperature, na.rm = T)
ValleyLimit <- mean(ambient$Temperature, na.rm = T) - sd(ambient$Temperature, na.rm = T)

# Then perform the tests and set values for membership:
ambient$Peak_Member[ambient$Temperature > PeakLimit] <- TRUE
ambient$Peak_Member[ambient$Temperature <= PeakLimit] <- FALSE

ambient$Val_Member[ambient$Temperature < ValleyLimit] <- TRUE
ambient$Val_Member[ambient$Temperature >= ValleyLimit] <- FALSE

# 2.
# Find successive observations where Peak_Member is FALSE - TRUE (for beginning) and
# TRUE - FALSE (for the end).
#
# Find successive observations where Val_Member is FALSE - TRUE (for beginning) and
# TRUE - FALSE (for the end).
#
# Take the special circumstances for absolute beginning / ending of the data into
# account: TRUE - FALSE for starters indicates that the dataset started out with a
# peak / valley. It could also end with a peak / valley if the last pair of
# observations indicating a switch reads FALSE - TRUE...


