#!/bin/sh
#PBS -N ModelingLevel0PostProcess
#PBS -l select=1
#PBS -l walltime=10:00:00
#PBS -o TestJob.stdout
#PBS -e TestJob.stderr
#PBS -m be
#PBS -M akram.mohammed@unmc.edu

#cd $PBS_O_WORKDIR/model_new/70/Level0
##Remove MISCLASSIFIED instances and retrain at level 1 using TOP3: SVM,IBK,RandomForest
# cat ssf_all4_SMO_train80_sparse.p ssf_all4_SMO_test20_sparse.p > ssf_all4_SMO_all_sparse.p
# cat ssf_all4_IBK_train80_sparse.p ssf_all4_IBK_test20_sparse.p > ssf_all4_IBK_all_sparse.p
# cat ssf_all4_randomforest_train80_sparse.p ssf_all4_randomforest_test20_sparse.p > ssf_all4_randomforest_all_sparse.p
##correctly classified
# cat ssf_all4_SMO_all_sparse.p|awk '/:/{if($2==$3&&$2=="2:E") print $5":"$3}'|sed 's/(//g'|sed 's/)//g'>ssf_all4_SMO_all_sparse
# cat ssf_all4_IBK_all_sparse.p|awk '/:/{if($2==$3&&$2=="2:E") print $5":"$3}'|sed 's/(//g'|sed 's/)//g'>ssf_all4_IBK_all_sparse
# cat ssf_all4_randomforest_all_sparse.p|awk '/:/{if($2==$3&&$2=="2:E") print $5":"$3}'|sed 's/(//g'|sed 's/)//g'>ssf_all4_randomforest_all_sparse

# paste ssf_all4_SMO_all_sparse ssf_all4_IBK_all_sparse ssf_all4_randomforest_all_sparse|tr '\t' '\n'|sort -n|uniq -c|awk -F" " '{if(($1=="2")||($1=="3")) print $2}'|awk -F":" '/E/{print $1}'>ssf_all4_top3_sparse_atleast2
# cat ssf_all4_top3_sparse_atleast2|wc -l
# paste ssf_all4_SMO_all_sparse ssf_all4_IBK_all_sparse ssf_all4_randomforest_all_sparse|tr '\t' '\n'|sort -n|uniq -c|awk -F" " '{if(($1=="3")) print $2}'|awk -F":" '/E/{print $1}'>ssf_all4_top3_sparse_exactly3
# cat ssf_all4_top3_sparse_exactly3|wc -l
##For non-enzyme sequence statistics
##Remove MISCLASSIFIED instances and retrain at level 1 using TOP3: SVM,IBK,RandomForest
# cat ssf_all4_SMO_train80_sparse.p ssf_all4_SMO_test20_sparse.p > ssf_all4_SMO_all_sparse.p
# cat ssf_all4_IBK_train80_sparse.p ssf_all4_IBK_test20_sparse.p > ssf_all4_IBK_all_sparse.p
# cat ssf_all4_randomforest_train80_sparse.p ssf_all4_randomforest_test20_sparse.p > ssf_all4_randomforest_all_sparse.p
##correctly classified
# cat ssf_all4_SMO_all_sparse.p|awk '/:/{if($2==$3) print $5":"$3}'|sed 's/(//g'|sed 's/)//g'>ssf_all4_SMO_allALL_sparse
# cat ssf_all4_IBK_all_sparse.p|awk '/:/{if($2==$3) print $5":"$3}'|sed 's/(//g'|sed 's/)//g'>ssf_all4_IBK_allALL_sparse
# cat ssf_all4_randomforest_all_sparse.p|awk '/:/{if($2==$3) print $5":"$3}'|sed 's/(//g'|sed 's/)//g'>ssf_all4_randomforest_allALL_sparse
# paste ssf_all4_SMO_allALL_sparse ssf_all4_IBK_allALL_sparse ssf_all4_randomforest_allALL_sparse|tr '\t' '\n'|sort -n|uniq -c|awk -F" " '{if(($1=="2")||($1=="3")) print $2}'|awk -F":" '/E/{print $1}'>ssf_allALL4_top3_sparse_atleast2
# cat ssf_allALL4_top3_sparse_atleast2|wc -l
# paste ssf_all4_SMO_allALL_sparse ssf_all4_IBK_allALL_sparse ssf_all4_randomforest_allALL_sparse|tr '\t' '\n'|sort -n|uniq -c|awk -F" " '{if(($1=="3")) print $2}'|awk -F":" '/E/{print $1}'>ssf_allALL4_top3_sparse_exactly3
# cat ssf_allALL4_top3_sparse_exactly3|wc -l

# cat ssf_all4_decisionStump_train80_sparse.p ssf_all4_decisionStump_test20_sparse.p > ssf_all4_decisionStump_all_sparse.p
# cat ssf_all4_naivebayes_train80_sparse.p ssf_all4_naivebayes_test20_sparse.p > ssf_all4_naivebayes_all_sparse.p
# cat ssf_all4_naivebayes_all_sparse.p|awk '/:/{if($2==$3) print $5":"$3}'|sed 's/(//g'|sed 's/)//g'>ssf_all4_naivebayes_allALL_sparse
# cat ssf_all4_decisionStump_all_sparse.p|awk '/:/{if($2==$3) print $5":"$3}'|sed 's/(//g'|sed 's/)//g'>ssf_all4_decisionStump_allALL_sparse
##cat ssf_all4_decisionStump_allALL_sparse|wc -l #110253
##cat ssf_all4_naivebayes_allALL_sparse|wc -l #109920


