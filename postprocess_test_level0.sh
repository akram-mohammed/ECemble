#!/bin/sh

# Written by Akram Mohammed

# RemoveMissLevel0

## Remove MISCLASSIFIED instances and retrain at level 1 using TOP3
cat ../test/Level0/ssf_all4_SMO_*_sparse.p > ../test/Level0/ssf_all4_SMO_all_copy_sparse.p #have it in for loop for proper ordering
cat ../test/Level0/ssf_all4_IBK_*_sparse.p > ../test/Level0/ssf_all4_IBK_all_copy_sparse.p
cat ../test/Level0/ssf_all4_randomforest_*_sparse.p > ../test/Level0/ssf_all4_randomforest_all_copy_sparse.p
# predicted as enzymes and non enzymes
cat ../test/Level0/ssf_all4_SMO_all_copy_sparse.p |awk '/:/{print $5":"$3}'|sed 's/(//g'|sed 's/)//g'>../test/Level0/ssf_all4_SMO_all_copy_sparse
cat ../test/Level0/ssf_all4_IBK_all_copy_sparse.p |awk '/:/{print $5":"$3}'|sed 's/(//g'|sed 's/)//g'>../test/Level0/ssf_all4_IBK_all_copy_sparse
cat ../test/Level0/ssf_all4_randomforest_all_copy_sparse.p |awk '/:/{print $5":"$3}'|sed 's/(//g'|sed 's/)//g'>../test/Level0/ssf_all4_randomforest_all_copy_sparse
# correctly predicted by atleast 2 methods (from TOP3)
paste ../test/Level0/ssf_all4_SMO_all_copy_sparse ../test/Level0/ssf_all4_IBK_all_copy_sparse ../test/Level0/ssf_all4_randomforest_all_copy_sparse|awk -F"\t" '{if(($1==$2)||($2==$3)||($1==$3)) print $0}'|tr '\t' '\n'|sort -n|uniq -c|awk -F" " '{if(($1=="2")||($1=="3")) print $2}'|awk -F":" '!/NE/{print $1}'|grep -v '^$'>../test/Level0/ssf_all4_top3_copy_sparse_atleast2

# Below is common header
grep '^@' ../test/testseq.ssfpspfenz0_0.arff>../test/testseq.ssfpspfenzH.arff

# awk -F"\t" '{print NR "\t" $0}' ../proteome_testseq_ssfpspfsingleID>../proteome_testseq_ssfpspfsingleID_UID
# awk -F"\t" 'FILENAME=="ssf_all4_top3_copy_sparse_atleast2"{a[$1]=$0} FILENAME=="../proteome_testseq_ssfpspfsingleID_UID"{if(a[$1]){print a[$1] "\t" $0}}' ssf_all4_top3_copy_sparse_atleast2 ../proteome_testseq_ssfpspfsingleID_UID>proteome_testseq_ssfpspfsingleID_UID_L0
# cat proteome_testseq_ssfpspfsingleID_UID_L0|grep -c '_ARATH'>proteome_testseq_ssfpspfsingleID_UID_L0_count
# cat proteome_testseq_ssfpspfsingleID_UID_L0|grep -c '_CHICK'>proteome_testseq_ssfpspfsingleID_UID_L0_count
# cat proteome_testseq_ssfpspfsingleID_UID_L0|grep -c '_DROME'>proteome_testseq_ssfpspfsingleID_UID_L0_count
# cat proteome_testseq_ssfpspfsingleID_UID_L0|grep -c '_ECOLI'>proteome_testseq_ssfpspfsingleID_UID_L0_count
# cat proteome_testseq_ssfpspfsingleID_UID_L0|grep -c '_HUMAN'>proteome_testseq_ssfpspfsingleID_UID_L0_count
# cat proteome_testseq_ssfpspfsingleID_UID_L0|grep -c '_MOUSE'>proteome_testseq_ssfpspfsingleID_UID_L0_count
# cat proteome_testseq_ssfpspfsingleID_UID_L0|grep -c '_CAEEL'>proteome_testseq_ssfpspfsingleID_UID_L0_count
# cat proteome_testseq_ssfpspfsingleID_UID_L0|grep -c '_ORYSJ'>proteome_testseq_ssfpspfsingleID_UID_L0_count
# cat proteome_testseq_ssfpspfsingleID_UID_L0|grep -c '_YEAST'>proteome_testseq_ssfpspfsingleID_UID_L0_count
# cat proteome_testseq_ssfpspfsingleID_UID_L0|grep -c '_DANRE'>proteome_testseq_ssfpspfsingleID_UID_L0_count



## Remove MISCLASSIFIED instances and retrain at level 1 using TOP3
cat $filename\_L0_SMO_*.p > $filename\_L0_SMO_all.p #have it in for loop for proper ordering
cat $filename\_L0_IBK_*.p > $filename\_L0_IBK_all.p
cat $filename\_L0_randomforest_*.p > $filename\_L0_randomforest_all.p
# predicted as enzymes and non enzymes
cat $filename\_L0_SMO_all.p |awk '/:/{print $5":"$3}'|sed 's/(//g'|sed 's/)//g'>$filename\_L0_SMO_all
cat $filename\_L0_IBK_all.p |awk '/:/{print $5":"$3}'|sed 's/(//g'|sed 's/)//g'>$filename\_L0_IBK_all
cat $filename\_L0_randomforest_all.p |awk '/:/{print $5":"$3}'|sed 's/(//g'|sed 's/)//g'>$filename\_L0_randomforest_all
# correctly predicted by atleast 2 methods (from TOP3)
paste $filename\_L0_SMO_all $filename\_L0_IBK_all $filename\_L0_randomforest_all.p|awk -F"\t" '{if(($1==$2)||($2==$3)||($1==$3)) print $0}'|tr '\t' '\n'|sort -n|uniq -c|awk -F" " '{if(($1=="2")||($1=="3")) print $2}'|awk -F":" '!/NE/{print $1}'|grep -v '^$'>$filename\_L0_atleast2

# Below is common header
grep '^@' $filename\_enz0_0.arff >$filename\_enzH0_0.arff 
#../test/testseq.ssfpspfenz0_0.arff
#../test/testseq.ssfpspfenzH.arff

