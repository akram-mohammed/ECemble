#!/bin/sh
#PBS -N ModelLevel1PreProcess
#PBS -l select=1
#PBS -l walltime=20:00:00
#PBS -o TestJobLevel1PreProcess.stdout
#PBS -e TestJobLevel1PreProcess.stderr
#PBS -m be
#PBS -M akram.mohammed@unmc.edu
# cd $PBS_O_WORKDIR/model_new/40/Level0
# cp ../../../proteomes/ssf_ps_pfam_all.arff ssf_ps_pfam_all.arff
# grep '^@' ssf_ps_pfam_all.arff>ssf_ps_pfam_all1.arff
# grep -v '^@' ssf_ps_pfam_all.arff>ssf_ps_pfam_all2.arff
##Adding Labels to ssf_ps_pfam_all2.arff; This is different
##[amohammed@login.tusker proteomes]$ cat proteome_testseq_enz_ssfpspfsingleID_ID|wc -l
##awk '{if(NR<58787) {print $0 ",E"} if(NR>58786 && NR<=148737) {print $0 ",NE"}}' ssf_ps_pfam_all2.arff> ssf_ps_pfam_all3.arff #old dataset interpro
##awk '{if(NR<=64948) {print $0 ",E"} if(NR>64948) {print $0 ",NE"}}' ssf_ps_pfam_all2.arff> ssf_ps_pfam_all3.arff #for 70%
##awk '{if(NR<=46258) {print $0 ",E"} if(NR>46258) {print $0 ",NE"}}' ssf_ps_pfam_all2.arff> ssf_ps_pfam_all3.arff #for 60%
##awk '{if(NR<=29983) {print $0 ",E"} if(NR>29983) {print $0 ",NE"}}' ssf_ps_pfam_all2.arff> ssf_ps_pfam_all3.arff #for 50%
# awk '{if(NR<=17997) {print $0 ",E"} if(NR>17997) {print $0 ",NE"}}' ssf_ps_pfam_all2.arff> ssf_ps_pfam_all3.arff #for 40%
# cat ssf_ps_pfam_all1.arff ssf_ps_pfam_all3.arff>ssf_ps_pfam_all4.arff

# cd $PBS_O_WORKDIR/weka-3-7-6
# java -Xmx50g weka.filters.supervised.instance.StratifiedRemoveFolds -i ../model_new/40/Level0/ssf_ps_pfam_all4.arff -o ../model_new/40/Level0/ssf_ps_pfam_all4_train80.arff -c last -S 5 -N 5 -F 1 -V
# java -Xmx50g weka.filters.supervised.instance.StratifiedRemoveFolds -i ../model_new/40/Level0/ssf_ps_pfam_all4.arff -o ../model_new/40/Level0/ssf_ps_pfam_all4_test20.arff -c last -S 5 -N 5 -F 1

# cd $PBS_O_WORKDIR/weka-3-7-6
# java -Xmx50g weka.filters.unsupervised.instance.NonSparseToSparse -i ../model_new/40/Level0/ssf_ps_pfam_all4_train80.arff -o ../model_new/40/Level0/ssf_ps_pfam_all4_train80_sparse.arff
# java -Xmx50g weka.filters.unsupervised.instance.NonSparseToSparse -i ../model_new/40/Level0/ssf_ps_pfam_all4_test20.arff -o ../model_new/40/Level0/ssf_ps_pfam_all4_test20_sparse.arff

# cd $PBS_O_WORKDIR/model_new/40/Level0
##nonsparse to sparse removes NE's, cuz it works only with unlabeled data, add them back
##sed -i 's/ 1\}/ 1,14242 NE\}/g' ssf_ps_pfam_all4_train80_sparse.arff&
##sed -i 's/ 1\}/ 1,14242 NE\}/g' ssf_ps_pfam_all4_test20_sparse.arff&

# grep -v '^@' ssf_ps_pfam_all4_test20_sparse.arff>ssf_ps_pfam_all4_test20_sparse_instance.arff
# cat ssf_ps_pfam_all4_train80_sparse.arff ssf_ps_pfam_all4_test20_sparse_instance.arff > ssf_ps_pfam_all4_sparse.arff

cd $PBS_O_WORKDIR/proteomes
cat enzyme_uniprot.dat|awk -F"\t" '{print $3"\t"$1}'>enzyme_uniprot.dat_alter

cd $PBS_O_WORKDIR/model_new/70/Level1
cp ../../../proteomes/70/ssf_ps_pfam_enz.arff ssf_ps_pfam_enz.arff
grep '^@' ssf_ps_pfam_enz.arff>ssf_ps_pfam_enz1.arff
grep -v '^@' ssf_ps_pfam_enz.arff>ssf_ps_pfam_enz2.arff

# Adding Labels to ssf_ps_pfam_enz2.arff; This is different
cat ../../../proteomes/70/proteome_testseq_enz_ssfpspfsingleID_ID|cut -f2>proteome_testseq_enz_ssfpspfsingleID_ID_column
awk -F"\t" 'FILENAME=="../../../proteomes/enzyme_uniprot.dat_alter"{a[$1]=$0} FILENAME=="proteome_testseq_enz_ssfpspfsingleID_ID_column"{if(a[$1]){print a[$1]}}' ../../../proteomes/enzyme_uniprot.dat_alter proteome_testseq_enz_ssfpspfsingleID_ID_column>enz_L1
#ssf_ps_pfam_enz_addECclass to be added to ssf_ps_pfam_enz2.arff
cat enz_L1|cut -f2|cut -d"." -f1|awk '{print ",EC"$0}'>enz_L1_addECclass
#append label as the last column
awk 'NR==FNR{a[NR]=$0; next} {$(NF+1)=a[FNR]}1' enz_L1_addECclass ssf_ps_pfam_enz2.arff|sed 's/'' ''/''''/g'>ssf_ps_pfam_enz3.arff
cat ssf_ps_pfam_enz1.arff ssf_ps_pfam_enz3.arff>ssf_ps_pfam_enz4.arff

cd $PBS_O_WORKDIR/weka-3-7-6
java -Xmx50g weka.filters.supervised.instance.StratifiedRemoveFolds -i ../model_new/70/Level1/ssf_ps_pfam_enz4.arff -o ../model_new/70/Level1/ssf_ps_pfam_enz4_train80.arff -c last -S 5 -N 5 -F 1 -V
java -Xmx50g weka.filters.supervised.instance.StratifiedRemoveFolds -i ../model_new/70/Level1/ssf_ps_pfam_enz4.arff -o ../model_new/70/Level1/ssf_ps_pfam_enz4_test20.arff -c last -S 5 -N 5 -F 1

cd $PBS_O_WORKDIR/weka-3-7-6
java -Xmx50g weka.filters.unsupervised.instance.NonSparseToSparse -i ../model_new/70/Level1/ssf_ps_pfam_enz4_train80.arff -o ../model_new/70/Level1/ssf_ps_pfam_enz4_train80_sparse.arff
java -Xmx50g weka.filters.unsupervised.instance.NonSparseToSparse -i ../model_new/70/Level1/ssf_ps_pfam_enz4_test20.arff -o ../model_new/70/Level1/ssf_ps_pfam_enz4_test20_sparse.arff

cd $PBS_O_WORKDIR/model_new/70/Level1
grep -v '^@' ssf_ps_pfam_enz4_test20_sparse.arff>ssf_ps_pfam_enz4_test20_sparse_instance.arff
cat ssf_ps_pfam_enz4_train80_sparse.arff ssf_ps_pfam_enz4_test20_sparse_instance.arff>ssf_ps_pfam_enz4_sparse.arff