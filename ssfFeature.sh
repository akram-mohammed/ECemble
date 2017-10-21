#!/bin/sh

# Written by Akram Mohammed

# Map Test sequences to superfamily domains

cd ../test

max=10
for i in `seq 1 $max`
do
nohup perl ../lib/SUPERFAMILY/superfamily.pl proteometestseq$i.fa &
done