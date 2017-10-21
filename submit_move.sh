#!/bin/sh
# Written by Akram Mohammed
cp ../model/20130825_152318/ssf_ps_pfam_all_list ../test/ #Done Once
cp ../model/20130825_152318/ssf_ps_pfam_enz_list ../test/ #Done Once

mkdir ../test/Level0 ../test/Level1 ../test/Level2 ../test/Level3 ../test/Level4
cp ../model/20130825_152318/Level0/ssf_ps_pfam_all1.arff ../test/Level0/
cp ../model/20130825_152318/Level1/ssf_ps_pfam_enz1.arff ../test/Level1/

cp ../model/20130825_152318/Level0/*.model ../test/Level0/
cp ../model/20130825_152318/Level1/*.model ../test/Level1/
cp ../model/20130825_152318/Level2/*.model ../test/Level2/
cp ../model/20130825_152318/Level3/*.model ../test/Level3/
cp ../model/20130825_152318/Level4/*.model ../test/Level4/

cp ../model/20130825_152318/Level0/ssf_ps_pfam_all1.arff ../test/Level0/
cp ../model/20130825_152318/Level1/ssf_ps_pfam_enz1.arff ../test/Level1/
cp ../model/20130825_152318/Level2/ssf_ps_pfam_enz1_L2_EC*.arff ../test/Level2/
cp ../model/20130825_152318/Level3/SSFPSPFENZHH_L3_EC*.*.arff ../test/Level3/
cp ../model/20130825_152318/Level4/SSFPSPFENZHH_L4_EC*.*.*.arff ../test/Level4/


