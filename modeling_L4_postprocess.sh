#!/bin/sh
#PBS -N ModelingLevel4RemoveMiss
#PBS -l select=1
#PBS -o TestJob.stdout
#PBS -e TestJob.stderr
#PBS -m be
#PBS -M akram.mohammed@unmc.edu
cd /work/unmc_gudalab/amohammed/model_new/70/Level4
perl ../../../ECemble/bin/modeling_L4_postprocess.pl
