#!/usr/bin/perl
my @array = ([1,1],[1,10],[1,11],[1,12],[1,13],[1,14],[1,15],[1,16],[1,17],[1,18],[1,2],[1,21],[1,3],[1,4],[1,5],[1,6],[1,7],[1,8],[1,9],[1,97],[2,1],[2,2],[2,3],[2,4],[2,5],[2,6],[2,7],[2,8],[2,9],[3,1],[3,2],[3,3],[3,4],[3,5],[3,6],[3,7],[4,1],[4,2],[4,3],[4,4],[4,6],[4,99],[5,1],[5,2],[5,3],[5,4],[5,5],[5,99],[6,1],[6,2],[6,3],[6,4],[6,5],[6,6]);
# my @array = ([1,1],[1,10],[1,13],[1,14],[1,17],[1,18],[1,2],[1,3],[1,4],[1,5],[1,6],[1,7],[1,8],[2,1],[2,3],[2,4],[2,6],[2,7],[2,8],[3,1],[3,2],[3,4],[3,5],[3,6],[4,1],[4,2],[4,3],[5,1],[5,3],[5,4],[6,3]);
# my @array = ([1,1],[1,13],[1,14],[1,17],[1,18],[1,2],[1,3],[1,4],[1,5],[1,6],[1,7],[1,8],[2,1],[2,3],[2,4],[2,6],[2,7],[2,8],[3,1],[3,2],[3,4],[3,5],[3,6],[4,1],[4,2],[4,3],[5,1],[5,3],[5,4],[6,3]);
# my @array = ([1,1],[1,13],[1,14],[1,17],[1,2],[1,3],[1,4],[1,5],[1,6],[1,8],[2,1],[2,3],[2,4],[2,6],[2,7],[2,8],[3,1],[3,2],[3,4],[3,5],[3,6],[4,1],[4,2],[4,3],[5,1],[5,3],[5,4],[6,3]);
# my @array = ([1,1],[1,14],[1,17],[1,2],[1,3],[1,4],[1,5],[1,6],[2,1],[2,3],[2,4],[2,6],[2,7],[2,8],[3,1],[3,2],[3,4],[3,5],[3,6],[4,1],[4,2],[5,1],[5,3],[5,4],[6,3]);
for (my $x = 0; $x <= $#array; $x++) {
   for (my $y = 1; $y <= $#{$array[$x]}; $y++) {
		my $i=$array[$x][0];
		my $j=$array[$x][$y];
		system("java -Xmx50g weka.classifiers.meta.FilteredClassifier -F \"weka.filters.unsupervised.attribute.Remove -R first\" -W weka.classifiers.lazy.IBk -t SSFPSPFENZ_L3_EC$i.$j\_sparse_train80.arff -no-cv -o -i -d SSFPSPFENZ_L3_IBK_EC$i.$j\_sparse_train80.model>SSFPSPFENZ_L3_IBK_EC$i.$j\_sparse_train80.result");
		system("java -Xmx50g weka.classifiers.lazy.IBk -T SSFPSPFENZ_L3_EC$i.$j\_sparse_test20.arff -l SSFPSPFENZ_L3_IBK_EC$i.$j\_sparse_train80.model -no-cv -o -i >SSFPSPFENZ_L3_IBK_EC$i.$j\_sparse_test20.result");
		system("java -Xmx50g weka.classifiers.lazy.IBk -T SSFPSPFENZ_L3_EC$i.$j\_sparse_train80.arff -l SSFPSPFENZ_L3_IBK_EC$i.$j\_sparse_train80.model -no-cv -p 1 -distribution >SSFPSPFENZ_L3_IBK_EC$i.$j\_sparse_train80.p");
		system("java -Xmx50g weka.classifiers.lazy.IBk -T SSFPSPFENZ_L3_EC$i.$j\_sparse_test20.arff -l SSFPSPFENZ_L3_IBK_EC$i.$j\_sparse_train80.model -no-cv -p 1 -distribution >SSFPSPFENZ_L3_IBK_EC$i.$j\_sparse_test20.p");
	}
}