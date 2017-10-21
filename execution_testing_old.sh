#!/bin/sh
# Data collection and feature collection and sequence to multiple feature mapping

# Sequence to feature mapping
# qsub enzymeSplitProteome.sh #Activate it only if you are dealing with 10 proteomes
# In bin directory; split into 10 pieces;

#Store fasta file in $ECemble/test directory

#Execute all scripts from $ECemble/bin directory
#Rename fasta file
perl renameFile.pl <inputfile>

perl splitFasta.pl -verbose -i ../test/proteome_testseq -n 10

#move the input files to new location for SSF processing (.fasta to .fa)
sh ssfProteome_move.sh

#::PFAM mapping::
sh pfamFeature.sh
#::PROSITE mapping::
sh psFeature.sh
#::SSF mapping:: (#output results files stored in scratch directory)
sh ssfFeature.sh

#Integrate features from all the databases
sh pfam_ps_ssfFeature.sh

#split lines from proteome_testseq_ssfpspfsingleID
perl splitFile.pl

sh submit_move.sh
#--------------------------------------------------------------------------------------------------------------------------------------
::LEVEL0::
sh createFeatureVector.sh
sh Add_ID.sh
sh create_sparse_L0.sh
#Probabilities:
#Test
sh test_level0_1.sh
sh test_level0_2.sh
sh test_level0_3.sh
#predicted as enzymes
#correctly predicted by atleast 2 methods
sh postprocess_test_level0.sh
#--------------------------------------------------------------------------------------------------------------------------------------
##::LEVEL1::
sh preprocess_test_level1.sh
sh create_sparse_L1.sh
#Probabilities:
#Test
sh test_level1_1.sh
sh test_level2_2.sh
sh test_level3_3.sh

#predicted as enzymes; correctly predicted by atleast 2 methods
sh postprocess_test_level1.sh
#--------------------------------------------------------------------------------------------------------------------------------------
##::LEVEL2::
#remove incorrectly classified from .arff files and sparse steps
sh preprocess_test_level2.sh
#Probabilities:
sh test_level2_1.sh
sh test_level2_2.sh
sh test_level2_3.sh

#predicted as enzymes; correctly predicted by atleast 2 methods
sh postprocess_test_level2.sh
#--------------------------------------------------------------------------------------------------------------------------------------
##::LEVEL3::
#remove incorrectly classified from .arff files and sparse steps
sh preprocess_test_level3.sh
#Probabilities:
sh test_level3_1.sh

#predicted as enzymes; correctly predicted by atleast 2 methods
sh postprocess_test_level3.sh
#--------------------------------------------------------------------------------------------------------------------------------------
##::LEVEL4::
#remove incorrectly classified from .arff files and sparse steps
sh preprocess_test_level4.sh
#Probabilities:
sh test_level4_1.sh
#predicted as enzymes; correctly predicted by atleast 2 methods
sh postprocess_test_level4.sh


#script to create a timestamp directory inside test directory and accordingly change the config file (path of timestamp directory)
sh timeStamp_splitFasta.sh

#Changed paths in Superfamily scripts in lib

		system("jobs -l | awk '{print $2}'");
		system("wait ${!}");


5/1/2013
# This script for data collection and feature collection and sequence to multiple feature mapping; IN USE
# Testing with sp ids 

#In proteomes directory
cp ../UniGene.tab.unique.NF.fasta proteome_testseq.fasta
#split into 30 pieces; 

perl ../split_fasta.p
Please enter filename (without extension): proteome_testseq
Please enter no. of sequences you want in each file 104437 #3133100/30

#::PFAM mapping::
for i in {1..10}; do qsub pfamTestProteome_$i.1.sh ; done #Not executed due to below commands

#PFAM mapping
perl split_fasta.p #split into 1mn seqs/file (4 files) metastasis
Please enter filename (without extension): UniGene.tab.unique.NF
Please enter no. of sequences you want in each file 1000000

nohup hmmscan --cut_ga --tblout UniGene.tab.unique.NF_1_tblout -Z 13672 Pfam-A.hmm UniGene.tab.unique.NF_1.fasta &
nohup hmmscan --cut_ga --tblout UniGene.tab.unique.NF_2_tblout -Z 13672 Pfam-A.hmm UniGene.tab.unique.NF_2.fasta &
nohup hmmscan --cut_ga --tblout UniGene.tab.unique.NF_3_tblout -Z 13672 Pfam-A.hmm UniGene.tab.unique.NF_3.fasta &
nohup hmmscan --cut_ga --tblout UniGene.tab.unique.NF_4_tblout -Z 13672 Pfam-A.hmm UniGene.tab.unique.NF_4.fasta &

