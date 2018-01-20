# This is an attempt to smooth the graph of the temperature values.
#
# Found this resourse online:
# http://r-statistics.co/Loess-Regression-With-R.html

# Set span variable for Loess function:
SPAN <- 0.03
# This value seems to perform the right amount of smoothing,
# but not too much.
# Other values tried: 0.25, 0.10, 0.05 -- all way to loose,
# and 0.01 -- not smooth enough.

# Create Loess variable:
loessModel <- loess(Temperature ~ as.numeric(X...Date...Time),
                    data = ambient[750:9364,], span = SPAN)

# Create column in ambient dataset:
ambient$Temp_Smooth <- NA

# Get smoothed output and assign that to the column Temp_Smooth:
ambient$Temp_Smooth[750:9364] <- predict(loessModel)

# Plot result:
plot(x = ambient$X...Date...Time, y = ambient$Temp_Smooth, type = "l")
