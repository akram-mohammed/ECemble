#!/usr/bin/perl
use strict;
use warnings;

# Written by Akram Mohammed

my $k = qx(ls ../test|grep 'testseq.ssfpspfsingleID.'|awk -F'.' 'END {print substr(\$3,2,1)}');

system("grep -v '^\@' ../test/testseq.ssfpspfall0.arff|awk -F\",\" '{\$1=(\$1); print \$0}'> ../test/testseq.ssfpspfallI_0.arff");
system("grep -v '^\@' ../test/testseq.ssfpspfall1.arff|awk -F\",\" '{\$1=(\$1+100); print \$0}'> ../test/testseq.ssfpspfallI_1.arff");
system("grep -v '^\@' ../test/testseq.ssfpspfall2.arff|awk -F\",\" '{\$1=(\$1+200); print \$0}'> ../test/testseq.ssfpspfallI_2.arff");
system("grep -v '^\@' ../test/testseq.ssfpspfall3.arff|awk -F\",\" '{\$1=(\$1+300); print \$0}'> ../test/testseq.ssfpspfallI_3.arff");
system("grep -v '^\@' ../test/testseq.ssfpspfall4.arff|awk -F\",\" '{\$1=(\$1+400); print \$0}'> ../test/testseq.ssfpspfallI_4.arff");

for (my $i=0; $i<=$k; $i++){
system("cat ../test/Level0/ssf_ps_pfam_all1.arff ../test/testseq.ssfpspfallI_$i.arff>../test/testseq.ssfpspfall$i\_$i.arff&");
}

system("grep -v '^\@' ../test/testseq.ssfpspfenz0.arff|awk -F\",\" '{\$1=(\$1); print \$0}'> ../test/testseq.ssfpspfenzI_0.arff");
system("grep -v '^\@' ../test/testseq.ssfpspfenz1.arff|awk -F\",\" '{\$1=(\$1+100); print \$0}'> ../test/testseq.ssfpspfenzI_1.arff");
system("grep -v '^\@' ../test/testseq.ssfpspfenz2.arff|awk -F\",\" '{\$1=(\$1+200); print \$0}'> ../test/testseq.ssfpspfenzI_2.arff");
system("grep -v '^\@' ../test/testseq.ssfpspfenz3.arff|awk -F\",\" '{\$1=(\$1+300); print \$0}'> ../test/testseq.ssfpspfenzI_3.arff");
system("grep -v '^\@' ../test/testseq.ssfpspfenz4.arff|awk -F\",\" '{\$1=(\$1+400); print \$0}'> ../test/testseq.ssfpspfenzI_4.arff");

for (my $i=0; $i<=$k; $i++){
system("cat ../test/Level1/ssf_ps_pfam_enz1.arff ../test/testseq.ssfpspfenzI_$i.arff>../test/testseq.ssfpspfenz$i\_$i.arff&");
}
