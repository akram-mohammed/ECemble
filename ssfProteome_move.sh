#!/bin/sh
# Written by Akram Mohammed

#testDir = "/usr/local/apache2/htdocs/genome/ECemble/ECemble_Package/test"
#cd /usr/local/apache2/htdocs/genome/ECemble/ECemble_Package/test

cd /usr/local/apache2/htdocs/genome/ECemble/temp/

for ((i=1; i<=10; i++))
do
cp ip_seq.*_$i.fasta ip_seq.1410168298_7proteometestseqAKRAM$i.fa
done

#::SSF mapping:: (#output results files stored in scratch directory)
mkdir scratch