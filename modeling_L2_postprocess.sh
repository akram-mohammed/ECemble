#!/bin/sh
#PBS -N ModelingLevel2PostProcess
#PBS -l select=1
#PBS -l walltime=10:00:00
#PBS -o TestJob.stdout
#PBS -e TestJob.stderr
#PBS -m be
#PBS -M akram.mohammed@unmc.edu
#cd $PBS_O_WORKDIR/model_new/70/Level2
# for (( i=1; i<=6; i++ ))
# do
#Remove MISCLASSIFIED instances and retrain at level 3
# cat ssf_enz4_L2_SMO_new_EC$i\_sparse_train80.p ssf_enz4_L2_SMO_new_EC$i\_sparse_test20.p > ssf_enz4_L2_SMO_new_EC$i\_sparse_all.p
# cat ssf_enz4_L2_IBK_new_EC$i\_sparse_train80.p ssf_enz4_L2_IBK_new_EC$i\_sparse_test20.p > ssf_enz4_L2_IBK_new_EC$i\_sparse_all.p
# cat ssf_enz4_L2_randomforest_new_EC$i\_sparse_train80.p ssf_enz4_L2_randomforest_new_EC$i\_sparse_test20.p > ssf_enz4_L2_randomforest_new_EC$i\_sparse_all.p
#correctly classified
# cat ssf_enz4_L2_SMO_new_EC$i\_sparse_all.p|awk '/:/{if($2==$3) print $5":"$3}'|sed 's/(//g'|sed 's/)//g'>ssf_enz4_L2_SMO_new_EC$i\_sparse_all
# cat ssf_enz4_L2_IBK_new_EC$i\_sparse_all.p|awk '/:/{if($2==$3) print $5":"$3}'|sed 's/(//g'|sed 's/)//g'>ssf_enz4_L2_IBK_new_EC$i\_sparse_all
# cat ssf_enz4_L2_randomforest_new_EC$i\_sparse_all.p|awk '/:/{if($2==$3) print $5":"$3}'|sed 's/(//g'|sed 's/)//g'>ssf_enz4_L2_randomforest_new_EC$i\_sparse_all
# paste ssf_enz4_L2_SMO_new_EC$i\_sparse_all ssf_enz4_L2_IBK_new_EC$i\_sparse_all ssf_enz4_L2_randomforest_new_EC$i\_sparse_all|tr '\t' '\n'|sort -n|uniq -c|awk -F" " '{if(($1=="2")||($1=="3")) print $2}'>ssf_enz4_L2_top3_new_EC$i\_sparse_atleast2
# cat ssf_enz4_L2_top3_new_EC$i\_sparse_atleast2>>ssf_enz4_L2_all_EC_sparse_atleast2
# paste ssf_enz4_L2_SMO_new_EC$i\_sparse_all ssf_enz4_L2_IBK_new_EC$i\_sparse_all ssf_enz4_L2_randomforest_new_EC$i\_sparse_all|tr '\t' '\n'|sort -n|uniq -c|awk -F" " '{if(($1=="3")) print $2}'>ssf_enz4_L2_top3_new_EC$i\_sparse_exactly3
# cat ssf_enz4_L2_top3_new_EC$i\_sparse_exactly3>>ssf_enz4_L2_all_EC_sparse_exactly3
# done
# cat ssf_enz4_L2_all_EC_sparse_atleast2|wc -l
# cat ssf_enz4_L2_all_EC_sparse_exactly3|wc -l

