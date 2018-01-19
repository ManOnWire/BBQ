# This is an attempt to smooth the graph of the temperature values.
#
# Found this resourse online:
# http://r-statistics.co/Loess-Regression-With-R.html

# Create Loess variable:
ambient$Index <- 1:nrow(ambient)
loessMod25 <- loess(Temperature ~ Index, data = ambient, span = 0.25)

# Get smoothed output:
smoothed25 <- predict(loessMod25)

# Plot result:
plot(smoothed25, type = "l")