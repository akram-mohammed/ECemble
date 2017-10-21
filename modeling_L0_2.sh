#!/bin/sh
#PBS -N modelLevel0Job2
#PBS -l select=1
#PBS -l walltime=24:00:00
#PBS -o TestJob2.stdout
#PBS -e TestJob2.stderr
#PBS -m be
#PBS -M akram.mohammed@unmc.edu
cd $PBS_O_WORKDIR/weka-3-7-6
java -Xmx70g weka.classifiers.meta.FilteredClassifier -F "weka.filters.unsupervised.attribute.Remove -R first" -W weka.classifiers.lazy.IBk -t ../model_new/70/Level0/ssf_ps_pfam_all4_train80_sparse.arff -o -i -d ../model_new/70/Level0/ssf_all4_IBK_train80_sparse.model>../model_new/70/Level0/ssf_all4_IBK_train80_sparse.result
java -Xmx70g weka.classifiers.lazy.IBk -T ../model_new/70/Level0/ssf_ps_pfam_all4_test20_sparse.arff -l ../model_new/70/Level0/ssf_all4_IBK_train80_sparse.model -o -i >../model_new/70/Level0/ssf_all4_IBK_train80_test20_sparse.result
java -Xmx70g weka.classifiers.lazy.IBk -T ../model_new/70/Level0/ssf_ps_pfam_all4_train80_sparse.arff -l ../model_new/70/Level0/ssf_all4_IBK_train80_sparse.model -p 1 -distribution >../model_new/70/Level0/ssf_all4_IBK_train80_sparse.p
java -Xmx70g weka.classifiers.lazy.IBk -T ../model_new/70/Level0/ssf_ps_pfam_all4_test20_sparse.arff -l ../model_new/70/Level0/ssf_all4_IBK_train80_sparse.model -p 1 -distribution >../model_new/70/Level0/ssf_all4_IBK_test20_sparse.p

java -Xmx70g -Xss5g weka.classifiers.lazy.IBk -T ../model_new/70/Level0/ssf_ps_pfam_all4_train80_sparse.arff -l ../model_new/70/Level0/ssf_all4_IBK_train80_sparse.model -threshold-file ../model_new/70/Level0/ssf_all4_IBK_thresholdNE_train80.csv -threshold-label NE
java -Xmx70g -Xss5g weka.classifiers.lazy.IBk -T ../model_new/70/Level0/ssf_ps_pfam_all4_train80_sparse.arff -l ../model_new/70/Level0/ssf_all4_IBK_train80_sparse.model -threshold-file ../model_new/70/Level0/ssf_all4_IBK_thresholdE_train80.csv -threshold-label E
java -Xmx70g -Xss5g weka.classifiers.lazy.IBk -T ../model_new/70/Level0/ssf_ps_pfam_all4_test20_sparse.arff -l ../model_new/70/Level0/ssf_all4_IBK_train80_sparse.model -threshold-file ../model_new/70/Level0/ssf_all4_IBK_thresholdNE_test20.csv -threshold-label NE
java -Xmx70g -Xss5g weka.classifiers.lazy.IBk -T ../model_new/70/Level0/ssf_ps_pfam_all4_test20_sparse.arff -l ../model_new/70/Level0/ssf_all4_IBK_train80_sparse.model -threshold-file ../model_new/70/Level0/ssf_all4_IBK_thresholdE_test20.csv -threshold-label E
