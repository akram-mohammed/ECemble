#!/usr/bin/perl

# Written by Akram Mohammed

use strict;
use warnings;

my $k = qx(ls ../test|grep 'testseq.ssfpspfsingleID.'|awk -F'.' 'END {print substr(\$3,2,1)}');

for (my $i=0; $i<=$k; $i++){
	# split the .arff file into header and instance files to remove the misclassified instances
	system("grep -v '^\@' ../test/testseq.ssfpspfenz$i\_$i.arff|grep -v '^\$'>>../test/Level2/testseq.ssfpspfenzI_L2.arff");
}