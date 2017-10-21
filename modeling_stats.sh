#!/bin/sh
#PBS -N ModelingStats
#PBS -l select=1
#PBS -l walltime=1:00:00
#PBS -o ModelingStats.stdout
#PBS -e ModelingStats.stderr
#PBS -m be
#PBS -M akram.mohammed@unmc.edu
# cd $PBS_O_WORKDIR/model_new/70/Level0
# cat ssf_ps_pfam_all4_train80_sparse.arff|grep '^{'|grep -vc '^$'
# cat ssf_ps_pfam_all4_train80_sparse.arff|grep '^{'|grep -vc '^$'
# cat ssf_ps_pfam_all4_test20_sparse.arff|grep '^{'|grep -vc '^$'
# cat ssf_ps_pfam_all4_test20_sparse.arff|grep '^{'|grep -vc '^$'
# cat ssf_all4_top3_train_atleast2|wc -l
# cat ssf_all4_top3_train_exactly3|wc -l
# cat ssf_all4_top3_test_atleast2|wc -l
# cat ssf_all4_top3_test_exactly3|wc -l

#Enzymes Only
# cat ssf_all4_top3_train80_atleast2|wc -l
# cat ssf_all4_top3_train80_exactly3|wc -l
# cat ssf_all4_top3_test20_atleast2|wc -l
# cat ssf_all4_top3_test20_exactly3|wc -l

# cd $PBS_O_WORKDIR/model_new/70/Level1
# cat ssf_ps_pfam_enz4_new_sparse_train80.arff|grep '^{'|grep -vc '^$'
# cat ssf_ps_pfam_enz4_new_sparse_train80.arff|grep '^{'|grep -vc '^$'
# cat ssf_ps_pfam_enz4_new_sparse_test20.arff|grep '^{'|grep -vc '^$'
# cat ssf_ps_pfam_enz4_new_sparse_test20.arff|grep '^{'|grep -vc '^$'
# cat ssf_enz4_top3_train80_atleast2|wc -l
# cat ssf_enz4_top3_train80_exactly3|wc -l
# cat ssf_enz4_top3_test20_atleast2|wc -l
# cat ssf_enz4_top3_test20_exactly3|wc -l

# cd $PBS_O_WORKDIR/model_new/70/Level2
# cat ssf_ps_pfam_enz4_L2_new_EC*_sparse_train80.arff|grep '^{'|grep -vc '^$'
# cat ssf_ps_pfam_enz4_L2_new_EC*_sparse_train80.arff|grep '^{'|grep -vc '^$'
# cat ssf_ps_pfam_enz4_L2_new_EC*_sparse_test20.arff|grep '^{'|grep -vc '^$'
# cat ssf_ps_pfam_enz4_L2_new_EC*_sparse_test20.arff|grep '^{'|grep -vc '^$'
# cat ssf_enz4_train80_atleast2|wc -l
# cat ssf_enz4_train80_exactly3|wc -l
# cat ssf_enz4_test20_atleast2|wc -l
# cat ssf_enz4_test20_exactly3|wc -l

# cd $PBS_O_WORKDIR/model_new/70/Level3
# cat SSFPSPFENZ_L3_EC*.*_sparse_train80.arff|grep '^{'|grep -vc '^$'
# cat SSFPSPFENZ_L3_EC*.*_sparse_train80.arff|grep '^{'|grep -vc '^$'
# cat SSFPSPFENZ_L3_EC*.*_sparse_test20.arff|grep '^{'|grep -vc '^$'
# cat SSFPSPFENZ_L3_EC*.*_sparse_test20.arff|grep '^{'|grep -vc '^$'

# cat SSFPSPFENZ_L3_top3_EC*.*_train80_atleast2|grep -v '^$'>SSFPSPFENZ_top3_train80_atleast2
# cat SSFPSPFENZ_L3_top3_EC*.*_train80_exactly3|grep -v '^$'>SSFPSPFENZ_top3_train80_exactly3
# cat SSFPSPFENZ_L3_top3_EC*.*_test20_atleast2|grep -v '^$'>SSFPSPFENZ_top3_test20_atleast2
# cat SSFPSPFENZ_L3_top3_EC*.*_test20_exactly3|grep -v '^$'>SSFPSPFENZ_top3_test20_exactly3
# cat SSFPSPFENZ_top3_train80_atleast2|wc -l
# cat SSFPSPFENZ_top3_train80_exactly3|wc -l
# cat SSFPSPFENZ_top3_test20_atleast2|wc -l
# cat SSFPSPFENZ_top3_test20_exactly3|wc -l

cd $PBS_O_WORKDIR/model_new/70/Level4
cat SSFPSPFENZ_L4_EC*.*.*_sparse_train80.arff|grep '^{'|grep -vc '^$'
cat SSFPSPFENZ_L4_EC*.*.*_sparse_train80.arff|grep '^{'|grep -vc '^$'
cat SSFPSPFENZ_L4_EC*.*.*_sparse_test20.arff|grep '^{'|grep -vc '^$'
cat SSFPSPFENZ_L4_EC*.*.*_sparse_test20.arff|grep '^{'|grep -vc '^$'
cat SSFPSPFENZ_top3_train80_atleast2|wc -l
cat SSFPSPFENZ_top3_train80_exactly3|wc -l
cat SSFPSPFENZ_top3_test20_atleast2|wc -l
cat SSFPSPFENZ_top3_test20_exactly3|wc -l