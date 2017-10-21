#!/bin/sh
# Written by Akram Mohammed
cd ../test
#Map Test sequences to Pfam domains
for i in {1..10}; do 
../lib/hmmer/src/hmmscan --cut_ga --tblout proteome_testseq_$i.tblout -Z 13672 ../lib/PFAM/Pfam-A.hmm proteome_testseq_$i.fasta&
done