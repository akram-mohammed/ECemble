#!/bin/sh
#PBS -N ModelingLevel2Job5
#PBS -l select=1
#PBS -l walltime=10:00:00
#PBS -o TestJob5.stdout
#PBS -e TestJob5.stderr
#PBS -m be
#PBS -M akram.mohammed@unmc.edu
cd $PBS_O_WORKDIR/weka-3-7-6
for (( i=1; i<=6; i++ ))
do
java -Xmx50g -Xss5g weka.classifiers.meta.FilteredClassifier -F "weka.filters.unsupervised.attribute.Remove -R first" -W weka.classifiers.trees.RandomForest -t ../model_new/70/Level2/ssf_ps_pfam_enz4_L2_new_EC$i\_sparse_train80.arff -i -d ../model_new/70/Level2/ssf_enz4_L2_randomforest_new_EC$i\_sparse_train80.model>../model_new/70/Level2/ssf_enz4_randomforest_new_EC$i\_sparse_train80.result
java -Xmx50g -Xss5g weka.classifiers.trees.RandomForest -T ../model_new/70/Level2/ssf_ps_pfam_enz4_L2_new_EC$i\_sparse_test20.arff -l ../model_new/70/Level2/ssf_enz4_L2_randomforest_new_EC$i\_sparse_train80.model -i >../model_new/70/Level2/ssf_enz4_L2_randomforest_new_EC$i\_sparse_train80_test20.result
java -Xmx50g -Xss5g weka.classifiers.trees.RandomForest -T ../model_new/70/Level2/ssf_ps_pfam_enz4_L2_new_EC$i\_sparse_train80.arff -l ../model_new/70/Level2/ssf_enz4_L2_randomforest_new_EC$i\_sparse_train80.model -p 1 -distribution >../model_new/70/Level2/ssf_enz4_L2_randomforest_new_EC$i\_sparse_train80.p
java -Xmx50g -Xss5g weka.classifiers.trees.RandomForest -T ../model_new/70/Level2/ssf_ps_pfam_enz4_L2_new_EC$i\_sparse_test20.arff -l ../model_new/70/Level2/ssf_enz4_L2_randomforest_new_EC$i\_sparse_train80.model -p 1 -distribution >../model_new/70/Level2/ssf_enz4_L2_randomforest_new_EC$i\_sparse_test20.p
done