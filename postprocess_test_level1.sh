#!/bin/sh

# Written by Akram Mohammed

# RemoveMissLevel1

## Remove MISCLASSIFIED instances and retrain at level 2 using TOP3: SVM,IBK,RandomForest
cat ../test/Level1/ssf_enz4_SMO_*_sparse.p > ../test/Level1/ssf_enz4_SMO_all_copy_sparse.p # have(*) it in for loop for proper ordering
cat ../test/Level1/ssf_enz4_IBK_*_sparse.p > ../test/Level1/ssf_enz4_IBK_all_copy_sparse.p
cat ../test/Level1/ssf_enz4_randomforest_*_sparse.p > ../test/Level1/ssf_enz4_randomforest_all_copy_sparse.p
# predicted as enzymes
cat ../test/Level1/ssf_enz4_SMO_all_copy_sparse.p |awk '/:/{print $5":"$3}'|sed 's/(//g'|sed 's/)//g'>../test/Level1/ssf_enz4_SMO_all_copy_sparse
cat ../test/Level1/ssf_enz4_IBK_all_copy_sparse.p |awk '/:/{print $5":"$3}'|sed 's/(//g'|sed 's/)//g'>../test/Level1/ssf_enz4_IBK_all_copy_sparse
cat ../test/Level1/ssf_enz4_randomforest_all_copy_sparse.p |awk '/:/{print $5":"$3}'|sed 's/(//g'|sed 's/)//g'>../test/Level1/ssf_enz4_randomforest_all_copy_sparse
# correctly predicted by atleast 2 methods
paste ../test/Level1/ssf_enz4_SMO_all_copy_sparse ../test/Level1/ssf_enz4_IBK_all_copy_sparse ../test/Level1/ssf_enz4_randomforest_all_copy_sparse|awk -F"\t" '{if(($1==$2)||($2==$3)||($1==$3)) print $0}'|tr '\t' '\n'|sort -n|uniq -c|awk -F" " '{if(($1=="2")||($1=="3")) print $2}'|grep -v '^$'>../test/Level1/ssf_enz4_top3_copy_sparse_atleast2

# cat ssf_enz4_top3_copy_sparse_atleast2|cut -d":" -f1>ssf_enz4_top3_copy_sparse_atleast2_UID
# awk -F"\t" 'FILENAME=="ssf_enz4_top3_copy_sparse_atleast2_UID"{a[$1]=$0} FILENAME=="../proteome_testseq_ssfpspfsingleID_UID"{if(a[$1]){print a[$1] "\t" $0}}' ssf_enz4_top3_copy_sparse_atleast2_UID ../proteome_testseq_ssfpspfsingleID_UID>proteome_testseq_ssfpspfsingleID_UID_L1
# cat proteome_testseq_ssfpspfsingleID_UID_L1|grep -c '_ARATH'>proteome_testseq_ssfpspfsingleID_UID_L1_count
# cat proteome_testseq_ssfpspfsingleID_UID_L1|grep -c '_CHICK'>proteome_testseq_ssfpspfsingleID_UID_L1_count
# cat proteome_testseq_ssfpspfsingleID_UID_L1|grep -c '_DROME'>proteome_testseq_ssfpspfsingleID_UID_L1_count
# cat proteome_testseq_ssfpspfsingleID_UID_L1|grep -c '_ECOLI'>proteome_testseq_ssfpspfsingleID_UID_L1_count
# cat proteome_testseq_ssfpspfsingleID_UID_L1|grep -c '_HUMAN'>proteome_testseq_ssfpspfsingleID_UID_L1_count
# cat proteome_testseq_ssfpspfsingleID_UID_L1|grep -c '_MOUSE'>proteome_testseq_ssfpspfsingleID_UID_L1_count
# cat proteome_testseq_ssfpspfsingleID_UID_L1|grep -c '_CAEEL'>proteome_testseq_ssfpspfsingleID_UID_L1_count
# cat proteome_testseq_ssfpspfsingleID_UID_L1|grep -c '_ORYSJ'>proteome_testseq_ssfpspfsingleID_UID_L1_count
# cat proteome_testseq_ssfpspfsingleID_UID_L1|grep -c '_YEAST'>proteome_testseq_ssfpspfsingleID_UID_L1_count
# cat proteome_testseq_ssfpspfsingleID_UID_L1|grep -c '_DANRE'>proteome_testseq_ssfpspfsingleID_UID_L1_count