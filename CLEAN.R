# Cleaning the data...

# First converting the X...Date...Time variable from factor to character;
# then converting that to actual date-format.
ambient$X...Date...Time <- as.character(ambient$X...Date...Time)
pork$X...Date...Time <- as.character(pork$X...Date...Time)

# This (as.Date) leaves us with a date, but keeps the time out of view,
# so we will not be using it:
# ambient_test$X...Date...Time <- as.Date(ambient_test$X...Date...Time, "%d/%m/%Y, %H:%M:%S")

# strptime() does what we want:
ambient$X...Date...Time <- strptime(ambient$X...Date...Time, "%d/%m/%Y, %H:%M:%S")
pork$X...Date...Time <- strptime(pork$X...Date...Time, "%d/%m/%Y, %H:%M:%S")

# The temperature values are factors; convert those to numeric. We have to convert
# to character first, otherwise we get strange results.
ambient$Temperature <- as.numeric(as.character(ambient$Temperature))
pork$Temperature <- as.numeric(as.character(pork$Temperature))

# It seems like the action starts at about observation / row #750, so we can discard
# anything before that:
#
# which.min(pork$Temperature)
# >> 750
#
# Timewise, this coincides with 8:30 in the morning. Measurements started at
# 7:10, though. In order to keep that time in the picture, we should replace
# the temperature data in the first 749 rows with NA's:
ambient$Temperature[0:749] <- NA
pork$Temperature[0:749] <- NA

# From about row #9365 (pork) the action seems to have stopped. (The temperature
# drops fast after that, signalling the removal of the probe from the meat.)
# So we will replace the temperatures on all the other rows with NA's as well:
ambient$Temperature[9365:nrow(ambient)] <- NA
pork$Temperature[9365:nrow(pork)] <- NA

# This works, but it has revealed that the time values are not exactly the same
# for each row. So row #750 in the ambient dataset has a time value of 08:28:59
# while the same row in pork corresponds to 08:28:17. About the same, but not
# exactly the same...
