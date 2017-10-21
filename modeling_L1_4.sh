#!/bin/sh
#PBS -N ModelingLevel1Job4
#PBS -l select=1
#PBS -l walltime=10:00:00
#PBS -o TestJob4.stdout
#PBS -e TestJob4.stderr
#PBS -m be
#PBS -M akram.mohammed@unmc.edu
cd $PBS_O_WORKDIR/weka-3-7-6
java -Xmx50g weka.classifiers.meta.FilteredClassifier -F "weka.filters.unsupervised.attribute.Remove -R first" -W weka.classifiers.trees.DecisionStump -t ../model_new/70/Level1/ssf_ps_pfam_enz4_new_sparse_train80.arff -o -i -d ../model_new/70/Level1/ssf_enz4_decisionStump_train80_sparse.model >../model_new/70/Level1/ssf_enz4_decisionStump_train80_sparse.result
java -Xmx50g weka.classifiers.trees.DecisionStump -T ../model_new/70/Level1/ssf_ps_pfam_enz4_new_sparse_test20.arff -l ../model_new/70/Level1/ssf_enz4_decisionStump_train80_sparse.model -o -i >../model_new/70/Level1/ssf_enz4_decisionStump_train80_test20_sparse.result
java -Xmx50g weka.classifiers.trees.DecisionStump -T ../model_new/70/Level1/ssf_ps_pfam_enz4_new_sparse_train80.arff -l ../model_new/70/Level1/ssf_enz4_decisionStump_train80_sparse.model -p 1 -distribution>../model_new/70/Level1/ssf_enz4_decisionStump_train80_sparse.p
java -Xmx50g weka.classifiers.trees.DecisionStump -T ../model_new/70/Level1/ssf_ps_pfam_enz4_new_sparse_test20.arff -l ../model_new/70/Level1/ssf_enz4_decisionStump_train80_sparse.model -p 1 -distribution>../model_new/70/Level1/ssf_enz4_decisionStump_test20_sparse.p

for (( i=1; i<=6; i++ ))
do
java -Xmx50g -Xss5g weka.classifiers.trees.DecisionStump -T ../model_new/70/Level1/ssf_ps_pfam_enz4_new_sparse_train80.arff -l ../model_new/70/Level1/ssf_enz4_decisionStump_train80_sparse.model -threshold-file ../model_new/70/Level1/ssf_enz4_decisionStump_thresholdEC1_train80.csv -threshold-label EC$i
java -Xmx50g -Xss5g weka.classifiers.trees.DecisionStump -T ../model_new/70/Level1/ssf_ps_pfam_enz4_new_sparse_test20.arff -l ../model_new/70/Level1/ssf_enz4_decisionStump_train80_sparse.model -threshold-file ../model_new/70/Level1/ssf_enz4_decisionStump_thresholdEC1_test20.csv -threshold-label EC$i
done
