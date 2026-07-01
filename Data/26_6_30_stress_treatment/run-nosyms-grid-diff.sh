#!/bin/bash --login

## This file runs one experimental condition (i.e. a group of jobs
## that are the same except for their random seed)

## Email settings (they don't work for our setup)
#SBATCH --mail-type=ALL
#SBATCH --mail-user=does_not_work@carleton.edu

## Job name settings (These do matter, so UPDATE THEM)
#SBATCH --job-name=snsgd
#SBATCH -o snsgd%A_%a.out

## Memory requirement in megabytes. You might need to make this bigger.
#SBATCH --mem-per-cpu=1000M

## Launch an array of jobs. This determines your random seeds
#SBATCH --array=100-129

#SBATCH --nodes=1
#SBATCH --ntasks-per-node=29

cd /Accounts/roseg/symbulation/SpatialStruc2026/Data/26_6_30_stress_treatment
mkdir -p nosyms-grid-diff
cd nosyms-grid-diff

mkdir ${SLURM_ARRAY_TASK_ID}
cd ${SLURM_ARRAY_TASK_ID}

cp /Accounts/roseg/symbulation/SpatialStruc2026/Data/26_6_30_stress_treatment/SymSettings.cfg .
cp /Accounts/roseg/symbulation/SpatialStruc2026/Data/26_6_30_stress_treatment/diff-reward-env.json .
cp /Accounts/roseg/symbulation/SpatialStruc2026/SymbulationEmp/symbulation_sgp .

## THIS IS AN EXAMPLE, UPDATE TO CORRECT THINGS
args=" -START_MOI 0 -GRID 1 -HOST_MIN_CYCLES_BEFORE_REPRO 0 -HOST_REPRO_RES 100 \
-TASK_ENV_CFG_PATH diff-reward-env.json -FILE_NAME nosyms-grid-diff"
./symbulation_sgp $args -SEED ${SLURM_ARRAY_TASK_ID} > run.log

## Run with sbatch -p facultynode --nodelist=edmonstone2024,margulis2024,carver,lederberg run-nosyms-grid-diff.sh