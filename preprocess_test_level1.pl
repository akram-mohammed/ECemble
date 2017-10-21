#!/usr/bin/perl

# Written by Akram Mohammed

# Map&RemoveLevel1

use strict;
use warnings;

my $k = qx(ls ../test|grep 'testseq.ssfpspfsingleID.'|awk -F'.' 'END {print substr(\$3,2,1)}');

for (my $i=0; $i<=$k; $i++){
	# split the .arff file into header and instance files to remove the misclassified instances
	system("grep -v '^\@' ../test/testseq.ssfpspfenz$i\_$i.arff>../test/testseq.ssfpspfenzI_$i.arff");
	# Map and remove misclassified instances: map correctly predicted instances to source arff file for level 1 predictions
	system("awk -F\" \" 'FILENAME==\"../test/testseq.ssfpspfenzI_'$i'.arff\"{a[\$1]=\$0} FILENAME==\"../test/Level0/ssf_all4_top3_copy_sparse_atleast2\"{if(a[\$1]){print a[\$1]}}' ../test/testseq.ssfpspfenzI_$i.arff ../test/Level0/ssf_all4_top3_copy_sparse_atleast2>../test/testseq.ssfpspfenzII_$i.arff");
	system("cat ../test/testseq.ssfpspfenzH.arff ../test/testseq.ssfpspfenzII_$i.arff>../test/testseq.ssfpspfenzIII_$i.arff");
}