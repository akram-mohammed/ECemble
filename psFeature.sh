#!/bin/sh
# Written by Akram Mohammed
cd ../test
#Map Test sequences to prosite domains
for i in {1..10}; do
perl ../lib/ps_scan/ps_scan.pl -d ../lib/PROSITE/Prosite -r proteome_testseq_$i.fasta>proteome_testseq_$i.ps&
done