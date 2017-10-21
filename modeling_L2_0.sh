#!/bin/sh
#PBS -N ModelingLevel2PreProcess
#PBS -l select=1
#PBS -l walltime=10:00:00
#PBS -o TestJobL2_0.stdout
#PBS -e TestJobL2_0.stderr
#PBS -m be
#PBS -M akram.mohammed@unmc.edu
# cd $PBS_O_WORKDIR/model_new/70
##ssf_ps_pfam_enz_addECclass to be added to ssf_ps_pfam_enz2.arff
# cat Level1/enz_L1|cut -f2|cut -d"." -f1,2|awk '{print ",EC"$0}'>Level2/enz_L2_addECclass
##append label as the last column
# awk 'NR==FNR{a[NR]=$0; next} {$(NF+1)=a[FNR]}1' Level2/enz_L2_addECclass Level1/ssf_ps_pfam_enz2.arff|sed 's/'' ''/''''/g'>Level2/ssf_ps_pfam_enz3_L2.arff
##Map and remove misclassified ones: map correctly predicted ones to source arff file for level 2 predictions
# awk -F"," 'FILENAME=="Level2/ssf_ps_pfam_enz3_L2.arff"{a[$1]=$0} FILENAME=="Level1/ssf_enz4_top3_sparse_atleast2"{if(a[$1]){print a[$1]}}' Level2/ssf_ps_pfam_enz3_L2.arff Level1/ssf_enz4_top3_sparse_atleast2>Level2/ssf_ps_pfam_enz3_L2_new.arff
# cd $PBS_O_WORKDIR/weka-3-7-6
# for (( i=1; i<=6; i++ ))
# do
# cp ../model_new/70/Level1/ssf_ps_pfam_enz1.arff ../model_new/70/Level2/ssf_ps_pfam_enz1_L2_EC$i.arff
# cat ../model_new/70/Level2/ssf_ps_pfam_enz3_L2_new.arff |grep "EC"$i".">../model_new/70/Level2/ssf_ps_pfam_enz3_L2_new_EC$i.arff
##MANUALLY add the class label line in the above line
# done

cd $PBS_O_WORKDIR/weka-3-7-6
for (( i=1; i<=6; i++ ))
do
cat ../model_new/70/Level2/ssf_ps_pfam_enz1_L2_EC$i.arff ../model_new/70/Level2/ssf_ps_pfam_enz3_L2_new_EC$i.arff>../model_new/70/Level2/ssf_ps_pfam_enz4_L2_new_EC$i.arff
##SPARSE FORMAT:
java -Xmx70g weka.filters.unsupervised.instance.NonSparseToSparse -i ../model_new/70/Level2/ssf_ps_pfam_enz4_L2_new_EC$i.arff -o ../model_new/70/Level2/ssf_ps_pfam_enz4_L2_new_EC$i\_sparse.arff
java -Xmx70g weka.filters.supervised.instance.StratifiedRemoveFolds -i ../model_new/70/Level2/ssf_ps_pfam_enz4_L2_new_EC$i\_sparse.arff -o ../model_new/70/Level2/ssf_ps_pfam_enz4_L2_new_EC$i\_sparse_train80.arff -c last -S 5 -N 5 -F 1 -V
java -Xmx70g weka.filters.supervised.instance.StratifiedRemoveFolds -i ../model_new/70/Level2/ssf_ps_pfam_enz4_L2_new_EC$i\_sparse.arff -o ../model_new/70/Level2/ssf_ps_pfam_enz4_L2_new_EC$i\_sparse_test20.arff -c last -S 5 -N 5 -F 1
done

