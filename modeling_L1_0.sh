#!/bin/sh
#PBS -N ModelingLevel1PreProcess
#PBS -l select=1
#PBS -l walltime=10:00:00
#PBS -o TestJobL1_0.stdout
#PBS -e TestJobL1_0.stderr
#PBS -m be
#PBS -M akram.mohammed@unmc.edu
cd $PBS_O_WORKDIR/model_new/70
#some steps skipped; done on metastasis; ssf_ps_pfam_enz3.arff
#Map and remove misclassified ones: map correctly predicted ones to source arff file for level 1 predictions
awk -F"," 'FILENAME=="Level1/ssf_ps_pfam_enz3.arff"{a[$1]=$0} FILENAME=="Level0/ssf_all4_top3_sparse_atleast2"{if(a[$1]){print a[$1]}}' Level1/ssf_ps_pfam_enz3.arff Level0/ssf_all4_top3_sparse_atleast2>Level1/ssf_ps_pfam_enz3_new.arff
cat Level1/ssf_ps_pfam_enz1.arff Level1/ssf_ps_pfam_enz3_new.arff>Level1/ssf_ps_pfam_enz4_new.arff

cd $PBS_O_WORKDIR/weka-3-7-6
#SPARSE FORMAT:
java -Xmx50g weka.filters.unsupervised.instance.NonSparseToSparse -i ../model_new/70/Level1/ssf_ps_pfam_enz4_new.arff -o ../model_new/70/Level1/ssf_ps_pfam_enz4_new_sparse.arff

cd $PBS_O_WORKDIR/weka-3-7-6
java -Xmx50g weka.filters.supervised.instance.StratifiedRemoveFolds -i ../model_new/70/Level1/ssf_ps_pfam_enz4_new_sparse.arff -o ../model_new/70/Level1/ssf_ps_pfam_enz4_new_sparse_train80.arff -c last -S 5 -N 5 -F 1 -V
java -Xmx50g weka.filters.supervised.instance.StratifiedRemoveFolds -i ../model_new/70/Level1/ssf_ps_pfam_enz4_new_sparse.arff -o ../model_new/70/Level1/ssf_ps_pfam_enz4_new_sparse_test20.arff -c last -S 5 -N 5 -F 1