cp UniGene.tab.unique.NF_1.fasta proteomes/proteome_testseq_1.1.tblout
cp UniGene.tab.unique.NF_1.fasta proteomes/proteome_testseq_2.1.tblout
cp UniGene.tab.unique.NF_1.fasta proteomes/proteome_testseq_3.1.tblout
cp UniGene.tab.unique.NF_1.fasta proteomes/proteome_testseq_4.1.tblout

#::PROSITE mapping::
for i in {1..10}; do qsub psTestProteome_$i.sh ; done #Not executed
#::SSF mapping:: 
#move the input files to new location
qsub ssfProteome.sh 
mkdir scratch
for i in {1..30}; do qsub ssfProteome$i.sh ; done #output results files stored in scratch directory

qsub pfamTestProteome.sh #Not executed due to below commands
qsub psTestProteome.sh #Not executed due to below commands
qsub ssf1Proteome.sh #changed

#split
split -l 765 proteome_testseq_ssfpspfsingleID -a 4 -d --verbose testseq.ssfpspfsingleID. #2753712/3600 =2295 roundup up for 'all'
split -l 2295 proteome_testseq_ssfpspfsingleID -a 4 -d --verbose testseq.ssfpspfsingleID. #2753712/1200 =2295 roundup up for 'enzymes'

qsub submit_move.sh

#--------------------------------------------------------------------------------------------------------------------------------------
::LEVEL0::
for i in {12..35}; do cp submit11.sh submit$i.sh ; done
for i in {0..35}; do qsub submit$i.sh ; done

qsub submit_ID.sh
qsub submit_sparse.sh

#Probabilities:
#Test
for i in {1..5}; do qsub submit_level0_$i.sh ; done
#predicted as enzymes
#correctly predicted by atleast 2 methods
qsub remove_level0.sh
#--------------------------------------------------------------------------------------------------------------------------------------
##::LEVEL1::
qsub map_remove_level1.sh
qsub submit_sparse.sh

#Probabilities:
for i in {1..5}; do qsub submit_level1_$i.sh ; done
#predicted as enzymes; correctly predicted by atleast 2 methods
qsub remove_level1.sh
#--------------------------------------------------------------------------------------------------------------------------------------
##::LEVEL2::
#remove incorrectly classified from .arff files and sparse steps
qsub map_remove_level2.sh
#Probabilities:
for i in {1..5}; do qsub submit_level2_$i.sh ; done
#predicted as enzymes; correctly predicted by atleast 2 methods
qsub remove_level2.sh
#--------------------------------------------------------------------------------------------------------------------------------------
##::LEVEL3::
#remove incorrectly classified from .arff files and sparse steps
qsub map_remove_level3.sh
#Probabilities:
for i in {1..5}; do qsub submit_level3_$i.sh ; done
#predicted as enzymes; correctly predicted by atleast 2 methods
qsub remove_level3.sh
#--------------------------------------------------------------------------------------------------------------------------------------
##::LEVEL4::
#remove incorrectly classified from .arff files and sparse steps
qsub map_remove_level4.sh
#Probabilities:
for i in {1..5}; do qsub submit_level4_$i.sh ; done
#predicted as enzymes; correctly predicted by atleast 2 methods
qsub remove_level4.sh





#ON CARCINOMA
STEPS:
/Extract all IDs from uniprot/swissprot database as follows
perl ac_id.pl uniprot_sprot.dat >sprot_ACID_all
awk -F "\t" '{print $1}' sprot_ACID_all |uniq>sprot_ID_uniq

/Extract only Fragment IDs from uniprot/swissprot database as follows
Input file should contain ID and DE tags at the beginning of line \n(obtained by egrepping uniprot_trembl.dat file)
egrep '^ID|Fragment;' uniprot_sprot.dat>sprot_IDDE_all
./uniprot_list_frag_ids.pl sprot_IDDE_all > sprot_ID_fragments

