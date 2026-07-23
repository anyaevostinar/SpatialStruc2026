#!/bin/bash --login

## This file runs one experimental condition (i.e. a group of jobs
## that are the same except for their random seed)

## Email settings (they don't work for our setup)
#SBATCH --mail-type=ALL
#SBATCH --mail-user=does_not_work@carleton.edu

## Job name settings (These do matter, so UPDATE THEM)
#SBATCH --job-name=np5
#SBATCH -o np5%A_%a.out

## Memory requirement in megabytes. You might need to make this bigger.
#SBATCH --mem-per-cpu=2000M

## Launch an array of jobs. This determines your random seeds
#SBATCH --array=100-129

#SBATCH --nodes=1

cd /Accounts/roseg/symbulation/SpatialStruc2026/Data/26_7_23_health_nut-par_multisym
mkdir -p nutrient-parasites-ms5
cd nutrient-parasites-ms5

mkdir ${SLURM_ARRAY_TASK_ID}
cd ${SLURM_ARRAY_TASK_ID}

cp /Accounts/roseg/symbulation/SpatialStruc2026/Data/26_7_23_health_nut-par_multisym/SymSettings.cfg .
cp /Accounts/roseg/symbulation/SpatialStruc2026/Data/26_7_23_health_nut-par_multisym/flat-reward-2-env.json .
cp /Accounts/roseg/symbulation/SpatialStruc2026/SymbulationEmp/symbulation_sgp .

## THIS IS AN EXAMPLE, UPDATE TO CORRECT THINGS
args=" -START_MOI 1 -SYM_LIMIT 5 -ENABLE_NUTRIENT 1 -NUTRIENT_TYPE parasite -TASK_ENV_CFG_PATH flat-reward-2-env.json \
  -HOST_REPRO_RES 3.5 -SYM_HORIZ_TRANS_RES 1 \
  -HOST_MIN_CYCLES_BEFORE_REPRO 100 -SYM_MIN_CYCLES_BEFORE_REPRO 10 \
  -VERTICAL_TRANSMISSION 0"
./symbulation_sgp $args -SEED ${SLURM_ARRAY_TASK_ID} > run.log

## Run with sbatch -p facultynode --nodelist=edmonstone2024,margulis2024,carver,lederberg run-nutrient-parasites-ms5.sh