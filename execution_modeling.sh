##::Level0::##
sbatch modeling_UpdateWeka.sh
sbatch modeling_L0_0.sh
for i in {1..5}; do sbatch modeling_L0_$i.sh ; done
sbatch modeling_L0_postprocess.sh

##::LEVEL1::##
sbatch modeling_L1_0.sh
for i in {1..5}; do sbatch modeling_L1_$i.sh ; done
sbatch modeling_L1_postprocess.sh

##::LEVEL2::##
sbatch modeling_L2_0.sh
for i in {1..5}; do sbatch modeling_L2_$i.sh ; done
sbatch modeling_L2_postprocess.sh

##::LEVEL3::##
sbatch modeling_L3_preprocess.sh
#manually remove "[" and "]" from SSFPSPFENZ_L3_EC_singleClassLabel and execute the below command, eventaully needs to be done automated
#awk -F',' '{print ",EC" $1 "." $2 "." "x"}' SSFPSPFENZ_L3_EC_singleClassLabel>SSFPSPFENZ_L3_EC_singleClassLabel1


#Manually add array labels
sbatch modeling_L3_0.sh
#Add ECx.x in SSFPSPFENZ_L3_ECi.j_label based on SSFPSPFENZ_L3_EC_class_singleClassLabel to make single class to multi-class problem 
sbatch modeling_L3_00.sh
# NOT ENOUGH SEQUENCES: For 80-20 data partioning we  cant have less than 5 sequences in 
# Based on the previous step remove the EC[i,j] from array in all the below scripts
# No CV
for i in {1..5}; do sbatch modeling_L3_$i.sh ; done
sbatch modeling_L3_postprocess.sh

##::LEVEL4::##
sbatch modeling_L4_preprocess.sh
#manually remove "[" and "]" from SSFPSPFENZ_L4_EC_singleClassLabel and execute the next, eventually needs to be done automated
#awk -F',' '{print ",EC" $1 "." $2 "." $3 "." "x"}' SSFPSPFENZ_L4_EC_singleClassLabel>SSFPSPFENZ_L4_EC_singleClassLabel1
#Manual add array labels
sbatch modeling_L4_0.sh
#remove EC from SSFPSPFENZ_L4_ECi.j.k_label that are found in testJob.stderr 
#Add ECx.x in SSFPSPFENZ_L3_ECi.j_label based on SSFPSPFENZ_L3_EC_class_singleClassLabel to make single class to multi-class problem
sbatch modeling_L4_00.sh
#remove EC found in testJob.stderr from modeling_L4_$i.sh, due to 
#java.lang.IllegalArgumentException: Can't have more folds than instances! (0 size files)
for i in {1..5}; do sbatch modeling_L4_$i.sh ; done
sbatch modeling_L4_postprocess.sh

sbatch modeling_stats.sh

@ATTRIBUTE class {EC1.1,EC1.10,EC1.11,EC1.12,EC1.13,EC1.14,EC1.15,EC1.16,EC1.17,EC1.18,EC1.2,EC1.20,EC1.21,EC1.22,EC1.3,EC1.4,EC1.5,EC1.6,EC1.7,EC1.8,EC1.9,EC1.97}
@ATTRIBUTE class {EC2.1,EC2.2,EC2.3,EC2.4,EC2.5,EC2.6,EC2.7,EC2.8,EC2.9}
@ATTRIBUTE class {EC3.1,EC3.10,EC3.11,EC3.13,EC3.2,EC3.3,EC3.4,EC3.5,EC3.6,EC3.7,EC3.8}
@ATTRIBUTE class {EC4.1,EC4.2,EC4.3,EC4.4,EC4.5,EC4.6,EC4.99}
@ATTRIBUTE class {EC5.1,EC5.2,EC5.3,EC5.4,EC5.5,EC5.99}
@ATTRIBUTE class {EC6.1,EC6.2,EC6.3,EC6.4,EC6.5,EC6.6}


[amohammed@login.tusker Level4]$ cat SSFPSPFENZ_L4_top3_all_EC_sparse_atleast2|tr ':' '\t'> SSFPSPFENZ_L4_top3_all_EC_sparse_atleast2.tab


