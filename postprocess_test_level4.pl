#!/usr/bin/perl 

# Written by Akram Mohammed



my @array = ([1,1,1],[1,13,11],[1,14,11],[1,14,13],[1,1,5],[1,17,1],[1,17,4],[1,18,1],[1,2,1],[1,3,1],[1,3,5],[1,4,1],[1,4,3],[1,5,1],[1,6,5],[1,6,99],[1,7,1],[1,8,1],[1,8,4],[2,1,1],[2,1,2],[2,1,3],[2,3,1],[2,3,2],[2,3,3],[2,4,1],[2,4,2],[2,6,1],[2,7,1],[2,7,10],[2,7,11],[2,7,2],[2,7,4],[2,7,6],[2,7,7],[2,7,8],[2,8,1],[3,1,1],[3,1,11],[3,1,2],[3,1,21],[3,1,26],[3,1,27],[3,1,3],[3,1,4],[3,2,1],[3,2,2],[3,4,11],[3,4,19],[3,4,21],[3,4,22],[3,4,23],[3,4,24],[3,4,25],[3,5,1],[3,5,2],[3,5,3],[3,5,4],[3,6,1],[3,6,3],[3,6,4],[4,1,1],[4,1,2],[4,1,3],[4,1,99],[4,2,1],[4,2,2],[4,2,3],[4,2,99],[4,3,1],[4,3,2],[5,1,1],[5,1,3],[5,3,1],[5,3,3],[5,4,2],[5,4,99],[6,3,1],[6,3,2],[6,3,3],[6,3,4],[6,3,5]); 
for (my $x = 0; $x <= $#array; $x++) { 
my $i=$array[$x][0]; 
my $j=$array[$x][1]; 
my $k=$array[$x][2]; 
# Remove MISCLASSIFIED instances and retrain at level 4 using TOP3: SVM,IBK,RandomForest 
# predicted as enzymes at level4 
system("cat ../test/Level4/UniGene_SSFPSPFENZ_L4_SMO_EC$i.$j.$k\_sparse.p|awk '/:/{print \$5\":\"\$3}'|sed 's/(//g'|sed 's/)//g'>../test/Level4/UniGene_SSFPSPFENZ_L4_SMO_EC$i.$j.$k\_sparse"); 
system("cat ../test/Level4/UniGene_SSFPSPFENZ_L4_IBK_EC$i.$j.$k\_sparse.p|awk '/:/{print \$5\":\"\$3}'|sed 's/(//g'|sed 's/)//g'>../test/Level4/UniGene_SSFPSPFENZ_L4_IBK_EC$i.$j.$k\_sparse"); 
system("cat ../test/Level4/UniGene_SSFPSPFENZ_L4_randomforest_EC$i.$j.$k\_sparse.p|awk '/:/{print \$5\":\"\$3}'|sed 's/(//g'|sed 's/)//g'>../test/Level4/UniGene_SSFPSPFENZ_L4_randomforest_EC$i.$j.$k\_sparse"); 
# correctly predicted by atleast 2 methods 
}
my @array = ([1,1,1],[1,13,11],[1,14,11],[1,14,13],[1,1,5],[1,17,1],[1,17,4],[1,18,1],[1,2,1],[1,3,1],[1,3,5],[1,4,1],[1,4,3],[1,5,1],[1,6,5],[1,6,99],[1,7,1],[1,8,1],[1,8,4],[2,1,1],[2,1,2],[2,1,3],[2,3,1],[2,3,2],[2,3,3],[2,4,1],[2,4,2],[2,6,1],[2,7,1],[2,7,10],[2,7,11],[2,7,2],[2,7,4],[2,7,6],[2,7,7],[2,7,8],[2,8,1],[3,1,1],[3,1,11],[3,1,2],[3,1,21],[3,1,26],[3,1,27],[3,1,3],[3,1,4],[3,2,1],[3,2,2],[3,4,11],[3,4,19],[3,4,21],[3,4,22],[3,4,23],[3,4,24],[3,4,25],[3,5,1],[3,5,2],[3,5,3],[3,5,4],[3,6,1],[3,6,3],[3,6,4],[4,1,1],[4,1,2],[4,1,3],[4,1,99],[4,2,1],[4,2,2],[4,2,3],[4,2,99],[4,3,1],[4,3,2],[5,1,1],[5,1,3],[5,3,1],[5,3,3],[5,4,2],[5,4,99],[6,3,1],[6,3,2],[6,3,3],[6,3,4],[6,3,5]);
for (my $x = 0; $x <= $#array; $x++){
my $i=$array[$x][0]; 
my $j=$array[$x][1]; 
my $k=$array[$x][2];
system("paste ../test/Level4/UniGene_SSFPSPFENZ_L4_SMO_EC$i.$j.$k\_sparse ../test/Level4/UniGene_SSFPSPFENZ_L4_IBK_EC$i.$j.$k\_sparse ../test/Level4/UniGene_SSFPSPFENZ_L4_randomforest_EC$i.$j.$k\_sparse|awk -F\"\t\" '{if((\$1==\$2)||(\$2==\$3)||(\$1==\$3)) print \$0}'|tr '\t' '\n'|sort -n|uniq -c|awk -F\" \" '{if((\$1=='2')||(\$1=='3')) print \$2}'>../test/Level4/UniGene_SSFPSPFENZ_L4_all_EC$i.$j.$k\_sparse_atleast2");
system("cat ../test/Level4/UniGene_SSFPSPFENZ_L4_all_EC$i.$j.$k\_sparse_atleast2>>../test/Level4/UniGene_SSFPSPFENZ_L4_all_EC_sparse_atleast2");
}
system("cat ../test/Level4/UniGene_SSFPSPFENZ_L4_all_EC_sparse_atleast2|awk -F\":\" '{print \$1 \"\t\" \$3}'>../test/Level4/UniGene_SSFPSPFENZ_L4_ALL_EC_sparse_atleast2_col1and3");