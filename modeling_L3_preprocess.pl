#!/usr/bin/perl
system("cat ../Level1/enz_L1|cut -f2|cut -d\".\" -f1-3|awk '{print \",EC\"\$0}'>ssf_ps_pfam_enz_addECclass_L3");
#Add labels
system("awk 'NR==FNR{a[NR]=\$0; next} {\$(NF+1)=a[FNR]}1' ssf_ps_pfam_enz_addECclass_L3 ../Level1/ssf_ps_pfam_enz2.arff|sed 's/'' ''/''''/g'>ssf_ps_pfam_enz3_L3.arff");

my @array = ([1,1],[1,10],[1,11],[1,12],[1,13],[1,14],[1,15],[1,16],[1,17],[1,18],[1,2],[1,20],[1,21],[1,3],[1,4],[1,5],[1,6],[1,7],[1,8],[1,9],[1,97],[2,1],[2,2],[2,3],[2,4],[2,5],[2,6],[2,7],[2,8],[2,9],[3,1],[3,10],[3,11],[3,2],[3,3],[3,4],[3,5],[3,6],[3,7],[3,8],[4,1],[4,2],[4,3],[4,4],[4,5],[4,6],[4,99],[5,1],[5,2],[5,3],[5,4],[5,5],[5,99],[6,1],[6,2],[6,3],[6,4],[6,5],[6,6]);
for (my $x = 0; $x <= $#array; $x++) {
   for (my $y = 1; $y <= $#{$array[$x]}; $y++) {
		my $i=$array[$x][0];
		my $j=$array[$x][$y];
		system("cat ../Level2/ssf_enz4_L2_top3_new_EC$i\_sparse_atleast2|awk -F':' '{if((substr(\$3,3,1)==$i)&&(substr(\$3,5)==$j)) print \$1}'>SSFPSPFENZ_L3_all_EC$i.$j\_sparse_atleast2");		
		system("awk -F\",\" 'FILENAME==\"ssf_ps_pfam_enz3_L3.arff\"{a[\$1]=\$0} FILENAME==\"SSFPSPFENZ_L3_all_EC$i.$j\_sparse_atleast2\"{if(a[\$1]){print a[\$1]}}' ssf_ps_pfam_enz3_L3.arff SSFPSPFENZ_L3_all_EC$i.$j\_sparse_atleast2> SSFPSPFENZI_L3_EC$i.$j.arff");
		system("cat SSFPSPFENZI_L3_EC$i.$j.arff|awk 'END {if (NR>=15) print \"[$i,$j]\"}'>>SSFPSPFENZ_L3_EC_instance_Usable");
		system("cat SSFPSPFENZI_L3_EC$i.$j.arff|awk -F',' '{print \$NF}'|cut -d'.' -f1-3|sort|uniq|tr '.' ','|awk -F',' '{print \$1 \",\" \$2}'|awk '{print \"[\"substr(\$0,3)\"]\"}'>>SSFPSPFENZ_L3_EC_class");
		system("rm SSFPSPFENZ_L3_all_EC$i.$j\_sparse_atleast2");
}}
		system("cat SSFPSPFENZ_L3_EC_class|sort|uniq -c|awk -F' ' '{if(\$1==1) print \$2}'>SSFPSPFENZ_L3_EC_class_singleClassLabel");
		system("cat SSFPSPFENZ_L3_EC_instance_Usable|tr '\n' ','> SSFPSPFENZ_L3_EC_label_Usable");
		system("rm ssf_ps_pfam_enz_addECclass_L3 ssf_ps_pfam_enz3_L3.arff");