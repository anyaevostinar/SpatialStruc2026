require(ggplot2)
#install.packages("viridis")
library(viridis)

#Set your working directory to the Analysis folder for your project

#Read in the data
initial_data <- read.table("rep_task_count.dat", h=T)
initial_data$task <- factor(initial_data$task, levels = c("NOT", "NAND", "OR_NOT", "AND", "OR", "AND_NOT", "NOR", "XOR", "EQU"))

#Plot the host and symbiont task counts
ggplot(data=initial_data, aes(x=task, y=count, fill=task)) + 
  geom_bar(stat="identity", alpha=0.5, color="black") + 
  ylab("Task Completion Counts") + 
  xlab("Task") + 
  theme(panel.background = element_rect(fill='white', colour='black')) + 
  theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank()) + 
  guides(fill=FALSE) + 
  scale_fill_manual(name="Partner", values=viridis(9)) + 
  facet_grid(treatment ~ partner)
