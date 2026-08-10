#!/bin/bash --login

## This file runs one experimental condition (i.e. a group of jobs
## that are the same except for their random seed)

## Email settings (they don't work for our setup)
#SBATCH --mail-type=ALL
#SBATCH --mail-user=does_not_work@carleton.edu

## Job name settings (These do matter, so UPDATE THEM)
#SBATCH --job-name=hpgw1
#SBATCH -o hpgw1%A_%a.out

## Memory requirement in megabytes. You might need to make this bigger.
#SBATCH --mem-per-cpu=2000M

## Launch an array of jobs. This determines your random seeds
#SBATCH --array=100-129

#SBATCH --nodes=1


cd /Accounts/roseg/symbulation/SpatialStruc2026/Data/26_8_10_health_grid_weak
mkdir -p health-parasites-gridw1
cd health-parasites-gridw1

mkdir ${SLURM_ARRAY_TASK_ID}
cd ${SLURM_ARRAY_TASK_ID}

cp /Accounts/roseg/symbulation/SpatialStruc2026/Data/26_8_10_health_grid_weak/par_SymSettings.cfg ./SymSettings.cfg
cp /Accounts/roseg/symbulation/SpatialStruc2026/Data/26_8_10_health_grid_weak/flat-reward-2-env.json .
cp /Accounts/roseg/symbulation/SpatialStruc2026/SymbulationEmp/symbulation_sgp .

## THIS IS AN EXAMPLE, UPDATE TO CORRECT THINGS
args="-ENABLE_HEALTH 1 -WORLD_WIDTH 1 -WORLD_HEIGHT 10000"
./symbulation_sgp $args -SEED ${SLURM_ARRAY_TASK_ID} > run.log

## Run with sbatch -p facultynode --nodelist=edmonstone2024,margulis2024,carver,lederberg run-health-mutualists-ms5.sh