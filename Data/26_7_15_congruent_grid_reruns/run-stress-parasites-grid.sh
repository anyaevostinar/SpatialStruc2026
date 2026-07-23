#!/bin/bash --login

## This file runs one experimental condition (i.e. a group of jobs
## that are the same except for their random seed)

## Email settings (they don't work for our setup)
#SBATCH --mail-type=ALL
#SBATCH --mail-user=does_not_work@carleton.edu

## Job name settings (These do matter, so UPDATE THEM)
#SBATCH --job-name=spg
#SBATCH -o spg%A_%a.out

## Memory requirement in megabytes. You might need to make this bigger.
#SBATCH --mem-per-cpu=1000M

## Launch an array of jobs. This determines your random seeds
#SBATCH --array=100-129

#SBATCH --nodes=1

cd /Accounts/roseg/symbulation/SpatialStruc2026/Data/26_7_15_congruent_grid_reruns
mkdir -p stress-parasites-grid
cd stress-parasites-grid

mkdir ${SLURM_ARRAY_TASK_ID}
cd ${SLURM_ARRAY_TASK_ID}

cp /Accounts/roseg/symbulation/SpatialStruc2026/Data/26_7_15_congruent_grid_reruns/SymSettings.cfg .
cp /Accounts/roseg/symbulation/SpatialStruc2026/Data/26_7_15_congruent_grid_reruns/flat-reward-2-env.json .
cp /Accounts/roseg/symbulation/SpatialStruc2026/SymbulationEmp/symbulation_sgp .

## THIS IS AN EXAMPLE, UPDATE TO CORRECT THINGS
args=" -START_MOI 1 -SPATIAL_STRUCT_MODE grid -ENABLE_STRESS 1 -STRESS_TYPE parasite -TASK_ENV_CFG_PATH flat-reward-2-env.json \
  -HOST_REPRO_RES 2 -SYM_HORIZ_TRANS_RES 2 \
  -HOST_MIN_CYCLES_BEFORE_REPRO 100 -SYM_MIN_CYCLES_BEFORE_REPRO 10 \
  -VERTICAL_TRANSMISSION 0 \
  -PARASITE_DEATH_CHANCE 0.75 -MUTUALIST_DEATH_CHANCE 0.125 \
  -BASE_DEATH_CHANCE 0 -PARASITE_NUM_OFFSPRING_ON_STRESS_INTERACTION 8"
./symbulation_sgp $args -SEED ${SLURM_ARRAY_TASK_ID} > run.log

## Run with sbatch -p facultynode --nodelist=edmonstone2024,margulis2024,carver,lederberg run-stress-parasites-grid.sh