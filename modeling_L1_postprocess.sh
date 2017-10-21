#!/bin/sh
#PBS -N ModelingLevel1PostProcess
#PBS -l select=1
#PBS -l walltime=10:00:00
#PBS -o TestJob.stdout
#PBS -e TestJob.stderr
#PBS -m be
#PBS -M akram.mohammed@unmc.edu
# cd $PBS_O_WORKDIR/model_new/70/Level1
##Remove MISCLASSIFIED instances and retrain at level 2
# cat ssf_enz4_SMO_train80_sparse.p ssf_enz4_SMO_test20_sparse.p > ssf_enz4_SMO_sparse_all.p
# cat ssf_enz4_IBK_train80_sparse.p ssf_enz4_IBK_test20_sparse.p > ssf_enz4_IBK_sparse_all.p
# cat ssf_enz4_randomforest_train80_sparse.p ssf_enz4_randomforest_test20_sparse.p > ssf_enz4_randomforest_sparse_all.p
##correctly classified
# cat ssf_enz4_SMO_sparse_all.p|awk '/:/{if($2==$3) print $5":"$3}'|sed 's/(//g'|sed 's/)//g'>ssf_enz4_SMO_sparse_all
# cat ssf_enz4_IBK_sparse_all.p|awk '/:/{if($2==$3) print $5":"$3}'|sed 's/(//g'|sed 's/)//g'>ssf_enz4_IBK_sparse_all
# cat ssf_enz4_randomforest_sparse_all.p|awk '/:/{if($2==$3) print $5":"$3}'|sed 's/(//g'|sed 's/)//g'>ssf_enz4_randomforest_sparse_all
# paste ssf_enz4_SMO_sparse_all ssf_enz4_IBK_sparse_all ssf_enz4_randomforest_sparse_all |tr '\t' '\n'|sort -n|uniq -c|awk -F" " '{if(($1=="2")||($1=="3")) print $2}'|awk -F":" '/E/{print $1}'>ssf_enz4_top3_sparse_atleast2
# cat ssf_enz4_top3_sparse_atleast2|wc -l
# paste ssf_enz4_SMO_sparse_all ssf_enz4_IBK_sparse_all ssf_enz4_randomforest_sparse_all|tr '\t' '\n'|sort -n|uniq -c|awk -F" " '{if(($1=="3")) print $2}'|awk -F":" '/E/{print $1}'>ssf_enz4_top3_sparse_exactly3
# cat ssf_enz4_top3_sparse_exactly3|wc -l

# paste ssf_enz4_SMO_sparse_all ssf_enz4_IBK_sparse_all ssf_enz4_randomforest_sparse_all |tr '\t' '\n'|sort -n|uniq -c|awk -F" " '{if(($1=="2")||($1=="3")) print $2}'|awk -F":" '/E/{print $1 "\t" $3}'>ssf_enz4_top3_sparse_atleast2_label


cd $PBS_O_WORKDIR/model_new/70/Level1
#correctly classified
cat ssf_enz4_SMO_train80_sparse.p|awk '/:/{if($2==$3) print $5":"$3}'|sed 's/(//g'|sed 's/)//g'>ssf_enz4_SMO_train80_sparse
cat ssf_enz4_IBK_train80_sparse.p|awk '/:/{if($2==$3) print $5":"$3}'|sed 's/(//g'|sed 's/)//g'>ssf_enz4_IBK_train80_sparse
cat ssf_enz4_randomforest_train80_sparse.p|awk '/:/{if($2==$3) print $5":"$3}'|sed 's/(//g'|sed 's/)//g'>ssf_enz4_randomforest_train80_sparse
paste ssf_enz4_SMO_train80_sparse ssf_enz4_IBK_train80_sparse ssf_enz4_randomforest_train80_sparse|tr '\t' '\n'|sort -n|uniq -c|awk -F" " '{if(($1=="2")||($1=="3")) print $2}'|awk -F":" '/E/{print $1}'|grep -v '^$'>ssf_enz4_top3_train80_atleast2

paste ssf_enz4_SMO_train80_sparse ssf_enz4_IBK_train80_sparse ssf_enz4_randomforest_train80_sparse|tr '\t' '\n'|sort -n|uniq -c|awk -F" " '{if(($1=="3")) print $2}'|awk -F":" '/E/{print $1}'|grep -v '^$'>ssf_enz4_top3_train80_exactly3
cat ssf_enz4_SMO_test20_sparse.p|awk '/:/{if($2==$3) print $5":"$3}'|sed 's/(//g'|sed 's/)//g'>ssf_enz4_SMO_test20_sparse
cat ssf_enz4_IBK_test20_sparse.p|awk '/:/{if($2==$3) print $5":"$3}'|sed 's/(//g'|sed 's/)//g'>ssf_enz4_IBK_test20_sparse
cat ssf_enz4_randomforest_test20_sparse.p|awk '/:/{if($2==$3) print $5":"$3}'|sed 's/(//g'|sed 's/)//g'>ssf_enz4_randomforest_test20_sparse

paste ssf_enz4_SMO_test20_sparse ssf_enz4_IBK_test20_sparse ssf_enz4_randomforest_test20_sparse|tr '\t' '\n'|sort -n|uniq -c|awk -F" " '{if(($1=="2")||($1=="3")) print $2}'|awk -F":" '/E/{print $1}'|grep -v '^$'>ssf_enz4_top3_test20_atleast2
paste ssf_enz4_SMO_test20_sparse ssf_enz4_IBK_test20_sparse ssf_enz4_randomforest_test20_sparse|tr '\t' '\n'|sort -n|uniq -c|awk -F" " '{if(($1=="3")) print $2}'|awk -F":" '/E/{print $1}'|grep -v '^$'>ssf_enz4_top3_test20_exactly3