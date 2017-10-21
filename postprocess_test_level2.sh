#!/bin/sh

# Written by Akram Mohammed

# RemoveMissLevel2

for (( i=1; i<=6; i++ ))
do
# Remove MISCLASSIFIED instances and retrain at level 3 using TOP3: SVM,IBK,RandomForest
# predicted as enzymes at level2
cat ../test/Level2/UniGene_SSFPSPFENZ_L2_SMO_EC$i\_sparse.p |awk '/:/{print $5":"$3}'|sed 's/(//g'|sed 's/)//g'>../test/Level2/UniGene_SSFPSPFENZ_L2_SMO_EC$i\_sparse
cat ../test/Level2/UniGene_SSFPSPFENZ_L2_IBK_EC$i\_sparse.p |awk '/:/{print $5":"$3}'|sed 's/(//g'|sed 's/)//g'>../test/Level2/UniGene_SSFPSPFENZ_L2_IBK_EC$i\_sparse
cat ../test/Level2/UniGene_SSFPSPFENZ_L2_randomforest_EC$i\_sparse.p |awk '/:/{print $5":"$3}'|sed 's/(//g'|sed 's/)//g'>../test/Level2/UniGene_SSFPSPFENZ_L2_randomforest_EC$i\_sparse
# correctly predicted by atleast 2 methods
paste ../test/Level2/UniGene_SSFPSPFENZ_L2_SMO_EC$i\_sparse ../test/Level2/UniGene_SSFPSPFENZ_L2_IBK_EC$i\_sparse ../test/Level2/UniGene_SSFPSPFENZ_L2_randomforest_EC$i\_sparse|awk -F"\t" '{if(($1==$2)||($2==$3)||($1==$3)) print $0}'|tr '\t' '\n'|sort -n|uniq -c|awk -F" " '{if(($1=="2")||($1=="3")) print $2}'|grep -v '^$'> ../test/Level2/UniGene_SSFPSPFENZ_L2_all_EC$i\_sparse_atleast2
cat ../test/Level2/UniGene_SSFPSPFENZ_L2_all_EC$i\_sparse_atleast2>>../test/Level2/UniGene_SSFPSPFENZ_L2_all_EC_sparse_atleast2
done
# cat UniGene_SSFPSPFENZ_L2_all_EC_sparse_atleast2|cut -d":" -f1>UniGene_SSFPSPFENZ_L2_all_EC_sparse_atleast2_UID
# awk -F"\t" 'FILENAME=="UniGene_SSFPSPFENZ_L2_all_EC_sparse_atleast2_UID"{a[$1]=$0} FILENAME=="../proteome_testseq_ssfpspfsingleID_UID"{if(a[$1]){print a[$1] "\t" $0}}' UniGene_SSFPSPFENZ_L2_all_EC_sparse_atleast2_UID ../proteome_testseq_ssfpspfsingleID_UID>proteome_testseq.ssfpspfsingleID_UID_L2
# cat proteome_testseq.ssfpspfsingleID_UID_L2|grep -c '_ARATH'>proteome_testseq.ssfpspfsingleID_UID_L2_count
# cat proteome_testseq.ssfpspfsingleID_UID_L2|grep -c '_CHICK'>proteome_testseq.ssfpspfsingleID_UID_L2_count
# cat proteome_testseq.ssfpspfsingleID_UID_L2|grep -c '_DROME'>proteome_testseq.ssfpspfsingleID_UID_L2_count
# cat proteome_testseq.ssfpspfsingleID_UID_L2|grep -c '_ECOLI'>proteome_testseq.ssfpspfsingleID_UID_L2_count
# cat proteome_testseq.ssfpspfsingleID_UID_L2|grep -c '_HUMAN'>proteome_testseq.ssfpspfsingleID_UID_L2_count
# cat proteome_testseq.ssfpspfsingleID_UID_L2|grep -c '_MOUSE'>proteome_testseq.ssfpspfsingleID_UID_L2_count
# cat proteome_testseq.ssfpspfsingleID_UID_L2|grep -c '_CAEEL'>proteome_testseq.ssfpspfsingleID_UID_L2_count
# cat proteome_testseq.ssfpspfsingleID_UID_L2|grep -c '_ORYSJ'>proteome_testseq.ssfpspfsingleID_UID_L2_count
# cat proteome_testseq.ssfpspfsingleID_UID_L2|grep -c '_YEAST'>proteome_testseq.ssfpspfsingleID_UID_L2_count
# cat proteome_testseq.ssfpspfsingleID_UID_L2|grep -c '_DANRE'>proteome_testseq.ssfpspfsingleID_UID_L2_count