paste enzyme_ECseqCDH_NR_20_all_blast_results_reorder_NEE enzyme_ECseqCDH_NR_20_all_blast_results_ENE|cut -f1,13,3|awk -F"\t" '{print $0 "\t" NR}'|sort -k1,1>enzyme_ECseqCDH_NR_20_all_blast_results_NEE_ENE
paste enzyme_ECseqCDH_NR_20_all_blast_results_reorder_NEE enzyme_ECseqCDH_NR_20_all_blast_results_ENE|cut -f1,13,3|awk -F"\t" '{print $0 "\t" NR}'|sort -k3,3>enzyme_ECseqCDH_NR_20_all_blast_results_NEE_ENE_sortc3

cat ../model/Level0/ssf_ps_pfam_all_singleID |awk -F"\t" '{print NR"\t" $0}'>ssf_ps_pfam_all_singleID_NR


awk -F"\t" 'FILENAME=="../model/Level4/SSFPSPFENZ_L4_top3_all_EC_sparse_atleast2.tab"{a[$1]=$0} FILENAME=="ssf_ps_pfam_all_singleID_NR"{if(a[$1]){print a[$1] "\t" $0}}' ../model/Level4/SSFPSPFENZ_L4_top3_all_EC_sparse_atleast2.tab ssf_ps_pfam_all_singleID_NR|awk -F"\t" -v i=2 '{for(i=2;i<=NF;i++){if($1==$i){$i="";i=NF+1}} print $0}'|sed -e 's/  / /g' -e 's/ /\t/g'|cut -f1,3,4|sort -k3,3>ssf_ps_pfam_all_singleID_NR_L4

awk -F"\t" 'FILENAME=="../model/Level0/ssf_all4_top3_sparse_atleast2"{a[$1]=$0} FILENAME=="ssf_ps_pfam_all_singleID_NR"{if(a[$1]){print a[$1] "\t" $0}}' ../model/Level0/ssf_all4_top3_sparse_atleast2 ssf_ps_pfam_all_singleID_NR|awk -F"\t" -v i=2 '{for(i=2;i<=NF;i++){if($1==$i){$i="";i=NF+1}} print $0}'|sed -e 's/  / /g' -e 's/ /\t/g'|cut -f1,2|sort -k2,2>ssf_ps_pfam_all_singleID_NR_L0

awk -F"\t" 'FILENAME=="enzyme_ECseqCDH_NR_20_all_blast_results_NEE_ENE"{a[$1]=$0} FILENAME=="ssf_ps_pfam_all_singleID_NR_L4"{if(a[$3]){print a[$3] "\t" $0}}' enzyme_ECseqCDH_NR_20_all_blast_results_NEE_ENE ssf_ps_pfam_all_singleID_NR_L4|awk -F"\t" -v i=2 '{for(i=2;i<=NF;i++){if($1==$i){$i="";i=NF+1}} print $0}'|sed -e 's/  / /g' -e 's/ /\t/g'>map1
awk -F"\t" 'FILENAME=="enzyme_ECseqCDH_NR_20_all_blast_results_NEE_ENE_sortc3"{a[$3]=$0} FILENAME=="ssf_ps_pfam_all_singleID_NR_L0"{if(a[$2]){print a[$2] "\t" $0}}' enzyme_ECseqCDH_NR_20_all_blast_results_NEE_ENE_sortc3 ssf_ps_pfam_all_singleID_NR_L0|awk -F"\t" -v i=2 '{for(i=2;i<=NF;i++){if($1==$i){$i="";i=NF+1}} print $0}'|sed -e 's/  / /g' -e 's/ /\t/g'>map2



[amohammed@login.tusker PfamB]$ cat enzyme_ECseqCDH_NR_20_ENE.tab|sort -k1,1>enzyme_ECseqCDH_NR_20_ENE_sortc1.tab
[amohammed@login.tusker PfamB]$ cat enzyme_ECseqCDH_NR_20_ENE.tab|sort -k3,3>enzyme_ECseqCDH_NR_20_ENE_sortc3.tab

