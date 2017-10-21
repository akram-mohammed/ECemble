#!/usr/bin/perl

# Written by Akram Mohammed

my @array = ([1,1],[1,10],[1,13],[1,14],[1,17],[1,18],[1,2],[1,3],[1,4],[1,5],[1,6],[1,7],[1,8],[2,1],[2,3],[2,4],[2,6],[2,7],[2,8],[3,1],[3,2],[3,4],[3,5],[3,6],[4,1],[4,2],[4,3],[5,1],[5,3],[5,4],[6,3]);
for (my $x = 0; $x <= $#array; $x++) {
   for (my $y = 1; $y <= $#{$array[$x]}; $y++) {
		my $i=$array[$x][0];
		my $j=$array[$x][$y];
system("cat ../test/Level2/UniGene_SSFPSPFENZ_L2_all_EC$i\_sparse_atleast2|awk -F':' '{if((substr(\$3,3,1)==$i)&&(substr(\$3,5)==$j)) print \$1}'>../test/Level3/UniGene_SSFPSPFENZ_L3_all_EC$i.$j\_sparse_atleast2");		
# Map and remove misclassified ones: map correctly predicted ones to source arff file for level 3 predictions
system("awk -F\" \" 'FILENAME==\"../test/Level2/testseq.ssfpspfenz_L2_EC$i.arff\"{a[\$1]=\$0} FILENAME==\"../test/Level3/UniGene_SSFPSPFENZ_L3_all_EC$i.$j\_sparse_atleast2\"{if(a[\$1]){print a[\$1]}}' ../test/Level2/testseq.ssfpspfenz_L2_EC$i.arff ../test/Level3/UniGene_SSFPSPFENZ_L3_all_EC$i.$j\_sparse_atleast2> ../test/Level3/UniGene_SSFPSPFENZI_L3_EC$i.$j.arff");	
system("cp ../test/Level3/SSFPSPFENZHH_L3_EC$i.$j.arff ../test/Level3/UniGene_SSFPSPFENZH_L3_EC$i.$j.arff");
system("cat ../test/Level3/UniGene_SSFPSPFENZH_L3_EC$i.$j.arff ../test/Level3/UniGene_SSFPSPFENZI_L3_EC$i.$j.arff>../test/Level3/UniGene_SSFPSPFENZ_L3_EC$i.$j.arff");
# SPARSE FORMAT:
system("java weka.filters.unsupervised.instance.NonSparseToSparse -i ../test/Level3/UniGene_SSFPSPFENZ_L3_EC$i.$j.arff -o ../test/Level3/UniGene_SSFPSPFENZ_L3_EC$i.$j\_sparse.arff");
}}