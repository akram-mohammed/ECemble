#!/usr/bin/perl

# Written by Akram Mohammed

# SparseOriginalL1

use strict;
use warnings;

my $k = qx(ls ../test|grep 'testseq.ssfpspfsingleID.'|awk -F'.' 'END {print substr(\$3,2,1)}');

for (my $i=0; $i<=$k; $i++){
	system("java -Xmx5g weka.filters.unsupervised.instance.NonSparseToSparse -i ../test/testseq.ssfpspfenzIII_$i.arff -o ../test/testseq.ssfpspfenz$i\_sparse.arff&");
}