/Extract all Non-Fragment IDs from uniprot/swissprot database
/(not matching) print file2 for which there are no matches with file1 field(1)
awk 'FNR==NR{a[$1]++;next}!a[$1]' sprot_ID_fragments sprot_ID_uniq>sprot_ID_uniqNF
or awk 'FNR==NR{a[$1]++} FNR!=NR && !a[$1]' sprot_ID_fragments sprot_ID_uniq>sprot_ID_uniqNF

/Remove <=50AA sequences from sprot
grep '^ID' sprot_IDDE_all|awk -F " " '$4<51 {print $2}'>sprot_50AA
awk 'FNR==NR{a[$1]++;next}!a[$1]' sprot_50AA sprot_ID_uniqNF >sprot_ID_uniqNF50

/Remove enzyme sequences belonging to multiple EC classes
awk -F "\t" '{print $0}' enzyme_uniprot.dat |uniq -u -f 2| awk -F "\t" '{print $3 "\t" $2 "\t" $1}' >enzyme_uniq.dat

/Remove (fragments and <=50AA sequences) from enzymes, compare columns in 2 files and print file 2
awk -f compare.awk sprot_ID_uniqNF50 > enzyme_uniqNF50.dat

/Get full sequences
/divide the enzyme file into 6 major classes
awk -F "\t" '/\t1./{print $0}' enzyme_uniqNF50.dat>enzyme_EC1uniqNF50
awk -F "\t" '/\t2./{print $0}' enzyme_uniqNF50.dat>enzyme_EC2uniqNF50
awk -F "\t" '/\t3./{print $0}' enzyme_uniqNF50.dat>enzyme_EC3uniqNF50
awk -F "\t" '/\t4./{print $0}' enzyme_uniqNF50.dat>enzyme_EC4uniqNF50
awk -F "\t" '/\t5./{print $0}' enzyme_uniqNF50.dat>enzyme_EC5uniqNF50
awk -F "\t" '/\t6./{print $0}' enzyme_uniqNF50.dat>enzyme_EC6uniqNF50

/Get fasta sequences
./getFullseq.pl -1 -n -s enzyme_EC1uniqNF50 sprot.aa>enzyme_EC1seq
./getFullseq.pl -1 -n -s enzyme_EC2uniqNF50 sprot.aa>enzyme_EC2seq
./getFullseq.pl -1 -n -s enzyme_EC3uniqNF50 sprot.aa>enzyme_EC3seq
./getFullseq.pl -1 -n -s enzyme_EC4uniqNF50 sprot.aa>enzyme_EC4seq
./getFullseq.pl -1 -n -s enzyme_EC5uniqNF50 sprot.aa>enzyme_EC5seq
./getFullseq.pl -1 -n -s enzyme_EC6uniqNF50 sprot.aa>enzyme_EC6seq

/CD-HIT 70%
./cd-hit -i enzyme_EC1seq -o enzyme_EC1seqCDH -c 0.7
./cd-hit -i enzyme_EC2seq -o enzyme_EC2seqCDH -c 0.7
./cd-hit -i enzyme_EC3seq -o enzyme_EC3seqCDH -c 0.7
./cd-hit -i enzyme_EC4seq -o enzyme_EC4seqCDH -c 0.7
./cd-hit -i enzyme_EC5seq -o enzyme_EC5seqCDH -c 0.7
./cd-hit -i enzyme_EC6seq -o enzyme_EC6seqCDH -c 0.7

cat enzyme_EC1seqCDH enzyme_EC2seqCDH enzyme_EC3seqCDH enzyme_EC4seqCDH enzyme_EC5seqCDH enzyme_EC6seqCDH >enzyme_ECseqCDH
grep '^>' enzyme_ECseqCDH|awk -F "\t" '{print substr($1,2)}'>enzyme_ECidCDH
awk -f compare1.awk enzyme_ECidCDH> enzyme_uniqNF50CDH.dat


/create negative dataset sprot_nonenz_idCDH or non enzymes (not matched to enzyme sequences)
awk -F "\t" 'FNR==NR {a[$3];next}!($1 in a)' enzyme_uniprot.dat sprot_ID_uniqNF50|sort|uniq>sprot_nonenz
/Get fasta sequences
./getFullseq.pl -1 -n -s sprot_nonenz sprot.aa>sprot_noenz_seq
/CD-HIT 70%
./cd-hit -i sprot_noenz_seq -o sprot_noenz_seqCDH -c 0.7
grep '^>' sprot_noenz_seqCDH|awk -F "\t" '{print substr($1,2)}'>sprot_nonenz_idCDH

