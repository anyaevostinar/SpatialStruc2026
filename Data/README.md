This folder contains the configuration and scripts for generating the data. The data itself is too much to fit onto GitHub, but with these two files for each treatment, you should be able to regenerate all data.

To regenerate the data in a folder, first make the executable of Symbulation in SymbulationEmp, then go into the folder of interest and either run the slurm script if you have a cluster, or look at the end of the slurm script for the line that starts with `./symbulation_sgp`.

The starter settings for stress runs can be found in this repo: https://github.com/john-k-903849031/ALIFE2026-StressSymbiosis/blob/main/data though some things are now called something else.