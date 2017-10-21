#!/usr/bin/perl

# Written by Akram Mohammed

# SparseOriginalL0

use strict;
use warnings;

my $k = qx(ls ../test|grep 'testseq.ssfpspfsingleID.'|awk -F'.' 'END {print substr(\$3,2,1)}');

for (my $i=0; $i<=$k; $i++){
	system("java -Xmx5g weka.filters.unsupervised.instance.NonSparseToSparse -i ../test/testseq.ssfpspfall$i\_$i.arff -o ../test/testseq.ssfpspfall$i\_sparse.arff&");
}


