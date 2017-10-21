#!/bin/sh
# Written by Akram Mohammed
cd /usr/local/apache2/htdocs/genome/ECemble/temp/
#PFAM Features
for ((i=1; i<=10; i++))
do
#parse hmmscan tblout
awk -F" " '!/#/{print $3 "\t" substr($2,1,7)}' $1\_$i.tblout|sort|uniq>$1\_$i.pfall
#singleID proteome_testseq_$i.pfall
awk -F"\t" 'END { for (k in _) print _[k] } { _[$1] = $1 in _ ? _[$1] FS $2 : $0 }' $1\_$i.pfall|sort|uniq>$1\_$i.pfsingleID
done
cat $1\_*.pfsingleID>$1.pfsingleID

#PS Features
for ((i=1; i<=10; i++))
do
# parse ps patterns
awk -F" " '/^>/{print substr($1,2) "\t" $3}' $1\_$i.ps|sort|uniq>$1\_$i.psall
# singleID proteome_testseq_$i.psall
awk -F"\t" 'END { for (k in _) print _[k] } { _[$1] = $1 in _ ? _[$1] FS $2 : $0 }' $1\_$i.psall|sort|uniq>$1\_$i.pssingleID
done
cat $1\_*.pssingleID>$1\_pssingleID
#SSF Features
for ((i=1; i<=10; i++))
do
cat $1$i.ass|awk -F" " '{print $1"\tSSF" $2}'|sort|uniq>$1\_$i.ssfALL
cat $1\_$i.ssfALL|sed 's/SSF00/SSF/g'>$1\_$i.ssfALL0
awk -F"\t" '{if(length($2)>4) print $0}' $1\_$i.ssfALL0>$1\_$i.ssfall
awk -F"\t" 'FILENAME=="../ECemble_Package/lib/SUPERFAMILY/model_SSF.tab"{a[$1]=$0} FILENAME=="'$1'\_'$i'.ssfall"{if(a[$2]){print a[$2] "\t" $0}}' ../ECemble_Package/lib/SUPERFAMILY/model_SSF.tab $1\_$i.ssfall|awk -F"\t" '{print $3"\t"$2}'|sort|uniq>$1\_$i.ssfall_map
#singleID $1\_$i.ssfall_map
awk -F"\t" 'END { for (k in _) print _[k] } { _[$1] = $1 in _ ? _[$1] FS $2 : $0 }' $1\_$i.ssfall_map|sort|uniq>$1\_$i.ssfsingleID
done
cat $1\_*.ssfsingleID>$1\_ssfsingleID

#INTEGRATE PFAM AND PROSITE Features
for ((i=1; i<=10; i++))
do
awk -F"\t" 'FILENAME=="'$1'\_'$i'.pfsingleID"{a[$1]=$0} FILENAME=="'$1'\_'$i'.pssingleID"{if(a[$1]){print a[$1] "\t" $0}}' $1\_$i.pfsingleID $1\_$i.pssingleID|awk -F"\t" -v i=2 '{for(i=2;i<=NF;i++){ if($1==$i){$i="";i=NF+1}} print $0}'|sed -e 's/  / /g' -e 's/ /\t/g'>$1\_$i.pspfsingleID1
awk -F"\t" 'FILENAME=="'$1'\_'$i'.pfsingleID"{a[$1]=$1} FILENAME=="'$1'\_'$i'.pssingleID"{if(!a[$1]){print $0}}' $1\_$i.pfsingleID $1\_$i.pssingleID>$1\_$i.pspfsingleID2
awk -F"\t" 'FILENAME=="'$1'\_'$i'.pssingleID"{a[$1]=$1} FILENAME=="'$1'\_'$i'.pfsingleID"{if(!a[$1]){print $0}}' $1\_$i.pssingleID $1\_$i.pfsingleID>$1\_$i.pspfsingleID3
cat $1\_$i.pspfsingleID1 $1\_$i.pspfsingleID2 $1\_$i.pspfsingleID3>$1\_$i.pspfsingleID
done
cat $1\_*.pspfsingleID>$1\_pspfsingleID

#INTEGRATE ps_pfam with ssf features
for ((i=1; i<=10; i++))
do
awk -F"\t" 'FILENAME=="'$1'\_'$i'.pspfsingleID"{a[$1]=$0} FILENAME=="'$1'\_'$i'.ssfsingleID"{if(a[$1]){print a[$1] "\t" $0}}' $1\_$i.pspfsingleID $1\_$i.ssfsingleID|awk -F"\t" -v i=2 '{for(i=2;i<=NF;i++){ if($1==$i){$i="";i=NF+1}} print $0}'|sed -e 's/  / /g' -e 's/ /\t/g'>$1\_$i.ssfpspfsingleID1
awk -F"\t" 'FILENAME=="'$1'\_'$i'.pspfsingleID"{a[$1]=$1} FILENAME=="'$1'\_'$i'.ssfsingleID"{if(!a[$1]){print $0}}' $1\_$i.pspfsingleID $1\_$i.ssfsingleID>$1\_$i.ssfpspfsingleID2
awk -F"\t" 'FILENAME=="'$1'\_'$i'.ssfsingleID"{a[$1]=$1} FILENAME=="'$1'\_'$i'.pspfsingleID"{if(!a[$1]){print $0}}' $1\_$i.ssfsingleID $1\_$i.pspfsingleID>$1\_$i.ssfpspfsingleID3
cat $1\_$i.ssfpspfsingleID1 $1\_$i.ssfpspfsingleID2 $1\_$i.ssfpspfsingleID3>$1\_$i.ssfpspfsingleID
done
cat $1\_*.ssfpspfsingleID>$1\_ssfpspfsingleID

awk -F"\t" '{print NR"\t" $1}' $1\_ssfpspfsingleID>$1\_ssfpspfsingleID_ID
