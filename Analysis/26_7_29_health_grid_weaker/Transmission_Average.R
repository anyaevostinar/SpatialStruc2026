require(ggplot2)
install.packages("viridis")
library(viridis)
library(dplyr)
library(tidyr) 

#Set your working directory to the Analysis folder for your project

#Read in the data
initial_data <- read.table("munged_transmission_rates.dat", h=T)
treatment_data <- subset(initial_data, treatment == "parasites-grid")
treatment_data <- subset(treatment_data, update <= 100000)

# reshape to long format so each metric becomes its own line
treatment_long <- treatment_data %>%
  pivot_longer(
    cols = c(horiz_attempts, horiz_successes, vert_attempts, vert_successes),
    names_to = "metric",
    values_to = "Transmissions"
  )

treatment_long$metric <- factor(treatment_long$metric,
                                levels = c("horiz_attempts", "horiz_successes",
                                           "vert_attempts", "vert_successes"))

# Over time
ggplot(data=treatment_long, 
       aes(x=update, y=Transmissions, group=metric, colour=metric)) +
  ylab("Transmissions") + 
  xlab("Evolutionary time (in updates)") + 
  stat_summary(aes(color=metric, fill=metric),
               fun.data="mean_cl_boot", geom=c("smooth")) + 
  theme(panel.background = element_rect(fill='white', colour='black')) + 
  theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank()) +
  scale_fill_manual(values = viridis(4)) +
  guides(fill=FALSE) + scale_color_manual(values=viridis(4))
