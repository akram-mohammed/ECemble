#!/usr/bin/perl

# Written by Akram Mohammed



my @array = ([1,1],[1,10],[1,13],[1,14],[1,17],[1,18],[1,2],[1,3],[1,4],[1,5],[1,6],[1,7],[1,8],[2,1],[2,3],[2,4],[2,6],[2,7],[2,8],[3,1],[3,2],[3,4],[3,5],[3,6],[4,1],[4,2],[4,3],[5,1],[5,3],[5,4],[6,3]);
for (my $x = 0; $x <= $#array; $x++) {
   for (my $y = 1; $y <= $#{$array[$x]}; $y++) {
		my $i=$array[$x][0];
		my $j=$array[$x][$y];
		#print $i,"\t",$j,"\n";
		#Remove MISCLASSIFIED instances and retrain at level 4 using TOP3: SVM,IBK,RandomForest
		#predicted as enzymes at level3
		system("cat ../test/Level3/UniGene_SSFPSPFENZ_L3_SMO_EC$i.$j\_sparse.p|awk '/:/{print \$5\":\"\$3}'|sed 's/(//g'|sed 's/)//g'>../test/Level3/UniGene_SSFPSPFENZ_L3_SMO_EC$i.$j\_sparse");
		system("cat ../test/Level3/UniGene_SSFPSPFENZ_L3_IBK_EC$i.$j\_sparse.p|awk '/:/{print \$5\":\"\$3}'|sed 's/(//g'|sed 's/)//g'>../test/Level3/UniGene_SSFPSPFENZ_L3_IBK_EC$i.$j\_sparse");
		system("cat ../test/Level3/UniGene_SSFPSPFENZ_L3_randomforest_EC$i.$j\_sparse.p|awk '/:/{print \$5\":\"\$3}'|sed 's/(//g'|sed 's/)//g'>../test/Level3/UniGene_SSFPSPFENZ_L3_randomforest_EC$i.$j\_sparse");
		# correctly predicted by atleast 2 methods
		system("paste ../test/Level3/UniGene_SSFPSPFENZ_L3_SMO_EC$i.$j\_sparse ../test/Level3/UniGene_SSFPSPFENZ_L3_IBK_EC$i.$j\_sparse ../test/Level3/UniGene_SSFPSPFENZ_L3_randomforest_EC$i.$j\_sparse|awk -F\"\t\" '{if((\$1==\$2)||(\$2==\$3)||(\$1==\$3)) print \$0}'|tr '\t' '\n'|sort -n|uniq -c|awk -F\" \" '{if((\$1=='2')||(\$1=='3')) print \$2}'>../test/Level3/UniGene_SSFPSPFENZ_L3_all_EC$i.$j\_sparse_atleast2");
		system("cat ../test/Level3/UniGene_SSFPSPFENZ_L3_all_EC$i.$j\_sparse_atleast2>>../test/Level3/UniGene_SSFPSPFENZ_L3_all_EC_sparse_atleast2");
		}
	}
