#!/usr/bin/perl

# Written by Akram Mohammed

# PredictionsLevel0RandomForest

use strict;
use warnings;

my $k = qx(ls ../test|grep 'testseq.ssfpspfsingleID.'|awk -F'.' 'END {print substr(\$3,2,1)}');

for (my $i=0; $i<=$k; $i++){
	system("java -Xss5g weka.classifiers.trees.RandomForest -T ../test/testseq.ssfpspfall$i\_sparse.arff -l ../test/Level0/ssf_all4_randomforest_train80_sparse.model -no-cv -p 1 -distribution >../test/Level0/ssf_all4_randomforest_$i\_sparse.p &");
}

