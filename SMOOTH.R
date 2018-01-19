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

# Reduce span:
loessMod10 <- loess(Temperature ~ Index, data = ambient, span = 0.10)

# Get smoothed output:
smoothed10 <- predict(loessMod10)

# Plot result:
plot(smoothed10, type = "l")

# Reduce span further:
loessMod5 <- loess(Temperature ~ Index, data = ambient, span = 0.05)

# Get smoothed output:
smoothed5 <- predict(loessMod5)

# Plot result:
plot(smoothed5, type = "l")
