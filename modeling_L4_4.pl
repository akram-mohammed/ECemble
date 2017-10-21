#!/usr/bin/perl
my @array = ([1,10,2],[1,10,3],[1,10,99],[1,1,1],[1,11,1],[1,11,2],[1,1,2],[1,12,1],[1,12,2],[1,12,98],[1,12,99],[1,1,3],[1,13,11],[1,13,12],[1,13,99],[1,14,11],[1,14,12],[1,14,13],[1,14,14],[1,14,15],[1,14,16],[1,14,17],[1,14,18],[1,14,19],[1,14,20],[1,14,99],[1,1,5],[1,15,1],[1,16,1],[1,16,3],[1,17,1],[1,17,3],[1,17,4],[1,17,7],[1,17,99],[1,18,1],[1,18,6],[1,1,98],[1,1,99],[1,2,1],[1,21,3],[1,21,4],[1,2,3],[1,2,4],[1,2,5],[1,2,7],[1,2,99],[1,3,1],[1,3,2],[1,3,3],[1,3,5],[1,3,7],[1,3,99],[1,4,1],[1,4,3],[1,4,4],[1,4,7],[1,4,99],[1,5,1],[1,5,3],[1,5,5],[1,5,8],[1,5,99],[1,6,1],[1,6,2],[1,6,3],[1,6,5],[1,6,99],[1,7,1],[1,7,2],[1,7,3],[1,7,99],[1,8,1],[1,8,3],[1,8,4],[1,8,7],[1,8,98],[1,8,99],[1,9,3],[1,97,1],[2,1,1],[2,1,2],[2,1,3],[2,2,1],[2,3,1],[2,3,2],[2,3,3],[2,4,1],[2,4,2],[2,4,99],[2,5,1],[2,6,1],[2,6,99],[2,7,1],[2,7,10],[2,7,11],[2,7,12],[2,7,13],[2,7,2],[2,7,3],[2,7,4],[2,7,6],[2,7,7],[2,7,8],[2,7,9],[2,8,1],[2,8,2],[2,8,3],[2,8,4],[2,9,1],[3,1,1],[3,1,11],[3,1,13],[3,1,2],[3,1,21],[3,1,22],[3,1,26],[3,1,27],[3,1,3],[3,1,30],[3,1,31],[3,1,4],[3,1,5],[3,1,6],[3,1,7],[3,1,8],[3,2,1],[3,2,2],[3,3,1],[3,3,2],[3,4,11],[3,4,13],[3,4,14],[3,4,15],[3,4,16],[3,4,17],[3,4,18],[3,4,19],[3,4,21],[3,4,22],[3,4,23],[3,4,24],[3,4,25],[3,5,1],[3,5,2],[3,5,3],[3,5,4],[3,5,5],[3,5,99],[3,6,1],[3,6,3],[3,6,4],[3,6,5],[3,7,1],[4,1,1],[4,1,2],[4,1,3],[4,1,99],[4,2,1],[4,2,2],[4,2,3],[4,2,99],[4,3,1],[4,3,2],[4,3,3],[4,4,1],[4,6,1],[4,99,1],[5,1,1],[5,1,2],[5,1,3],[5,1,99],[5,2,1],[5,3,1],[5,3,2],[5,3,3],[5,3,4],[5,3,99],[5,4,1],[5,4,2],[5,4,3],[5,4,4],[5,4,99],[5,5,1],[5,99,1],[6,1,1],[6,2,1],[6,3,1],[6,3,2],[6,3,3],[6,3,4],[6,3,5],[6,4,1],[6,5,1],[6,6,1]);
# my @array = ([1,1,1],[1,13,11],[1,14,11],[1,17,1],[1,2,1],[1,2,4],[1,3,1],[1,4,3],[1,5,1],[1,6,99],[1,7,1],[1,8,1],[1,8,4],[2,1,1],[2,1,2],[2,1,3],[2,3,1],[2,3,2],[2,3,3],[2,4,1],[2,4,2],[2,6,1],[2,7,1],[2,7,10],[2,7,11],[2,7,2],[2,7,4],[2,7,7],[2,7,8],[2,8,1],[3,1,1],[3,1,11],[3,1,2],[3,1,21],[3,1,26],[3,1,3],[3,1,4],[3,2,1],[3,2,2],[3,4,11],[3,4,19],[3,4,21],[3,4,22],[3,4,23],[3,4,24],[3,4,25],[3,5,1],[3,5,2],[3,5,3],[3,5,4],[3,6,1],[3,6,3],[3,6,4],[4,1,1],[4,1,2],[4,1,3],[4,2,1],[4,2,3],[4,3,1],[4,3,2],[5,1,1],[5,1,3],[5,3,1],[5,3,3],[5,4,2],[5,4,99],[6,3,1],[6,3,2],[6,3,3],[6,3,4],[6,3,5]);
# my @array = ([1,1,1],[1,13,11],[1,2,1],[1,3,1],[1,4,3],[1,5,1],[1,6,99],[1,8,1],[2,1,1],[2,1,2],[2,3,1],[2,3,2],[2,4,1],[2,4,2],[2,6,1],[2,7,1],[2,7,10],[2,7,11],[2,7,2],[2,7,4],[2,7,7],[2,7,8],[2,8,1],[3,1,1],[3,1,11],[3,1,2],[3,1,21],[3,1,26],[3,1,3],[3,1,4],[3,2,1],[3,4,11],[3,4,19],[3,4,21],[3,4,22],[3,4,23],[3,4,24],[3,4,25],[3,5,1],[3,5,2],[3,5,3],[3,5,4],[3,6,1],[3,6,3],[3,6,4],[4,1,1],[4,1,2],[4,1,3],[4,2,1],[4,2,3],[5,1,1],[5,3,1],[5,4,2],[5,4,99],[6,3,2],[6,3,3],[6,3,4],[6,3,5]);
# my @array = ([1,1,1],[1,2,1],[1,3,1],[1,6,5],[1,6,99],[2,1,1],[2,3,1],[2,4,1],[2,4,2],[2,6,1],[2,7,1],[2,7,10],[2,7,11],[2,7,2],[2,7,4],[2,7,7],[2,7,8],[3,1,1],[3,1,2],[3,1,21],[3,1,26],[3,1,3],[3,1,4],[3,2,1],[3,4,19],[3,4,21],[3,4,23],[3,4,24],[3,5,1],[3,5,4],[3,6,1],[3,6,3],[3,6,4],[4,1,1],[4,1,2],[4,1,3],[4,2,1],[4,2,3],[5,1,1],[5,3,1],[5,4,99],[6,3,2]);
for (my $x = 0; $x <= $#array; $x++) {
	my $i=$array[$x][0];
	my $j=$array[$x][1];
	my $k=$array[$x][2];
		system("java -Xmx50g weka.classifiers.meta.FilteredClassifier -F \"weka.filters.unsupervised.attribute.Remove -R first\" -W weka.classifiers.trees.DecisionStump -t SSFPSPFENZ_L4_EC$i.$j.$k\_sparse_train80.arff -no-cv -o -i -d SSFPSPFENZ_L4_decisionStump_EC$i.$j.$k\_sparse_train80.model>SSFPSPFENZ_L4_decisionStump_EC$i.$j.$k\_sparse_train80.result");
		system("java -Xmx50g weka.classifiers.trees.DecisionStump -T SSFPSPFENZ_L4_EC$i.$j.$k\_sparse_test20.arff -l SSFPSPFENZ_L4_decisionStump_EC$i.$j.$k\_sparse_train80.model -no-cv -o -i >SSFPSPFENZ_L4_decisionStump_EC$i.$j.$k\_sparse_test20.result");
		system("java -Xmx50g weka.classifiers.trees.DecisionStump -T SSFPSPFENZ_L4_EC$i.$j.$k\_sparse_train80.arff -l SSFPSPFENZ_L4_decisionStump_EC$i.$j.$k\_sparse_train80.model -no-cv -p 1 -distribution >SSFPSPFENZ_L4_decisionStump_EC$i.$j.$k\_sparse_train80.p");
		system("java -Xmx50g weka.classifiers.trees.DecisionStump -T SSFPSPFENZ_L4_EC$i.$j.$k\_sparse_test20.arff -l SSFPSPFENZ_L4_decisionStump_EC$i.$j.$k\_sparse_train80.model -no-cv -p 1 -distribution >SSFPSPFENZ_L4_decisionStump_EC$i.$j.$k\_sparse_test20.p");
}