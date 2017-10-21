#!/bin/sh

sh submit_move.sh


# Data collection and feature collection and sequence to multiple feature mapping

# Sequence to feature mapping
# qsub enzymeSplitProteome.sh #Activate it only if you are dealing with 10 proteomes
# In bin directory; split into 10 pieces;

#Store fasta file in $ECemble/test directory

#Execute all scripts from $ECemble/bin directory
#Rename fasta file
perl renameFile.pl ../test/teep

perl splitFasta.pl -verbose -i ../test/proteome_testseq -n 10

#move the input files to new location for SSF processing (.fasta to .fa)
sh ssfProteome_move.sh

#::PFAM mapping::
sh pfamFeature.sh
#::PROSITE mapping::
sh psFeature.sh
#::SSF mapping:: (#output results files stored in scratch directory)
sh ssfFeature.sh (manual enter)

#Integrate features from all the databases
sh pfam_ps_ssfFeature.sh

#split lines from proteome_testseq_ssfpspfsingleID
perl splitFile.pl

#--------------------------------------------------------------------------------------------------------------------------------------
#::LEVEL0::
perl createFeatureVector.pl #(need to wait)
perl Add_ID.pl #(need to wait)
perl create_sparse_L0.pl #(need to wait)
#Probabilities:
#Test
perl test_level0_1.pl #(need to wait) 
perl test_level0_2.pl #(need to wait)
perl test_level0_3.pl #(need to wait)
#predicted as enzymes
#correctly predicted by atleast 2 methods
sh postprocess_test_level0.sh
#--------------------------------------------------------------------------------------------------------------------------------------
##::LEVEL1::
perl preprocess_test_level1.pl
perl create_sparse_L1.pl
#Probabilities:
#Test
perl test_level1_1.pl
perl test_level2_2.pl
perl test_level3_3.pl
#predicted as enzymes; correctly predicted by atleast 2 methods
sh postprocess_test_level1.sh
#--------------------------------------------------------------------------------------------------------------------------------------
##::LEVEL2::
#remove incorrectly classified from .arff files and sparse steps
perl preprocess_test_level2.pl
#Probabilities:
sh test_level2_1.sh
sh test_level2_2.sh
sh test_level2_3.sh
#predicted as enzymes; correctly predicted by atleast 2 methods
sh postprocess_test_level2.sh
#--------------------------------------------------------------------------------------------------------------------------------------
##::LEVEL3::
#remove incorrectly classified from .arff files and sparse steps
perl preprocess_test_level3.pl #terminates by itself because nothing is made to run in the background (&)
#Probabilities:
sh test_level3.sh
#predicted as enzymes; correctly predicted by atleast 2 methods
sh postprocess_test_level3.sh
#--------------------------------------------------------------------------------------------------------------------------------------
##::LEVEL4::
#remove incorrectly classified from .arff files and sparse steps
sh preprocess_test_level4.sh
#Probabilities:
sh test_level4.sh
#predicted as enzymes; correctly predicted by atleast 2 methods
sh postprocess_test_level4.sh
