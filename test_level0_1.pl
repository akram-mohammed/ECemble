#!/usr/bin/perl

# Written by Akram Mohammed

# PredictionsLevel0SMO

use strict;
use warnings;

my $k = qx(ls ../test|grep 'testseq.ssfpspfsingleID.'|awk -F'.' 'END {print substr(\$3,2,1)}');

for (my $i=0; $i<=$k; $i++){
	system("java weka.classifiers.functions.SMO -T ../test/testseq.ssfpspfall$i\_sparse.arff -l ../test/Level0/ssf_all4_SMO_train80_sparse.model -no-cv -p 1 -distribution >../test/Level0/ssf_all4_SMO_$i\_sparse.p &");
}