cd /work/unmc_gudalab/amohammed/model_new/70/Level2
for (( i=1; i<=6; i++ ))
do
##correctly classified
cat ssf_enz4_L2_SMO_new_EC$i\_sparse_train80.p|awk '/:/{if($2==$3) print $5":"$3}'|sed 's/(//g'|sed 's/)//g'>ssf_enz4_L2_SMO_new_EC$i\_sparse_train80
cat ssf_enz4_L2_IBK_new_EC$i\_sparse_train80.p|awk '/:/{if($2==$3) print $5":"$3}'|sed 's/(//g'|sed 's/)//g'>ssf_enz4_L2_IBK_new_EC$i\_sparse_train80
cat ssf_enz4_L2_randomforest_new_EC$i\_sparse_train80.p|awk '/:/{if($2==$3) print $5":"$3}'|sed 's/(//g'|sed 's/)//g'>ssf_enz4_L2_randomforest_new_EC$i\_sparse_train80
paste ssf_enz4_L2_SMO_new_EC$i\_sparse_train80 ssf_enz4_L2_IBK_new_EC$i\_sparse_train80 ssf_enz4_L2_randomforest_new_EC$i\_sparse_train80|tr '\t' '\n'|sort -n|uniq -c|awk -F" " '{if(($1=="2")||($1=="3")) print $2}'>ssf_enz4_L2_top3_new_EC$i\_sparse_train80_atleast2
cat ssf_enz4_L2_top3_new_EC$i\_sparse_train80_atleast2>>ssf_enz4_L2_train80_EC_sparse_atleast2
paste ssf_enz4_L2_SMO_new_EC$i\_sparse_train80 ssf_enz4_L2_IBK_new_EC$i\_sparse_train80 ssf_enz4_L2_randomforest_new_EC$i\_sparse_train80|tr '\t' '\n'|sort -n|uniq -c|awk -F" " '{if(($1=="3")) print $2}'>ssf_enz4_L2_top3_new_EC$i\_sparse_train80_exactly3
cat ssf_enz4_L2_top3_new_EC$i\_sparse_train80_exactly3>>ssf_enz4_L2_train80_EC_sparse_exactly3

##correctly classified
cat ssf_enz4_L2_SMO_new_EC$i\_sparse_test20.p|awk '/:/{if($2==$3) print $5":"$3}'|sed 's/(//g'|sed 's/)//g'>ssf_enz4_L2_SMO_new_EC$i\_sparse_test20
cat ssf_enz4_L2_IBK_new_EC$i\_sparse_test20.p|awk '/:/{if($2==$3) print $5":"$3}'|sed 's/(//g'|sed 's/)//g'>ssf_enz4_L2_IBK_new_EC$i\_sparse_test20
cat ssf_enz4_L2_randomforest_new_EC$i\_sparse_test20.p|awk '/:/{if($2==$3) print $5":"$3}'|sed 's/(//g'|sed 's/)//g'>ssf_enz4_L2_randomforest_new_EC$i\_sparse_test20
paste ssf_enz4_L2_SMO_new_EC$i\_sparse_test20 ssf_enz4_L2_IBK_new_EC$i\_sparse_test20 ssf_enz4_L2_randomforest_new_EC$i\_sparse_test20|tr '\t' '\n'|sort -n|uniq -c|awk -F" " '{if(($1=="2")||($1=="3")) print $2}'>ssf_enz4_L2_top3_new_EC$i\_sparse_test20_atleast2
cat ssf_enz4_L2_top3_new_EC$i\_sparse_test20_atleast2>>ssf_enz4_L2_test20_EC_sparse_atleast2
paste ssf_enz4_L2_SMO_new_EC$i\_sparse_test20 ssf_enz4_L2_IBK_new_EC$i\_sparse_test20 ssf_enz4_L2_randomforest_new_EC$i\_sparse_test20|tr '\t' '\n'|sort -n|uniq -c|awk -F" " '{if(($1=="3")) print $2}'>ssf_enz4_L2_top3_new_EC$i\_sparse_test20_exactly3
cat ssf_enz4_L2_top3_new_EC$i\_sparse_test20_exactly3>>ssf_enz4_L2_test20_EC_sparse_exactly3

cat ssf_enz4_L2_top3_new_EC$i\_sparse_train80_atleast2 ssf_enz4_L2_top3_new_EC$i\_sparse_test20_atleast2>ssf_enz4_L2_top3_new_EC$i\_sparse_atleast2

done

cat ssf_enz4_L2_train80_EC_sparse_atleast2|grep -v '^$'>ssf_enz4_train80_atleast2
cat ssf_enz4_L2_train80_EC_sparse_exactly3|grep -v '^$'>ssf_enz4_train80_exactly3
cat ssf_enz4_L2_test20_EC_sparse_atleast2|grep -v '^$'>ssf_enz4_test20_atleast2
cat ssf_enz4_L2_test20_EC_sparse_exactly3|grep -v '^$'>ssf_enz4_test20_exactly3
cat ssf_enz4_train80_atleast2 ssf_enz4_test20_atleast2 >ssf_enz4_all_atleast2
cat ssf_enz4_train80_exactly3 ssf_enz4_test20_exactly3 >ssf_enz4_all_exactly3