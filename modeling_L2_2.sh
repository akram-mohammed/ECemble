#!/bin/sh
#PBS -N ModelingLevel2Job2
#PBS -l select=1
#SBATCH --time=10:00:00
#PBS -o TestJob2.stdout
#PBS -e TestJob2.stderr
#PBS -m be
#PBS -M akram.mohammed@unmc.edu
cd /work/unmc_gudalab/amohammed/weka-3-7-6
for (( i=1; i<=6; i++ ))
do
java -Xmx50g weka.classifiers.meta.FilteredClassifier -F "weka.filters.unsupervised.attribute.Remove -R first" -W weka.classifiers.lazy.IBk -t ../model_new/70/Level2/ssf_ps_pfam_enz4_L2_new_EC$i\_sparse_train80.arff -o -i -d ../model_new/70/Level2/ssf_enz4_L2_IBK_new_EC$i\_sparse_train80.model>../model_new/70/Level2/ssf_enz4_IBK_new_EC$i\_sparse_train80.result
java -Xmx5g weka.classifiers.lazy.IBk -T ../model_new/70/Level2/ssf_ps_pfam_enz4_L2_new_EC$i\_sparse_test20.arff -l ../model_new/70/Level2/ssf_enz4_L2_IBK_new_EC$i\_sparse_train80.model -o -i >../model_new/70/Level2/ssf_enz4_L2_IBK_new_EC$i\_sparse_train80_test20.result
java -Xmx5g weka.classifiers.lazy.IBk -T ../model_new/70/Level2/ssf_ps_pfam_enz4_L2_new_EC$i\_sparse_train80.arff -l ../model_new/70/Level2/ssf_enz4_L2_IBK_new_EC$i\_sparse_train80.model -p 1 -distribution >../model_new/70/Level2/ssf_enz4_L2_IBK_new_EC$i\_sparse_train80.p
java -Xmx5g weka.classifiers.lazy.IBk -T ../model_new/70/Level2/ssf_ps_pfam_enz4_L2_new_EC$i\_sparse_test20.arff -l ../model_new/70/Level2/ssf_enz4_L2_IBK_new_EC$i\_sparse_train80.model -p 1 -distribution >../model_new/70/Level2/ssf_enz4_L2_IBK_new_EC$i\_sparse_test20.p
done