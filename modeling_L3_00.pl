#!/usr/bin/perl
my @array = ([1,1],[1,10],[1,11],[1,12],[1,13],[1,14],[1,15],[1,16],[1,17],[1,18],[1,2],[1,20],[1,21],[1,3],[1,4],[1,5],[1,6],[1,7],[1,8],[1,9],[1,97],[2,1],[2,2],[2,3],[2,4],[2,5],[2,6],[2,7],[2,8],[2,9],[3,1],[3,10],[3,11],[3,2],[3,3],[3,4],[3,5],[3,6],[3,7],[3,8],[4,1],[4,2],[4,3],[4,4],[4,5],[4,6],[4,99],[5,1],[5,2],[5,3],[5,4],[5,5],[5,99],[6,1],[6,2],[6,3],[6,4],[6,5],[6,6]);
# my @array = ([1,1],[1,10],[1,13],[1,14],[1,17],[1,18],[1,2],[1,3],[1,4],[1,5],[1,6],[1,7],[1,8],[2,1],[2,3],[2,4],[2,6],[2,7],[2,8],[3,1],[3,2],[3,4],[3,5],[3,6],[4,1],[4,2],[4,3],[5,1],[5,3],[5,4],[6,3]);
# my @array = ([1,1],[1,13],[1,14],[1,17],[1,18],[1,2],[1,3],[1,4],[1,5],[1,6],[1,7],[1,8],[2,1],[2,3],[2,4],[2,6],[2,7],[2,8],[3,1],[3,2],[3,4],[3,5],[3,6],[4,1],[4,2],[4,3],[5,1],[5,3],[5,4],[6,3]);
# my @array = ([1,1],[1,13],[1,14],[1,17],[1,2],[1,3],[1,4],[1,5],[1,6],[1,8],[2,1],[2,3],[2,4],[2,6],[2,7],[2,8],[3,1],[3,2],[3,4],[3,5],[3,6],[4,1],[4,2],[4,3],[5,1],[5,3],[5,4],[6,3]);
# my @array = ([1,1],[1,14],[1,17],[1,2],[1,3],[1,4],[1,5],[1,6],[2,1],[2,3],[2,4],[2,6],[2,7],[2,8],[3,1],[3,2],[3,4],[3,5],[3,6],[4,1],[4,2],[5,1],[5,3],[5,4],[6,3]);
for (my $x = 0; $x <= $#array; $x++) {
   for (my $y = 1; $y <= $#{$array[$x]}; $y++) {
		my $i=$array[$x][0];
		my $j=$array[$x][$y];
		system("awk -F\" \" 'FILENAME==\"SSFPSPFENZ_L3_EC$i.$j\_label\"{a[\$2]=\$0} FILENAME==\"SSFPSPFENZH_L3_EC$i.$j.arff\"{if(a[\$2]){print a[\$2]} else {print \$0}}' SSFPSPFENZ_L3_EC$i.$j\_label SSFPSPFENZH_L3_EC$i.$j.arff> SSFPSPFENZHH_L3_EC$i.$j.arff");
		system("cat SSFPSPFENZHH_L3_EC$i.$j.arff SSFPSPFENZI_L3_EC$i.$j.arff>SSFPSPFENZ_L3_EC$i.$j.arff");
		system("java -Xmx50g weka.filters.unsupervised.instance.NonSparseToSparse -i SSFPSPFENZ_L3_EC$i.$j.arff -o SSFPSPFENZ_L3_EC$i.$j\_sparse.arff");
		system("java -Xmx50g weka.filters.supervised.instance.StratifiedRemoveFolds -i SSFPSPFENZ_L3_EC$i.$j\_sparse.arff -o SSFPSPFENZ_L3_EC$i.$j\_sparse_train80.arff -c last -S 5 -N 5 -V");
		system("java -Xmx50g weka.filters.supervised.instance.StratifiedRemoveFolds -i SSFPSPFENZ_L3_EC$i.$j\_sparse.arff -o SSFPSPFENZ_L3_EC$i.$j\_sparse_test20.arff -c last -S 5 -N 5");
		system("rm SSFPSPFENZI_L3_EC$i.$j.arff SSFPSPFENZH_L3_EC$i.$j.arff SSFPSPFENZ_L3_EC$i.$j\_label SSFPSPFENZHH_L3_EC$i.$j.arff SSFPSPFENZ_L3_EC$i.$j\_sparse.arff");
}}