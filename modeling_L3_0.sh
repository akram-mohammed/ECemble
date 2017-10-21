#!/bin/sh
#PBS -N ModelingLevel3Map&Remove
#PBS -l select=1
#PBS -l walltime=1:00:00
#PBS -o ModelingLevel3Map&Remove.stdout
#PBS -e ModelingLevel3Map&Remove.stderr
#PBS -m be
#PBS -M akram.mohammed@unmc.edu
cd /work/unmc_gudalab/amohammed/model_new/70/Level3
perl ../../../ECemble/bin/modeling_L3_0.pl