awk -F"\t" 'FILENAME=="enzyme_ECseqCDH_NR_20_ENE_sortc1.tab"{a[$1]=$0} FILENAME=="ssf_ps_pfam_all_singleID_NR_L4"{if(a[$3]){print a[$3] "\t" $0}}' enzyme_ECseqCDH_NR_20_ENE_sortc1.tab ssf_ps_pfam_all_singleID_NR_L4|awk -F"\t" -v i=2 '{for(i=2;i<=NF;i++){if($1==$i){$i="";i=NF+1}} print $0}'|sed -e 's/  / /g' -e 's/ /\t/g'>map1_full
awk -F"\t" 'FILENAME=="enzyme_ECseqCDH_NR_20_ENE_sortc3.tab"{a[$3]=$0} FILENAME=="ssf_ps_pfam_all_singleID_NR_L0"{if(a[$2]){print a[$2] "\t" $0}}' enzyme_ECseqCDH_NR_20_ENE_sortc3.tab ssf_ps_pfam_all_singleID_NR_L0|awk -F"\t" -v i=2 '{for(i=2;i<=NF;i++){if($1==$i){$i="";i=NF+1}} print $0}'|sed -e 's/  / /g' -e 's/ /\t/g'>map2_full



FilteredClassifierUpdateable: Incremental version of weka.classifiers.meta.FilteredClassifier, which takes only incremental base classifiers (i.e., classifiers implementing weka.classifiers.UpdateableClassifier)
Package: weka.classifiers.meta

DEFAULT: for flags; writing
java weka.classifiers.meta.FilteredClassifier -F "weka.filters.unsupervised.attribute.Remove -R first" -W weka.classifiers.bayes.NaiveBayes --
java weka.classifiers.meta.FilteredClassifier -F "weka.filters.unsupervised.attribute.Remove -R first" -W weka.classifiers.functions.SMO -- -C 1.0 -L 0.001 -P 1.0E-12 -N 0 -V -1 -W 1 -K "weka.classifiers.functions.supportVector.PolyKernel -C 250007 -E 1.0"
java weka.classifiers.meta.FilteredClassifier -F "weka.filters.unsupervised.attribute.Remove -R first" -W weka.classifiers.trees.RandomForest -- -I 10 -K 0 -S 1 -num-slots 1


jar xf weka-src.jar -C /location/


1) Acquire weka-src.jar (this should just be in the directory where you install weka).

2)Make a working directory which will house your modified version of weka

3)Unzip weka-src.jar into this working directory (simply unzip weka-src.jar)

4) Make a lib directory so things will compile

5) Write your class or make changes to existing weka classes

6) If you added a new class, be sure to add it in the file the Weka GUI uses to build its menus (src/main/java/weka/gui/GenericObjectEditor.props)

7) Make the executable jar by running “ant exejar”

8) Check out the dist/ folder for your hot new weka.jar (which should have your new classes in it!)

@ /dist/
moved weka.jar to parent directory
jar xf weka.jar #created

pbsnodes -a|grep -B 1 '= free'|more
download and install apache ant and set the class path in .bashrc and .bash_profile

chmod u+x /work/unmc_gudalab/amohammed/apache-ant-1.8.4/bin/ant

export ANT_OPTS=-Dbuild.sysclasspath=ignore

#ant -f fetch.xml -Ddest=system ANT_HOME directory
ant exejar #creates dist/weka.jar

cp -r * ../



Staphylococcus1.fasta
StaphylococcusPFAMA_tblout: e-value
StaphylococcusPFAMB_tblout: e-value

integrate PfamA PfamB : IDaddTab4
master








[amohammed@login.tusker U19]$ 
Download Pfam-B.hmm
./../hmmer-3.0/src/hmmpress Pfam-B.hmm

#Converted Excel to txt file: Staphylococcus.txt
#Removed Header Line from Staphylococcus.txt
#Checked for duplicates : None
#Convert TAB to fasta
perl -e '$len=0; while(<>) {s/\r?\n//; @F=split /\t/, $_; print ">$F[0]"; if (length($F[1])) {print " $F[1]"} print "\n"; $s=$F[10]; $len+= length($s); $s=~s/.{60}(?=.)/$&\n/g; print "$s\n";} warn "\nConverted $. tab-delimited lines to FASTA format\nTotal sequence length: $len\n\n";' Staphylococcus.txt >Staphylococcus.fasta
perl -e '$len=0; while(<>) {s/\r?\n//; @F=split /\t/, $_; print ">$F[1]"; if (length($F[3])) {print " $F[3]"} print "\n"; $s=$F[10]; $len+= length($s); $s=~s/.{60}(?=.)/$&\n/g; print "$s\n";} warn "\nConverted $. tab-delimited lines to FASTA format\nTotal sequence length: $len\n\n";' Staphylococcus.txt >Staphylococcus1.fasta


