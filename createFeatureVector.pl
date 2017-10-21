#!/usr/bin/perl

# Written by Akram Mohammed

# Create Feature Vector

use strict;
use warnings;

my $k = qx(ls ../test|grep 'testseq.ssfpspfsingleID.'|awk -F'.' 'END {print substr(\$3,2,1)}');

for (my $i=0; $i<=$k; $i++){
system("awk -f weka_format_dense0.awk ../bin/ssf_ps_pfam_all_list ../test/testseq.ssfpspfsingleID.0$i*>>../test/testseq.ssfpspfall$i.arff&");
system("awk -f weka_format_dense1.awk ../bin/ssf_ps_pfam_enz_list ../test/testseq.ssfpspfsingleID.0$i*>>../test/testseq.ssfpspfenz$i.arff&");
}