#[amohammed@login.tusker]$ 
cat other/cdh70/enzyme_ECseqCDH other/cdh70/sprot_noenz_seqCDH> other/cdh70/proteome_testseq.fasta
cat other/cdh60/enzyme_ECseqCDH other/cdh60/sprot_noenz_seqCDH> other/cdh60/proteome_testseq.fasta
cat other/cdh50/enzyme_ECseqCDH other/cdh50/sprot_noenz_seqCDH> other/cdh50/proteome_testseq.fasta
cat other/cdh40/enzyme_ECseqCDH other/cdh40/sprot_noenz_seqCDH> other/cdh40/proteome_testseq.fasta

------------------------------------------------------
cat proteome_testseq.fasta|grep -c '^>' #
cat enzyme_ECseqCDH|grep -c '^>' #

[amohammed@login.tusker work]$ 
cp other/cdh70/* proteomes/
cp other/cdh60/* proteomes/
cp other/cdh50/* proteomes/
cp other/cdh40/* proteomes/

#split into 10 pieces; 
#In proteomes directory
perl ../split_fasta.p
Please enter filename (without extension): proteome_testseq
Please enter no. of sequences you want in each file 19342
Please enter no. of sequences you want in each file 15198
Please enter no. of sequences you want in each file 11535
Please enter no. of sequences you want in each file 8594

#::PFAM mapping::
for i in {1..10}; do qsub pfamTestProteome_$i.1.sh ; done
#::PROSITE mapping::
for i in {1..10}; do qsub psTestProteome_$i.sh ; done
#::SSF mapping::
#move the input files to new location
qsub ssfProteome.sh
mkdir scratch
for i in {1..10}; do qsub ssfProteome$i.sh ; done #output results files stored in scratch directory

qsub pfamTestProteome.sh
qsub psTestProteome.sh
qsub ssfProteome.sh

more proteome_testseq_ssfpspfsingleID|wc -l #115184; 85759
more proteome_testseq_enz_ssfpspfsingleID|wc -l #64948;46258;29983;17997
#split for 70%,60%,50%,40%
#split -l 162 proteome_testseq_ssfpspfsingleID -a 4 -d --verbose testseq.ssfpspfsingleID. #193240/1200 =162 roundup up
#split -l 127 proteome_testseq_ssfpspfsingleID -a 4 -d --verbose testseq.ssfpspfsingleID. #151811/1200 =127 roundup up
#split -l 96 proteome_testseq_ssfpspfsingleID -a 4 -d --verbose testseq.ssfpspfsingleID. #115184/1200 = 96 roundup up
#split -l 72 proteome_testseq_ssfpspfsingleID -a 4 -d --verbose testseq.ssfpspfsingleID. #85759/1200 = 72 roundup up


#split -l 55 70/proteome_testseq_enz_ssfpspfsingleID -a 4 -d --verbose 70/testseq.enz.ssfpspfsingleID. #64948/1200 =55 roundup up
#split -l 39 60/proteome_testseq_enz_ssfpspfsingleID -a 4 -d --verbose 60/testseq.enz.ssfpspfsingleID. #46258/1200 =39 roundup up
#split -l 25 50/proteome_testseq_enz_ssfpspfsingleID -a 4 -d --verbose 50/testseq.enz.ssfpspfsingleID. #29983/1200 =25 roundup up
#split -l 15 40/proteome_testseq_enz_ssfpspfsingleID -a 4 -d --verbose 40/testseq.enz.ssfpspfsingleID. #17997/1200 =15 roundup up

for i in {0..11}; do qsub submit$i.sh ; done
qsub submit_ID.sh
-------------------------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------------------------

for i in {0..3}; do qsub Eficaz_test_$i.sh ; done


cat proteome_testseq_pfsingleID|cut -f2-|tr "\t" "\n"|sort|uniq|wc -l #9274
cat proteome_testseq_pssingleID|cut -f2-|tr "\t" "\n"|sort|uniq|wc -l #1299


cat proteome_testseq_ssfsingleID|cut -f2-|tr "\t" "\n"|sort|uniq|wc -l #1903
cat proteome_testseq_pspfsingleID|cut -f2-|tr "\t" "\n"|sort|uniq|wc -l #10573
cat proteome_testseq_ssfpspfsingleID|cut -f2-|tr "\t" "\n"|sort|uniq|wc -l #12476

#Additional
cat proteome_testseq_ssfpssingleID|cut -f2-|tr "\t" "\n"|sort|uniq|wc -l #
cat proteome_testseq_ssfpfsingleID|cut -f2-|tr "\t" "\n"|sort|uniq|wc -l #

















@Level3
rm UniGene_SSFPSPFENZ_L3_all_EC_sparse_atleast2
cat UniGene_SSFPSPFENZ_L3_all_EC*_sparse_atleast2>>UniGene_SSFPSPFENZ_L3_all_EC_sparse_atleast2
awk -F"\t" 'FILENAME=="UniGene_SSFPSPFENZ_L3_all_EC_sparse_atleast2_UID"{a[$1]=$0} FILENAME=="../proteome_testseq.ssfpspfsingleID_UID"{if(a[$1]){print a[$1] "\t" $0}}' UniGene_SSFPSPFENZ_L3_all_EC_sparse_atleast2_UID ../proteome_testseq.ssfpspfsingleID_UID>proteome_testseq.ssfpspfsingleID_UID_L3
cat proteome_testseq.ssfpspfsingleID_UID_L3|grep -c '_ARATH'>>proteome_testseq.ssfpspfsingleID_UID_L3_count
cat proteome_testseq.ssfpspfsingleID_UID_L3|grep -c '_CHICK'>>proteome_testseq.ssfpspfsingleID_UID_L3_count
cat proteome_testseq.ssfpspfsingleID_UID_L3|grep -c '_DROME'>>proteome_testseq.ssfpspfsingleID_UID_L3_count
cat proteome_testseq.ssfpspfsingleID_UID_L3|grep -c '_ECOLI'>>proteome_testseq.ssfpspfsingleID_UID_L3_count
cat proteome_testseq.ssfpspfsingleID_UID_L3|grep -c '_HUMAN'>>proteome_testseq.ssfpspfsingleID_UID_L3_count
cat proteome_testseq.ssfpspfsingleID_UID_L3|grep -c '_MOUSE'>>proteome_testseq.ssfpspfsingleID_UID_L3_count
cat proteome_testseq.ssfpspfsingleID_UID_L3|grep -c '_CAEEL'>>proteome_testseq.ssfpspfsingleID_UID_L3_count
cat proteome_testseq.ssfpspfsingleID_UID_L3|grep -c '_ORYSJ'>>proteome_testseq.ssfpspfsingleID_UID_L3_count
cat proteome_testseq.ssfpspfsingleID_UID_L3|grep -c '_YEAST'>>proteome_testseq.ssfpspfsingleID_UID_L3_count
cat proteome_testseq.ssfpspfsingleID_UID_L3|grep -c '_DANRE'>>proteome_testseq.ssfpspfsingleID_UID_L3_count




#NEW
more enzyme_uniprot.dat|grep -c '_ARATH' #2934
more enzyme_uniprot.dat|grep -c '_CHICK' #455
more enzyme_uniprot.dat|grep -c '_DROME' #658
more enzyme_uniprot.dat|grep -c '_ECOLI' #1204
more enzyme_uniprot.dat|grep -c '_HUMAN' #3169
more enzyme_uniprot.dat|grep -c '_MOUSE' #2968
more enzyme_uniprot.dat|grep -c '_CAEEL' #688
more enzyme_uniprot.dat|grep -c '_ORYSJ' #919
more enzyme_uniprot.dat|grep -c '_YEAST' #1452
more enzyme_uniprot.dat|grep -c '_DANRE' #419

##OLD##
#After installing Pfmam, hmmer,scop and prosite
#PFAM mapping
scp pfam_all_PFID amohammed@tusker.unl.edu:/work/unmc_gudalab/amohammed/proteomes
qsub enzymeTestProteome.sh
for i in {1..10}; do qsub pfamTestProteome_$i.1.sh ; done #select=1
#move above fasta files to carcinoma and run hmmscan for pfam; dint work good
##Test same on carcinoma
hmmscan --cut_ga --tblout proteome_testseq_1.tblout -Z 13672 /storage/EXTDB/PFAM/Pfam-A.hmm proteome_testseq_1.fasta
#PROSITE
#Map Test sequence to PS patterns
scp ps_all_list amohammed@tusker.unl.edu:/work/unmc_gudalab/amohammed/proteomes
qsub psProteome.sh #~12hrs
#SSF
#move the input files to new location
qsub ssfProteome.sh
for i in {1..10}; do qsub ssfProteome$i.sh ; done #select=1; #output results files stored in scratch directory
scp ssf_all_list amohammed@tusker.unl.edu:/work/unmc_gudalab/amohammed/proteomes
qsub ssf1Proteome.sh
#--------------------------------------------------------------------------------------------------------------------------------------
::LEVEL0::
for i in {0..11}; do qsub submit$i.sh ; done
qsub submit_ID.sh
qsub submit_sparse.sh

@/work/unmc_gudalab/amohammed/proteomes
mkdir Level0 Level1 Level2 Level3
@/storage/cgudastf/akram/weka-3-7-5
scp Level0/ssf_all4_*_train80_copy_sparse_nocv.model amohammed@tusker.unl.edu:/work/unmc_gudalab/amohammed/proteomes/Level0
scp Level1/ssf_enz4_*_new_sparse_train80.model amohammed@tusker.unl.edu:/work/unmc_gudalab/amohammed/proteomes/Level1
scp Level2/*.model amohammed@tusker.unl.edu:/work/unmc_gudalab/amohammed/proteomes/Level2
scp Level3/*.model amohammed@tusker.unl.edu:/work/unmc_gudalab/amohammed/proteomes/Level3

@/storage/cgudastf/akram/ENZYME_DB/ENZYME
scp Level2/ssf_ps_pfam_enz1_L2_EC*.arff amohammed@tusker.unl.edu:/work/unmc_gudalab/amohammed/proteomes/Level2
scp Level3/ssf_ps_pfam_enz1_L3_EC*.arff amohammed@tusker.unl.edu:/work/unmc_gudalab/amohammed/proteomes/Level3

#Probabilities:
#Test (includes repeats)
for i in {1..5}; do qsub submit_level0_$i.sh ; done
#Remove MISCLASSIFIED instances and retrain at level 1 using TOP3: SVM,Multiclassifier,RandomForest
#predicted as enzymes
# correctly predicted by atleast 2 methods
qsub remove_level0.sh
#--------------------------------------------------------------------------------------------------------------------------------------
##::LEVEL1::
for i in {0..11}; do qsub submit$i.sh ; done
qsub submit_ID.sh
qsub map_remove_level1.sh
qsub submit_sparse.sh

#Probabilities:
for i in {1..5}; do qsub submit_level1_$i.sh ; done
#For Training; Quickest way (works with Record ID and .model file) ../ENZYME_DB/ENZYME/ssf_ps_pfam_enz4_new_sparse_train80.arff
#Test (works with Record ID and .model file no repeats) ../ENZYME_DB/ENZYME/ssf_ps_pfam_enz4_new_sparse_test20_NR.arff
#Test (includes repeats) ../ENZYME_DB/ENZYME/ssf_ps_pfam_enz4_new_sparse_test20.arff
#Remove MISCLASSIFIED instances and retrain at level 1 using TOP3: SVM,Multiclassifier,RandomForest
#predicted as enzymes; correctly predicted by atleast 2 methods
qsub remove_level1.sh
#--------------------------------------------------------------------------------------------------------------------------------------
##::LEVEL2::
#remove incorrectly classified from .arff files and sparse steps
qsub map_remove_level2.sh
#Probabilities:
for i in {1..5}; do qsub submit_level2_$i.sh ; done
#Remove MISCLASSIFIED instances and retrain at level 2 using TOP3: SVM,Multiclassifier,RandomForest
#predicted as enzymes; correctly predicted by atleast 2 methods
qsub remove_level2.sh
#--------------------------------------------------------------------------------------------------------------------------------------
##::LEVEL3::
#remove incorrectly classified from .arff files and sparse steps
qsub map_remove_level3.sh
#Probabilities:
for i in {1..5}; do qsub submit_level3_$i.sh ; done
#Remove MISCLASSIFIED instances and retrain at level 3 using TOP3: SVM,Multiclassifier,RandomForest
#predicted as enzymes; correctly predicted by atleast 2 methods
qsub remove_level3.sh