#hmmscan PFAM-A.hmm; cut_ga; /work/U19/
cp Pfam-A.hmm ../U19/
./../hmmer-3.0/src/hmmpress Pfam-A.hmm
./../hmmer-3.0/src/hmmscan -o StaphylococcusPFAMA.o --cut_ga --tblout StaphylococcusPFAMA_tblout -Z 13672 Pfam-A.hmm Staphylococcus.fasta
awk -F" " '!/#/{print $3 "\t" substr($2,1,7)}' StaphylococcusPFAMA_tblout|sort|uniq>StaphylococcusPFAMA_tblout_PFALL
awk -F"\t" 'END { for (k in _) print _[k] } { _[$1] = $1 in _ ? _[$1] FS $2 : $0 }' StaphylococcusPFAMA_tblout_PFALL|sort|uniq>StaphylococcusPFAMA_tblout_PFsingleID #555
more StaphylococcusPFAMA_tblout_PFsingleID|cut -f2-|tr '\t' '|'>addTab
more StaphylococcusPFAMA_tblout_PFsingleID|cut -f1>ID
paste ID addTab>IDaddTab


#match (enzyme and nonenzyme) PFID to PFALL (PFID is a second column not first, so change it in the following command)
awk -F "\t" 'FNR==NR {a[$1];next} ($2 in a)' ../proteomes/pfam_all_PFID StaphylococcusPFAMA_tblout_PFALL|sort|uniq>StaphylococcusPFAMA_tblout_PFID
awk -F"\t" 'END { for (k in _) print _[k] } { _[$1] = $1 in _ ? _[$1] FS $2 : $0 }' StaphylococcusPFAMA_tblout_PFID|sort|uniq>StaphylococcusPFAMA_filter_tblout_PFsingleID #414



#hmmscan PFAM-B.hmm; cut_ga; E 0.1; /work/U19/
./../hmmer-3.0/src/hmmscan -o Staphylococcus.o --cut_ga --tblout Staphylococcus_tblout -Z 20000 Pfam-B.hmm Staphylococcus.fasta  # cut_ga; No Hit
./../hmmer-3.0/src/hmmscan -o Staphylococcus1.o -E 0.1 --tblout Staphylococcus1_tblout -Z 20000 Pfam-B.hmm Staphylococcus.fasta  # E 0.1
awk -F" " '!/#/{print $3 "\t" substr($2,1,7)}' Staphylococcus1_tblout|sort|uniq>Staphylococcus1_tblout_PFALL
awk -F"\t" 'END { for (k in _) print _[k] } { _[$1] = $1 in _ ? _[$1] FS $2 : $0 }' Staphylococcus1_tblout_PFALL|sort|uniq>Staphylococcus1_tblout_PFsingleID

cp Staphylococcus1_tblout StaphylococcusPFAMB_tblout

more Staphylococcus1_tblout_PFsingleID|cut -f2-|tr '\t' '|'>addTab1
more Staphylococcus1_tblout_PFsingleID|cut -f1>ID1
paste ID1 addTab1>ID1addTab1

awk -F"\t" 'FILENAME=="IDaddTab"{a[$1]=$0} FILENAME=="ID1addTab1"{if(a[$1]){print a[$1] "\t" $0}}' IDaddTab ID1addTab1|awk -F"\t" -v i=2 '{for(i=2;i<=NF;i++){if($1==$i){$i="";i=NF+1}} print $0}'|sed -e 's/  / /g' -e 's/ /\t/g'>IDaddTab1
awk -F"\t" 'FILENAME=="IDaddTab"{a[$1]=$1} FILENAME=="ID1addTab1"{if(!a[$1]){print $1 "\t" "-" "\t"$2}}' IDaddTab ID1addTab1>IDaddTab2
awk -F"\t" 'FILENAME=="ID1addTab1"{a[$1]=$1} FILENAME=="IDaddTab"{if(!a[$1]){print $0 "\t" "-"}}' ID1addTab1 IDaddTab>IDaddTab3
cat IDaddTab1 IDaddTab2 IDaddTab3>IDaddTab4

more Staphylococcus.txt |cut -f1>trial_1
more trial_4 |grep '\.'|cut -f1,2,7>trial_5

paste trial_1 trial_5>trial_6

