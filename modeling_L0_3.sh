#!/bin/sh
#PBS -N modelLevel0Job3
#PBS -l select=1
#PBS -l walltime=30:00:00
#PBS -o TestJob3.stdout
#PBS -e TestJob3.stderr
#PBS -m be
#PBS -M akram.mohammed@unmc.edu
cd $PBS_O_WORKDIR/weka-3-7-6
java -Xmx50g weka.classifiers.meta.FilteredClassifier -F "weka.filters.unsupervised.attribute.Remove -R first" -W weka.classifiers.functions.SMO -t ../model_new/70/Level0/ssf_ps_pfam_all4_train80_sparse.arff -i -o -d ../model_new/70/Level0/ssf_all4_SMO_train80_sparse.model
java -Xmx50g weka.classifiers.functions.SMO -T ../model_new/70/Level0/ssf_ps_pfam_all4_train80_sparse.arff -l ../model_new/70/Level0/ssf_all4_SMO_train80_sparse.model -i -o >../model_new/70/Level0/ssf_all4_SMO_train80_sparse.result
java -Xmx50g weka.classifiers.functions.SMO -T ../model_new/70/Level0/ssf_ps_pfam_all4_test20_sparse.arff -l ../model_new/70/Level0/ssf_all4_SMO_train80_sparse.model -i -o >../model_new/70/Level0/ssf_all4_SMO_train80_test20_sparse.result
java -Xmx50g weka.classifiers.functions.SMO -T ../model_new/70/Level0/ssf_ps_pfam_all4_train80_sparse.arff -l ../model_new/70/Level0/ssf_all4_SMO_train80_sparse.model -p 1 -distribution >../model_new/70/Level0/ssf_all4_SMO_train80_sparse.p
java -Xmx50g weka.classifiers.functions.SMO -T ../model_new/70/Level0/ssf_ps_pfam_all4_test20_sparse.arff -l ../model_new/70/Level0/ssf_all4_SMO_train80_sparse.model -p 1 -distribution >../model_new/70/Level0/ssf_all4_SMO_test20_sparse.p

java -Xmx50g weka.classifiers.functions.SMO -T ../model_new/70/Level0/ssf_ps_pfam_all4_train80_sparse.arff -l ../model_new/70/Level0/ssf_all4_SMO_train80_sparse.model -threshold-file ../model_new/70/Level0/ssf_all4_SMO_thresholdNE_train80.csv -threshold-label NE
java -Xmx50g weka.classifiers.functions.SMO -T ../model_new/70/Level0/ssf_ps_pfam_all4_train80_sparse.arff -l ../model_new/70/Level0/ssf_all4_SMO_train80_sparse.model -threshold-file ../model_new/70/Level0/ssf_all4_SMO_thresholdE_train80.csv -threshold-label E
java -Xmx50g weka.classifiers.functions.SMO -T ../model_new/70/Level0/ssf_ps_pfam_all4_test20_sparse.arff -l ../model_new/70/Level0/ssf_all4_SMO_train80_sparse.model -threshold-file ../model_new/70/Level0/ssf_all4_SMO_thresholdNE_test20.csv -threshold-label NE
java -Xmx50g weka.classifiers.functions.SMO -T ../model_new/70/Level0/ssf_ps_pfam_all4_test20_sparse.arff -l ../model_new/70/Level0/ssf_all4_SMO_train80_sparse.model -threshold-file ../model_new/70/Level0/ssf_all4_SMO_thresholdE_test20.csv -threshold-label E