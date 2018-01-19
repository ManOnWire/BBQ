# This is a project where temperature data recorded with an iGrillv2 will be
# read into R, and analysed. The original data is quite dense (about 10.000
# observations), so we must consolidate that a bit. Creating plots of the data
# seems to be the best way to communicate what happened inside the BBQ and
# inside the meat.

# Reading in the data:
ambient <- read.csv("iGrill_V2 - Ambient - 20180102.csv")
pork <- read.csv("iGrill_V2 - Pulled Pork - 20180102.csv")

# Exploring the data:
# str(ambient)
# head(ambient)
# tail(ambient)
# 
# str(pork)
# head(pork)
# tail(pork)
#
# It seems like the "X...Date...Time" variable is not in a proper date/time
# format. Now it seems tot be a factor, just as the "Temperature" variable. Both
# must be converted...
# 
# unique(ambient$X...Date...Time)
# unique(pork$X...Date...Time)
# It also seems like there are some doubles in the "X...Date..." columns. That
# should not be possible; date-time variables should be unique...
#
# The beginning of the timeseries seems to be identical between ambient and
# pork, though. the same cannot be said for the ending; that differs. So we need
# to bring both datasets into line...