integrate PfamAPfamB(IDaddTab4) and enzymeNonenzyme(Level0/proteome_testseq.ssfpspfsingleIDUID_L0_ENE)
awk -F"\t" 'FILENAME=="trial_6"{a[$1]=$0} FILENAME=="Level0/proteome_testseq.ssfpspfsingleIDUID_L0_ENE"{if(a[$1]){print a[$1] "\t" $0}}' trial_6 Level0/proteome_testseq.ssfpspfsingleIDUID_L0_ENE|awk -F"\t" -v i=2 '{for(i=2;i<=NF;i++){if($1==$i){$i="";i=NF+1}} print $0}'|sed -e 's/  / /g' -e 's/ /\t/g'>IDaddTab5
awk -F"\t" 'FILENAME=="Level0/proteome_testseq.ssfpspfsingleIDUID_L0_ENE"{a[$1]=$1} FILENAME=="trial_6"{if(!a[$1]){print $0"\t""-"}}' Level0/proteome_testseq.ssfpspfsingleIDUID_L0_ENE trial_6>IDaddTab6
cat IDaddTab5 IDaddTab6>IDaddTab8

awk -F"\t" 'FILENAME=="IDaddTab8"{a[$1]=$0} FILENAME=="IDaddTab4"{if(a[$1]){print a[$1] "\t" $0}}' IDaddTab8 IDaddTab4|awk -F"\t" -v i=2 '{for(i=2;i<=NF;i++){if($1==$i){$i="";i=NF+1}} print $0}'|sed -e 's/  / /g' -e 's/ /\t/g'>IDaddTab9
awk -F"\t" 'FILENAME=="IDaddTab8"{a[$1]=$1} FILENAME=="IDaddTab4"{if(!a[$1]){print $1 "\t" "-" "\t" $2}}' IDaddTab8 IDaddTab4>IDaddTab10
awk -F"\t" 'FILENAME=="IDaddTab4"{a[$1]=$1} FILENAME=="IDaddTab8"{if(!a[$1]){print $0 "\t" "-"}}' IDaddTab4 IDaddTab8>IDaddTab11
cat IDaddTab9 IDaddTab10 IDaddTab11>IDaddTab12

awk -F"\t" 'FILENAME=="Staphylococcus.txt"{a[$1]=$0} FILENAME=="trial_5"{if(a[$3]){print a[$1] "\t" $0}}' Staphylococcus.txt trial_5|awk -F"\t" -v i=2 '{for(i=2;i<=NF;i++){if($1==$i){$i="";i=NF+1}} print $0}'|sed -e 's/  / /g' -e 's/ /\t/g'>trial_6
awk -F"\t" 'FILENAME=="IDaddTab"{a[$1]=$0} FILENAME=="ID1addTab1"{if(a[$1]){print a[$1] "\t" $0}}' IDaddTab ID1addTab1|awk -F"\t" -v i=2 '{for(i=2;i<=NF;i++){if($1==$i){$i="";i=NF+1}} print $0}'|sed -e 's/  / /g' -e 's/ /\t/g'>IDaddTab1

./../hmmer-3.0/src/hmmscan -o Staphylococcus2.o -E 0.01 --tblout Staphylococcus2_tblout -Z 20000 Pfam-B.hmm Staphylococcus.fasta  # E 0.01
awk -F" " '!/#/{print $3 "\t" substr($2,1,7)}' Staphylococcus2_tblout|sort|uniq>Staphylococcus2_tblout_PFALL



awk -F"\t" 'FILENAME=="StaphylococcusPFAMA_tblout_PFALL"{a[$2]=$0} FILENAME=="PfamA_table"{if(a[$1]){print a[$1] "\t" $0}}' StaphylococcusPFAMA_tblout_PFALL PfamA_table|awk -F"\t" -v i=2 '{for(i=2;i<=NF;i++){if($1==$i){$i="";i=NF+1}} print 
$0}'|sed -e 's/  / /g' -e 's/ /\t/g'|cut -f3->PfamA_table1

awk -F "\t" 'FNR==NR {a[$1];next} ($1 in a)' StaphylococcusPFAMA_tblout_PFALL PfamA_table


awk -F"\t" 'FILENAME=="PfamA_table1"{a[$1]=$0} FILENAME=="StaphylococcusPFAMA_tblout_PFALL"{if(a[$1]){print a[$1] "\t" $0}}' PfamA_table1 StaphylococcusPFAMA_tblout_PFALL|awk -F"\t" -v i=2 '{for(i=2;i<=NF;i++){if($1==$i){$i="";i=NF+1}} print $0}'|sed -e 's/  / /g' -e 's/ /\t/g'>PfamA_table2
