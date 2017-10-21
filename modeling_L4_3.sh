#!/bin/sh
#PBS -N ModelingLevel4SMO
#PBS -l nodes=1:ppn=40
#PBS -l walltime=10:00:00
#PBS -o TestJob.stdout
#PBS -e TestJob.stderr
#PBS -m be
#PBS -M akram.mohammed@unmc.edu
cd /work/unmc_gudalab/amohammed/model_new/70/Level4
perl ../../../ECemble/bin/modeling_L4_3.pl