cd $PBS_O_WORKDIR/model_new/70/Level0
#correctly classified
cat ssf_all4_SMO_train80_sparse.p|awk '/:/{if($2==$3) print $5":"$3}'|sed 's/(//g'|sed 's/)//g'>ssf_all4_SMO_train_sparse
cat ssf_all4_IBK_train80_sparse.p|awk '/:/{if($2==$3) print $5":"$3}'|sed 's/(//g'|sed 's/)//g'>ssf_all4_IBK_train_sparse
cat ssf_all4_randomforest_train80_sparse.p|awk '/:/{if($2==$3) print $5":"$3}'|sed 's/(//g'|sed 's/)//g'>ssf_all4_randomforest_train_sparse
paste ssf_all4_SMO_train_sparse ssf_all4_IBK_train_sparse ssf_all4_randomforest_train_sparse|tr '\t' '\n'|sort -n|uniq -c|awk -F" " '{if(($1=="2")||($1=="3")) print $2}'|awk -F":" '/E/{print $1}'|grep -v '^$'>ssf_all4_top3_train_atleast2
paste ssf_all4_SMO_train_sparse ssf_all4_IBK_train_sparse ssf_all4_randomforest_train_sparse|tr '\t' '\n'|sort -n|uniq -c|awk -F" " '{if(($1=="3")) print $2}'|awk -F":" '/E/{print $1}'|grep -v '^$'>ssf_all4_top3_train_exactly3

cat ssf_all4_SMO_test20_sparse.p|awk '/:/{if($2==$3) print $5":"$3}'|sed 's/(//g'|sed 's/)//g'>ssf_all4_SMO_test_sparse
cat ssf_all4_IBK_test20_sparse.p|awk '/:/{if($2==$3) print $5":"$3}'|sed 's/(//g'|sed 's/)//g'>ssf_all4_IBK_test_sparse
cat ssf_all4_randomforest_test20_sparse.p|awk '/:/{if($2==$3) print $5":"$3}'|sed 's/(//g'|sed 's/)//g'>ssf_all4_randomforest_test_sparse

paste ssf_all4_SMO_test_sparse ssf_all4_IBK_test_sparse ssf_all4_randomforest_test_sparse|tr '\t' '\n'|sort -n|uniq -c|awk -F" " '{if(($1=="2")||($1=="3")) print $2}'|awk -F":" '/E/{print $1}'|grep -v '^$'>ssf_all4_top3_test_atleast2
paste ssf_all4_SMO_test_sparse ssf_all4_IBK_test_sparse ssf_all4_randomforest_test_sparse|tr '\t' '\n'|sort -n|uniq -c|awk -F" " '{if(($1=="3")) print $2}'|awk -F":" '/E/{print $1}'|grep -v '^$'>ssf_all4_top3_test_exactly3

##For Enzymes only
# cd $PBS_O_WORKDIR/model_new/70/Level0
##correctly classified
# cat ssf_all4_SMO_train80_sparse.p|awk '/:/{if($2==$3&&$2=="2:E") print $5":"$3}'|sed 's/(//g'|sed 's/)//g'>ssf_all4_SMO_train80_sparse
# cat ssf_all4_IBK_train80_sparse.p|awk '/:/{if($2==$3&&$2=="2:E") print $5":"$3}'|sed 's/(//g'|sed 's/)//g'>ssf_all4_IBK_train80_sparse
# cat ssf_all4_randomforest_train80_sparse.p|awk '/:/{if($2==$3&&$2=="2:E") print $5":"$3}'|sed 's/(//g'|sed 's/)//g'>ssf_all4_randomforest_train80_sparse
# paste ssf_all4_SMO_train80_sparse ssf_all4_IBK_train80_sparse ssf_all4_randomforest_train80_sparse|tr '\t' '\n'|sort -n|uniq -c|awk -F" " '{if(($1=="2")||($1=="3")) print $2}'|awk -F":" '/E/{print $1}'|grep -v '^$'>ssf_all4_top3_train80_atleast2

# paste ssf_all4_SMO_train80_sparse ssf_all4_IBK_train80_sparse ssf_all4_randomforest_train80_sparse|tr '\t' '\n'|sort -n|uniq -c|awk -F" " '{if(($1=="3")) print $2}'|awk -F":" '/E/{print $1}'|grep -v '^$'>ssf_all4_top3_train80_exactly3
# cat ssf_all4_SMO_test20_sparse.p|awk '/:/{if($2==$3&&$2=="2:E") print $5":"$3}'|sed 's/(//g'|sed 's/)//g'>ssf_all4_SMO_test20_sparse
# cat ssf_all4_IBK_test20_sparse.p|awk '/:/{if($2==$3&&$2=="2:E") print $5":"$3}'|sed 's/(//g'|sed 's/)//g'>ssf_all4_IBK_test20_sparse
# cat ssf_all4_randomforest_test20_sparse.p|awk '/:/{if($2==$3&&$2=="2:E") print $5":"$3}'|sed 's/(//g'|sed 's/)//g'>ssf_all4_randomforest_test20_sparse

# paste ssf_all4_SMO_test20_sparse ssf_all4_IBK_test20_sparse ssf_all4_randomforest_test20_sparse|tr '\t' '\n'|sort -n|uniq -c|awk -F" " '{if(($1=="2")||($1=="3")) print $2}'|awk -F":" '/E/{print $1}'|grep -v '^$'>ssf_all4_top3_test20_atleast2
# paste ssf_all4_SMO_test20_sparse ssf_all4_IBK_test20_sparse ssf_all4_randomforest_test20_sparse|tr '\t' '\n'|sort -n|uniq -c|awk -F" " '{if(($1=="3")) print $2}'|awk -F":" '/E/{print $1}'|grep -v '^$'>ssf_all4_top3_test20_exactly3