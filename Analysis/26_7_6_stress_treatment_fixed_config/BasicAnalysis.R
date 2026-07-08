require(ggplot2)
install.packages("viridis")
library(viridis)

#Set your working directory to the Analysis folder for your project

#Read in the data
initial_data <- read.table("26_7_6_stress_treatment_fixed_config/munged_basic_tasks.dat", h=T)
par_data <- subset(initial_data, treatment %in% c("parasites-mixed", "parasites-grid", "nosyms-grid-flat"))
mut_data <- subset(initial_data, treatment %in% c("mutualists-mixed", "mutualists-grid", "nosyms-grid-diff"))
par_final_update <- subset(par_data, update == "500000")
mut_final_update <- subset(mut_data, update == "500000")



#Plot the host and symbiont task counts
ggplot(data=par_final_update, aes(x=treatment, y=task_count, color=partner)) + geom_boxplot(alpha=0.5, outlier.size=0) + ylab("Final Task Counts") + xlab("Task") + theme(panel.background = element_rect(fill='white', colour='black')) + theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank()) + guides(fill=FALSE) + scale_color_manual(name="Partner", values=viridis(3)) + facet_wrap(~task)

# Over time
ggplot(data=subset(par_data, partner=="Host"), aes(x=update, y=task_count, group=treatment, colour=treatment)) + ylab("Mean task count for hosts") + xlab("Evolutionary time (in updates)") + stat_summary(aes(color=treatment, fill=treatment),fun.data="mean_cl_boot", geom=c("smooth")) + theme(panel.background = element_rect(fill='white', colour='black')) + theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank()) + guides(fill=FALSE) + facet_wrap(~task) + scale_color_manual(values=viridis(3))

ggplot(data=subset(par_data, partner=="Sym"), aes(x=update, y=task_count, group=treatment, colour=treatment)) + ylab("Mean task count for symbionts") + xlab("Evolutionary time (in updates)") + stat_summary(aes(color=treatment, fill=treatment),fun.data="mean_cl_boot", geom=c("smooth")) + theme(panel.background = element_rect(fill='white', colour='black')) + theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank()) + guides(fill=FALSE) + facet_wrap(~task) + scale_color_manual(values=viridis(3))


#Plot the host and symbiont task counts
ggplot(data=mut_final_update, aes(x=treatment, y=task_count, color=partner)) + geom_boxplot(alpha=0.5, outlier.size=0) + ylab("Final Task Counts") + xlab("Task") + theme(panel.background = element_rect(fill='white', colour='black')) + theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank()) + guides(fill=FALSE) + scale_color_manual(name="Partner", values=viridis(3)) + facet_wrap(~task)

# Over time
ggplot(data=subset(mut_data, partner=="Host"), aes(x=update, y=task_count, group=treatment, colour=treatment)) + ylab("Mean task count for hosts") + xlab("Evolutionary time (in updates)") + stat_summary(aes(color=treatment, fill=treatment),fun.data="mean_cl_boot", geom=c("smooth")) + theme(panel.background = element_rect(fill='white', colour='black')) + theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank()) + guides(fill=FALSE) + facet_wrap(~task) + scale_color_manual(values=viridis(3))

ggplot(data=subset(mut_data, partner=="Sym"), aes(x=update, y=task_count, group=treatment, colour=treatment)) + ylab("Mean task count for symbionts") + xlab("Evolutionary time (in updates)") + stat_summary(aes(color=treatment, fill=treatment),fun.data="mean_cl_boot", geom=c("smooth")) + theme(panel.background = element_rect(fill='white', colour='black')) + theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank()) + guides(fill=FALSE) + facet_wrap(~task) + scale_color_manual(values=viridis(3))
