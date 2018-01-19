# Now that we have some reasonably clean data, we can do something with it. Like
# plot some graphs:
plot(ambient, type = "l")

# Add average to the plot:
ambient_mean <- mean(ambient$Temperature, na.rm = T)
abline(h = ambient_mean, col = "green")

# Add standard deviation to plot:
ambient_sd <- sd(ambient$Temperature, na.rm = T)
abline(h = ambient_mean - ambient_sd, col = "orange")
abline(h = ambient_mean + ambient_sd, col = "orange")


plot(pork, type = "l")

# A histogram of the ambient temperature seems interesting:
hist(ambient$Temperature, breaks = 20)

# Or a density curve:
plot(density(ambient$Temperature, na.rm = T), type = "l")

# In table form, we can summarize the data:
summary(ambient$Temperature)
summary(pork$Temperature)

# We can calculate the (exact?) cooking time:
# which.min(pork$Temperature)
# which.max(pork$Temperature)
# pork$X...Date...Time[750]
# pork$X...Date...Time[9307]
# pork$X...Date...Time[9307] - pork$X...Date...Time[750]

# In one shot:
pork$X...Date...Time[which.max(pork$Temperature)] -
  pork$X...Date...Time[which.min(pork$Temperature)]

# > Time difference of 9.486667 hours, dus ca. 9.5 uur!
# Met voorbereidingstijd en verwerkingstijd hebben we het over
# een uur of 12 tot 14, schat ik...
#
# Was dus een flinke klus, maar het resultaat mocht er wezen.