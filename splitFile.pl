#!/usr/bin/perl

# Written by Akram Mohammed
# 2010-2015
# Copyright

use CGI::Carp qw(warningsToBrowser fatalsToBrowser);
use Cwd;
use strict;
use warnings;
use POSIX qw(ceil);

my $filename = $ARGV[0];

#################### START LEVEL-0 ####################
# Change directory to temp
chdir ("/usr/local/apache2/htdocs/genome/ECemble/temp") or die "cannot change: $!\n";

print "Generating sequence to feature mapping......<br><br>";

print "Generating EC Level-0 predictions.....<br>";

# Create Feature Vector
system("awk -f ../ECemble_Package/bin/weka_format_dense0.awk ../ECemble_Package/bin/ssf_ps_pfam_all_list $filename>$filename\_all.arff");
system("awk -f ../ECemble_Package/bin/weka_format_dense1.awk ../ECemble_Package/bin/ssf_ps_pfam_enz_list $filename>$filename\_enz.arff");
# Create ARFF Data format
system("grep -v '^\@' $filename\_all.arff|awk -F\",\" '{\$1=(\$1); print \$0}'> $filename\_allI.arff");
system("cat ../ECemble_Package/test/Level0/ssf_ps_pfam_all1.arff $filename\_allI.arff>$filename\_allHI.arff");
system("grep -v '^\@' $filename\_enz.arff|awk -F\",\" '{\$1=(\$1); print \$0}'>$filename\_enzI.arff");
system("cat ../ECemble_Package/test/Level1/ssf_ps_pfam_enz1.arff $filename\_enzI.arff>$filename\_enzHI.arff");

# Change directory to weka
chdir ("/usr/local/apache2/htdocs/genome/ECemble/ECemble_Package/lib/weka-3-7-6") or die "cannot change: $!\n";

# Sparse format for EC Level-0
system ("/usr/local/apache2/htdocs/genome/ECemble/ECemble_Package/lib/jdk1.8.0_25/bin/java -Xmx5g weka.filters.unsupervised.instance.NonSparseToSparse -i $filename\_allHI.arff -o $filename\_all_sparse.arff");

# Predictions at EC Level-0 using RandomForest
# Predictions at EC Level-0 using SMO
# Predictions at EC Level-0 using IBk
system("/usr/local/apache2/htdocs/genome/ECemble/ECemble_Package/lib/jdk1.8.0_25/bin/java -Xmx50g -Xss5g weka.classifiers.trees.RandomForest -T $filename\_all_sparse.arff -l ../../test/Level0/ssf_all4_randomforest_train80_sparse.model -no-cv -p 1 -distribution &> $filename\_L0_randomforest.p");
system("/usr/local/apache2/htdocs/genome/ECemble/ECemble_Package/lib/jdk1.8.0_25/bin/java -Xmx5g weka.classifiers.functions.SMO -T $filename\_all_sparse.arff -l ../../test/Level0/ssf_all4_SMO_train80_sparse.model -no-cv -p 1 -distribution &>$filename\_L0_SMO.p");
system("/usr/local/apache2/htdocs/genome/ECemble/ECemble_Package/lib/jdk1.8.0_25/bin/java -Xmx5g weka.classifiers.lazy.IBk -T $filename\_all_sparse.arff -l ../../test/Level0/ssf_all4_IBK_train80_sparse.model -no-cv -p 1 -distribution &> $filename\_L0_IBK.p");

# Remove missclassified instances at EC Level-0 after consensus from TOP3 classifiers
system("cat $filename\_L0_randomforest.p |awk '/:/{print \$5\":\"\$3}'|sed 's/(//g'|sed 's/)//g'>$filename\_L0_randomforest");
system("cat $filename\_L0_SMO.p |awk '/:/{print \$5\":\"\$3}'|sed 's/(//g'|sed 's/)//g'>$filename\_L0_SMO");
system("cat $filename\_L0_IBK.p |awk '/:/{print \$5\":\"\$3}'|sed 's/(//g'|sed 's/)//g'>$filename\_L0_IBK");

# Consensus: correctly predicted by atleast 2 of the top3 methods
system("paste $filename\_L0_randomforest $filename\_L0_SMO $filename\_L0_IBK|awk -F\"\t\" '{if((\$1==\$2)||(\$2==\$3)||(\$1==\$3)) print \$0}'|tr '\t' '\n'|sort -n|uniq -c|awk -F\" \" '{if((\$1=='2')||(\$1=='3')) print \$2}'|awk -F\":\" '!/NE/{print \$1}'|grep -v '^\$'>$filename\_L0_atleast2");

# Create EC prediction file for Level-0
system("paste $filename\_L0_randomforest $filename\_L0_SMO $filename\_L0_IBK|awk -F\"\t\" '{if((\$1==\$2)||(\$2==\$3)||(\$1==\$3)) print \$0}'|tr '\t' '\n'|sort -n|uniq -c|awk -F\" \" '{if((\$1=='2')||(\$1=='3')) print \$2}'|grep -v '^\$'>$filename\_L0_atleast2_all");
system("cat $filename\_L0_atleast2_all|awk -F\":\" '{print \$1 \"\t\" \$3}'>$filename\_L0_atleast2_ID");
system("awk -F\"\t\" 'FILENAME==\"$filename\_L0_atleast2_ID\"{a[\$1]=\$0} FILENAME==\"$filename\_ID\"{if(a[\$1]){print a[\$1] \"\t\" \$0}}' $filename\_L0_atleast2_ID $filename\_ID|awk -F\"\t\" '{print \$4\"\t\"\$2}'>$filename\_ID_L0.txt");
#system("awk -F\"\t\" 'FILENAME==\"$filename\_L0_atleast2_ID\"{a[\$1]=\$0} FILENAME==\"$filename\_ID\"{if(a[\$1]){print a[\$1] \"\t\" \$0}}' $filename\_L0_atleast2_ID $filename\_ID|awk -F\"\t\" '{if (\$2==\"E\") print \$4\"\t\"\$2}'>$filename\_ID_L0.txt");
#################### END LEVEL-0 ####################





#################### START LEVEL-1 ####################
# Forward correctly predicted instances from EC Level-0 to EC Level-1
system("awk -F\" \" 'FILENAME==\"$filename\_enzI.arff\"{a[\$1]=\$0} FILENAME==\"$filename\_L0_atleast2\"{if(a[\$1]){print a[\$1]}}' $filename\_enzI.arff $filename\_L0_atleast2>$filename\_enzL1.arff");
system("cat ../../test/Level1/ssf_ps_pfam_enz1.arff $filename\_enzL1.arff>$filename\_enz_L1.arff");

# Check if there are sequences to be predicted at EC Level-1
if(-z "$filename\_enzL1.arff"){
	print "Sequence can be predicted till EC Level-0 only</b><br><br>";
	
	# Display EC prediction results
	system("cat $filename\_ID_L* |sort|uniq>$filename\_ID_all.txt");
	open(my $fh, '<:encoding(UTF-8)', "$filename\_ID_all.txt");
	my @shortFilename = split '\/', "$filename\_ID_all.txt";
	print "<table style=\"width: 100%; border-collapse: collapse;\" border=\"1\" cellspacing=\"0\" cellpadding=\"5\">";
	print "<tr style=\"color: #fff\"><td colspan=\"7\"><a href=\"http://genome.unmc.edu/ECemble/temp/$shortFilename[8]\" target=\"_blank\">Download all predictions</a></td></tr>";
	print "<tr style=\"color: #fff\" bgcolor=\"#799DD1\"><td align=\"center\"><b>Input Sequence</b></td><td align=\"center\"><b>EC Prediction</b></td></tr>";
	while(my $row = <$fh>){
		chomp $row;
		print "<tr bgcolor=\"#F1F1F1\">";
		my @cells= split '\t', $row; 
		foreach my $cell (@cells){
			print "<td align=\"center\">$cell</td>";
		}
		print "</tr>";
	}
	print "</table><br><br>";
	exit;
}

print "Generating EC Level-1 predictions.....<br>";
# Sparse format for EC Level-1
system ("/usr/local/apache2/htdocs/genome/ECemble/ECemble_Package/lib/jdk1.8.0_25/bin/java -Xmx5g weka.filters.unsupervised.instance.NonSparseToSparse -i $filename\_enz_L1.arff -o $filename\_enz_L1_sparse.arff");

# Predictions at EC Level-1 using RandomForest
# Predictions at EC Level-1 using SMO
# Predictions at EC Level-1 using IBk
system("/usr/local/apache2/htdocs/genome/ECemble/ECemble_Package/lib/jdk1.8.0_25/bin/java -Xmx50g -Xss5g weka.classifiers.trees.RandomForest -T $filename\_enz_L1_sparse.arff -l ../../test/Level1/ssf_enz4_randomforest_train80_sparse.model -no-cv -p 1 -distribution &> $filename\_L1_randomforest.p");
system("/usr/local/apache2/htdocs/genome/ECemble/ECemble_Package/lib/jdk1.8.0_25/bin/java -Xmx5g weka.classifiers.functions.SMO -T $filename\_enz_L1_sparse.arff -l ../../test/Level1/ssf_enz4_SMO_train80_sparse.model -no-cv -p 1 -distribution &>$filename\_L1_SMO.p");
system("/usr/local/apache2/htdocs/genome/ECemble/ECemble_Package/lib/jdk1.8.0_25/bin/java -Xmx5g weka.classifiers.lazy.IBk -T $filename\_enz_L1_sparse.arff -l ../../test/Level1/ssf_enz4_IBK_train80_sparse.model -no-cv -p 1 -distribution &> $filename\_L1_IBK.p");

# Remove missclassified instances at EC Level-1 after consensus from TOP3 classifiers
system("cat $filename\_L1_randomforest.p |awk '/:/{print \$5\":\"\$3}'|sed 's/(//g'|sed 's/)//g'>$filename\_L1_randomforest");
system("cat $filename\_L1_SMO.p |awk '/:/{print \$5\":\"\$3}'|sed 's/(//g'|sed 's/)//g'>$filename\_L1_SMO");
system("cat $filename\_L1_IBK.p |awk '/:/{print \$5\":\"\$3}'|sed 's/(//g'|sed 's/)//g'>$filename\_L1_IBK");

# Consensus: correctly predicted by atleast 2 of the top3 methods
system("paste $filename\_L1_randomforest $filename\_L1_SMO $filename\_L1_IBK|awk -F\"\t\" '{if((\$1==\$2)||(\$2==\$3)||(\$1==\$3)) print \$0}'|tr '\t' '\n'|sort -n|uniq -c|awk -F\" \" '{if((\$1=='2')||(\$1=='3')) print \$2}'|grep -v '^\$'>$filename\_L1_atleast2");

# Create EC prediction file for Level-1
system("cat $filename\_L1_atleast2|awk -F\":\" '{print \$1 \"\t\" \$3}'>$filename\_L1_atleast2_ID");
system("awk -F\"\t\" 'FILENAME==\"$filename\_L1_atleast2_ID\"{a[\$1]=\$0} FILENAME==\"$filename\_ID\"{if(a[\$1]){print a[\$1] \"\t\" \$0}}' $filename\_L1_atleast2_ID $filename\_ID|awk -F\"\t\" '{print \$4\"\t\"\$2}'>$filename\_ID_L1.txt");

#################### END LEVEL-1 ####################





#################### START LEVEL-2 ####################
for (my $i=1; $i<=6; $i++){
	# Forward correctly predicted instances from EC Level-1 to EC Level-2
	system("cat $filename\_L1_atleast2|awk -F\":\" '{if(\$2=='$i') print \$1}'>$filename\_L1_atleast2_EC$i");
	system("awk -F\" \" 'FILENAME==\"$filename\_enz_L1.arff\"{a[\$1]=\$0} FILENAME==\"$filename\_L1_atleast2_EC'$i'\"{if(a[\$1]){print a[\$1]}}' $filename\_enz_L1.arff $filename\_L1_atleast2_EC$i>$filename\_L2I_EC$i.arff");
	system("cat ../../test/Level2/ssf_ps_pfam_enz1_L2_EC$i.arff $filename\_L2I_EC$i.arff >$filename\_L2_EC$i.arff");
}	
# Check if there are sequences to be predicted at EC Level-2
if((-z "$filename\_L2I_EC1.arff")&&(-z "$filename\_L2I_EC2.arff")&&(-z "$filename\_L2I_EC3.arff")&&(-z "$filename\_L2I_EC4.arff")&&(-z "$filename\_L2I_EC5.arff")&&(-z "$filename\_L2I_EC6.arff")){
	print "Sequence can be predicted till EC Level-1 only<br><br>";
	
	system("awk -F\"\t\" 'FILENAME==\"$filename\_ID_L0.txt\"{a[\$1]=\$0} FILENAME==\"$filename\_ID_L1.txt\"{if(a[\$1]){print a[\$1] \"\t\" \$0}}' $filename\_ID_L0.txt $filename\_ID_L1.txt>$filename\_ID_M1.txt");
	system("awk -F\"\t\" 'FILENAME==\"$filename\_ID_L0.txt\"{a[\$1]=\$0} FILENAME==\"$filename\_ID_L1.txt\"{if(!a[\$1]){print a[\$1] \"\t\" \$0}}' $filename\_ID_L0.txt $filename\_ID_L1.txt>$filename\_ID_N1.txt");
	system("cat $filename\_ID_M1.txt $filename\_ID_N1.txt>$filename\_ID_O1.txt");
	
	
	# Display EC prediction results
	system("cat $filename\_ID_L* |sort|uniq>$filename\_ID_all.txt");
	open(my $fh, '<:encoding(UTF-8)', "$filename\_ID_all.txt");
	my @shortFilename = split '\/', "$filename\_ID_all.txt";
	print "<table style=\"width: 100%; border-collapse: collapse;\" border=\"1\" cellspacing=\"0\" cellpadding=\"5\">";
	print "<tr style=\"color: #fff\"><td colspan=\"7\"><a href=\"http://genome.unmc.edu/ECemble/temp/$shortFilename[8]\" target=\"_blank\">Download all predictions</a></td></tr>";
	print "<tr style=\"color: #fff\" bgcolor=\"#799DD1\"><td align=\"center\"><b>Input Sequence</b></td><td align=\"center\"><b>EC Prediction</b></td></tr>";
	while(my $row = <$fh>){
		chomp $row;
		print "<tr bgcolor=\"#F1F1F1\">";
		my @cells= split '\t', $row; 
		foreach my $cell (@cells){
			print "<td align=\"center\">$cell</td>";
		}
		print "</tr>";
	}
	print "</table><br><br>";	
	exit;
}

print "Generating EC Level-2 predictions.....<br>";
for (my $i=1; $i<=6; $i++){
	#Sparse format for EC Level-2
	system ("/usr/local/apache2/htdocs/genome/ECemble/ECemble_Package/lib/jdk1.8.0_25/bin/java weka.filters.unsupervised.instance.NonSparseToSparse -i $filename\_L2_EC$i.arff -o $filename\_L2_EC$i\_sparse.arff");
	
	# Predictions at EC Level-2 using RandomForest
	# Predictions at EC Level-2 using SMO
	# Predictions at EC Level-2 using IBk
	system("/usr/local/apache2/htdocs/genome/ECemble/ECemble_Package/lib/jdk1.8.0_25/bin/java weka.classifiers.trees.RandomForest -T $filename\_L2_EC$i\_sparse.arff -l ../../test/Level2/ssf_enz4_L2_randomforest_new_EC$i\_sparse_train80.model -no-cv -p 1 -distribution &> $filename\_L2_randomforest_EC$i.p");
	system("/usr/local/apache2/htdocs/genome/ECemble/ECemble_Package/lib/jdk1.8.0_25/bin/java weka.classifiers.functions.SMO -T $filename\_L2_EC$i\_sparse.arff -l ../../test/Level2/ssf_enz4_L2_SMO_new_EC$i\_sparse_train80.model -no-cv -p 1 -distribution &>$filename\_L2_SMO_EC$i.p");
	system("/usr/local/apache2/htdocs/genome/ECemble/ECemble_Package/lib/jdk1.8.0_25/bin/java weka.classifiers.lazy.IBk -T $filename\_L2_EC$i\_sparse.arff -l ../../test/Level2/ssf_enz4_L2_IBK_new_EC$i\_sparse_train80.model -no-cv -p 1 -distribution &> $filename\_L2_IBK_EC$i.p");

	# Remove missclassified instances at EC Level-2 after consensus from TOP3 classifiers
	system("cat $filename\_L2_randomforest_EC$i.p |awk '/:/{print \$5\":\"\$3}'|sed 's/(//g'|sed 's/)//g'>$filename\_L2_randomforest_EC$i");
	system("cat $filename\_L2_SMO_EC$i.p |awk '/:/{print \$5\":\"\$3}'|sed 's/(//g'|sed 's/)//g'>$filename\_L2_SMO_EC$i");
	system("cat $filename\_L2_IBK_EC$i.p |awk '/:/{print \$5\":\"\$3}'|sed 's/(//g'|sed 's/)//g'>$filename\_L2_IBK_EC$i");

	# Consensus: correctly predicted by atleast 2 of the top3 methods
	system("paste $filename\_L2_randomforest_EC$i $filename\_L2_SMO_EC$i $filename\_L2_IBK_EC$i|awk -F\"\t\" '{if((\$1==\$2)||(\$2==\$3)||(\$1==\$3)) print \$0}'|tr '\t' '\n'|sort -n|uniq -c|awk -F\" \" '{if((\$1=='2')||(\$1=='3')) print \$2}'|grep -v '^\$'>$filename\_L2_EC$i\_atleast2");
	system("cat $filename\_L2_EC$i\_atleast2>>$filename\_L2_atleast2");
}
# Create EC prediction file for Level-2	
system("cat $filename\_L2_atleast2|awk -F\":\" '{print \$1 \"\t\" \$3}'>$filename\_L2_atleast2_ID");
system("awk -F\"\t\" 'FILENAME==\"$filename\_L2_atleast2_ID\"{a[\$1]=\$0} FILENAME==\"$filename\_ID\"{if(a[\$1]){print a[\$1] \"\t\" \$0}}' $filename\_L2_atleast2_ID $filename\_ID|awk -F\"\t\" '{print \$4\"\t\"\$2}'>$filename\_ID_L2.txt");

#################### END LEVEL-2 ####################



#################### START LEVEL-3 ####################
print "Generating EC Level-3 predictions.....<br>";
my @array = ([1,1],[1,10],[1,13],[1,14],[1,17],[1,18],[1,2],[1,3],[1,4],[1,5],[1,6],[1,7],[1,8],[2,1],[2,3],[2,4],[2,6],[2,7],[2,8],[3,1],[3,2],[3,4],[3,5],[3,6],[4,1],[4,2],[4,3],[5,1],[5,3],[5,4],[6,3]);
for (my $x = 0; $x <= $#array; $x++) {
   for (my $y = 1; $y <= $#{$array[$x]}; $y++) {
		my $i=$array[$x][0];
		my $j=$array[$x][$y];
		# Forward correctly predicted instances from EC Level-2 to EC Level-3
		system("cat $filename\_L2_EC$i\_atleast2|awk -F':' '{if((substr(\$3,3,1)==$i)&&(substr(\$3,5)==$j)) print \$1}'>$filename\_L3_EC$i.$j\_atleast2");
		system("awk -F\" \" 'FILENAME==\"$filename\_L2_EC$i.arff\"{a[\$1]=\$0} FILENAME==\"$filename\_L3_EC$i.$j\_atleast2\"{if(a[\$1]){print a[\$1]}}' $filename\_L2_EC$i.arff $filename\_L3_EC$i.$j\_atleast2> $filename\_L3I_EC$i.$j.arff");	
		system("cat ../../test/Level3/SSFPSPFENZHH_L3_EC$i.$j.arff $filename\_L3I_EC$i.$j.arff>$filename\_L3_EC$i.$j.arff");
		
		# Check if there are sequences to be predicted at EC Level-3
		# if(-z "$filename\_L3I_EC$i.$j.arff"){
			# print "Sequence can be predicted till EC Level-2 only<br><br>";
			# exit;
		# }
				
		#Sparse format for EC Level-3
		system("/usr/local/apache2/htdocs/genome/ECemble/ECemble_Package/lib/jdk1.8.0_25/bin/java weka.filters.unsupervised.instance.NonSparseToSparse -i $filename\_L3_EC$i.$j.arff -o $filename\_L3_EC$i.$j\_sparse.arff");
		
		#Predictions at EC Level-3 using RandomForest
		#Predictions at EC Level-3 using SMO
		#Predictions at EC Level-3 using IBk
		system("/usr/local/apache2/htdocs/genome/ECemble/ECemble_Package/lib/jdk1.8.0_25/bin/java weka.classifiers.trees.RandomForest -T $filename\_L3_EC$i.$j\_sparse.arff -l ../../test/Level3/SSFPSPFENZ_L3_randomforest_EC$i.$j\_sparse_train80.model -no-cv -p 1 -distribution &> $filename\_L3_randomforest_EC$i.$j.p");
		system("/usr/local/apache2/htdocs/genome/ECemble/ECemble_Package/lib/jdk1.8.0_25/bin/java weka.classifiers.functions.SMO -T $filename\_L3_EC$i.$j\_sparse.arff -l ../../test/Level3/SSFPSPFENZ_L3_SMO_EC$i.$j\_sparse_train80.model -no-cv -p 1 -distribution &>$filename\_L3_SMO_EC$i.$j.p");
		system("/usr/local/apache2/htdocs/genome/ECemble/ECemble_Package/lib/jdk1.8.0_25/bin/java weka.classifiers.lazy.IBk -T $filename\_L3_EC$i.$j\_sparse.arff -l ../../test/Level3/SSFPSPFENZ_L3_IBK_EC$i.$j\_sparse_train80.model -no-cv -p 1 -distribution &> $filename\_L3_IBK_EC$i.$j.p");

		# Remove missclassified instances at EC Level-3 after consensus from TOP3 classifiers
		system("cat $filename\_L3_randomforest_EC$i.$j.p|awk '/:/{print \$5\":\"\$3}'|sed 's/(//g'|sed 's/)//g'>$filename\_L3_randomforest_EC$i.$j");
		system("cat $filename\_L3_SMO_EC$i.$j.p|awk '/:/{print \$5\":\"\$3}'|sed 's/(//g'|sed 's/)//g'>$filename\_L3_SMO_EC$i.$j");
		system("cat $filename\_L3_IBK_EC$i.$j.p|awk '/:/{print \$5\":\"\$3}'|sed 's/(//g'|sed 's/)//g'>$filename\_L3_IBK_EC$i.$j");

		# Consensus: correctly predicted by atleast 2 of the top3 methods
		system("paste $filename\_L3_randomforest_EC$i.$j $filename\_L3_SMO_EC$i.$j $filename\_L3_IBK_EC$i.$j|awk -F\"\t\" '{if((\$1==\$2)||(\$2==\$3)||(\$1==\$3)) print \$0}'|tr '\t' '\n'|sort -n|uniq -c|awk -F\" \" '{if((\$1=='2')||(\$1=='3')) print \$2}'>$filename\_L3_EC$i.$j\_atleast2");
		system("cat $filename\_L3_EC$i.$j\_atleast2>>$filename\_L3_atleast2");
	}
}
# Create EC prediction file for Level-3
system("cat $filename\_L3_atleast2|awk -F\":\" '{print \$1 \"\t\" \$3}'>$filename\_L3_atleast2_ID");
system("awk -F\"\t\" 'FILENAME==\"$filename\_L3_atleast2_ID\"{a[\$1]=\$0} FILENAME==\"$filename\_ID\"{if(a[\$1]){print a[\$1] \"\t\" \$0}}' $filename\_L3_atleast2_ID $filename\_ID|awk -F\"\t\" '{print \$4\"\t\"\$2}'>$filename\_ID_L3.txt");

#################### END LEVEL-3 ####################





#################### START LEVEL-4 ####################
print "Generating EC Level-4 predictions.....<br>";
my @array = ([1,1,1],[1,13,11],[1,14,11],[1,14,13],[1,1,5],[1,17,1],[1,17,4],[1,18,1],[1,2,1],[1,3,1],[1,3,5],[1,4,1],[1,4,3],[1,5,1],[1,6,5],[1,6,99],[1,7,1],[1,8,1],[1,8,4],[2,1,1],[2,1,2],[2,1,3],[2,3,1],[2,3,2],[2,3,3],[2,4,1],[2,4,2],[2,6,1],[2,7,1],[2,7,10],[2,7,11],[2,7,2],[2,7,4],[2,7,6],[2,7,7],[2,7,8],[2,8,1],[3,1,1],[3,1,11],[3,1,2],[3,1,21],[3,1,26],[3,1,27],[3,1,3],[3,1,4],[3,2,1],[3,2,2],[3,4,11],[3,4,19],[3,4,21],[3,4,22],[3,4,23],[3,4,24],[3,4,25],[3,5,1],[3,5,2],[3,5,3],[3,5,4],[3,6,1],[3,6,3],[3,6,4],[4,1,1],[4,1,2],[4,1,3],[4,1,99],[4,2,1],[4,2,2],[4,2,3],[4,2,99],[4,3,1],[4,3,2],[5,1,1],[5,1,3],[5,3,1],[5,3,3],[5,4,2],[5,4,99],[6,3,1],[6,3,2],[6,3,3],[6,3,4],[6,3,5]);
for (my $x = 0; $x <= $#array; $x++) {
	my $i=$array[$x][0];
	my $j=$array[$x][1];
	my $k=$array[$x][2];
	
	# Forward correctly predicted instances from EC Level-3 to EC Level-4
	system("cat $filename\_L3_EC$i.$j\_atleast2|tr ':' '.'|awk -F'.' '{if((substr(\$3,3,1)==$i)&&(\$4)==$j&&(\$5)==$k) print \$1}'>$filename\_L4_EC$i.$j.$k\_atleast2");		
	system("awk -F\" \" 'FILENAME==\"$filename\_L3_EC$i.$j.arff\"{a[\$1]=\$0} FILENAME==\"$filename\_L4_EC$i.$j.$k\_atleast2\"{if(a[\$1]){print a[\$1]}}' $filename\_L3_EC$i.$j.arff $filename\_L4_EC$i.$j.$k\_atleast2> $filename\_L4I_EC$i.$j.$k.arff");	
	system("cat ../../test/Level4/SSFPSPFENZHH_L4_EC$i.$j.$k.arff $filename\_L4I_EC$i.$j.$k.arff>$filename\_L4_EC$i.$j.$k.arff");
	
	# Check if there are sequences to be predicted at EC Level-4
	# if(-z "$filename\_L4I_EC$i.$j.$k.arff"){
		# print "Sequence can be predicted till EC Level-3 only<br><br>";
		# exit;
	# }
		
	#Sparse format for EC Level-4
	system("/usr/local/apache2/htdocs/genome/ECemble/ECemble_Package/lib/jdk1.8.0_25/bin/java weka.filters.unsupervised.instance.NonSparseToSparse -i $filename\_L4_EC$i.$j.$k.arff -o $filename\_L4_EC$i.$j.$k\_sparse.arff");
	
	#Predictions at EC Level-4 using RandomForest
	#Predictions at EC Level-4 using SMO
	#Predictions at EC Level-4 using IBk
	system("/usr/local/apache2/htdocs/genome/ECemble/ECemble_Package/lib/jdk1.8.0_25/bin/java weka.classifiers.trees.RandomForest -T $filename\_L4_EC$i.$j.$k\_sparse.arff -l ../../test/Level4/SSFPSPFENZ_L4_randomforest_EC$i.$j.$k\_sparse_train80.model -no-cv -p 1 -distribution &> $filename\_L4_randomforest_EC$i.$j.$k.p");
	system("/usr/local/apache2/htdocs/genome/ECemble/ECemble_Package/lib/jdk1.8.0_25/bin/java weka.classifiers.functions.SMO -T $filename\_L4_EC$i.$j.$k\_sparse.arff -l ../../test/Level4/SSFPSPFENZ_L4_SMO_EC$i.$j.$k\_sparse_train80.model -no-cv -p 1 -distribution &>$filename\_L4_SMO_EC$i.$j.$k.p");
	system("/usr/local/apache2/htdocs/genome/ECemble/ECemble_Package/lib/jdk1.8.0_25/bin/java weka.classifiers.lazy.IBk -T $filename\_L4_EC$i.$j.$k\_sparse.arff -l ../../test/Level4/SSFPSPFENZ_L4_IBK_EC$i.$j.$k\_sparse_train80.model -no-cv -p 1 -distribution &> $filename\_L4_IBK_EC$i.$j.$k.p");	
	
	# Remove missclassified instances at EC Level-4 after consensus from TOP3 classifiers
	system("cat $filename\_L4_randomforest_EC$i.$j.$k.p|awk '/:/{print \$5\":\"\$3}'|sed 's/(//g'|sed 's/)//g'>$filename\_L4_randomforest_EC$i.$j.$k");
	system("cat $filename\_L4_SMO_EC$i.$j.$k.p|awk '/:/{print \$5\":\"\$3}'|sed 's/(//g'|sed 's/)//g'>$filename\_L4_SMO_EC$i.$j.$k");
	system("cat $filename\_L4_IBK_EC$i.$j.$k.p|awk '/:/{print \$5\":\"\$3}'|sed 's/(//g'|sed 's/)//g'>$filename\_L4_IBK_EC$i.$j.$k");
		
	# Consensus: correctly predicted by atleast 2 of the top3 methods (if doesnt work move out of the loop and put in a new loop)
	system("paste $filename\_L4_randomforest_EC$i.$j.$k $filename\_L4_SMO_EC$i.$j.$k $filename\_L4_IBK_EC$i.$j.$k|awk -F\"\t\" '{if((\$1==\$2)||(\$2==\$3)||(\$1==\$3)) print \$0}'|tr '\t' '\n'|sort -n|uniq -c|awk -F\" \" '{if((\$1=='2')||(\$1=='3')) print \$2}'>$filename\_L4_EC$i.$j.$k\_atleast2");
	system("cat $filename\_L4_EC$i.$j.$k\_atleast2>>$filename\_L4_atleast2");
	
	}
# Create EC prediction file for Level-4	
system("cat $filename\_L4_atleast2|awk -F\":\" '{print \$1 \"\t\" \$3}'>$filename\_L4_atleast2_ID");
system("awk -F\"\t\" 'FILENAME==\"$filename\_L4_atleast2_ID\"{a[\$1]=\$0} FILENAME==\"$filename\_ID\"{if(a[\$1]){print a[\$1] \"\t\" \$0}}' $filename\_L4_atleast2_ID $filename\_ID|awk -F\"\t\" '{print \$4\"\t\"\$2}'>$filename\_ID_L4.txt");

#################### END LEVEL-4 ####################





# Display EC prediction results for all levels
system("cat $filename\_ID_L* |sort|uniq>$filename\_ID_all.txt");
open(my $fh, '<:encoding(UTF-8)', "$filename\_ID_all.txt");
my @shortFilename = split '\/', "$filename\_ID_all.txt";
print "<table style=\"width: 100%; border-collapse: collapse;\" border=\"1\" cellspacing=\"0\" cellpadding=\"5\">";
print "<tr style=\"color: #fff\"><td colspan=\"7\"><a href=\"http://genome.unmc.edu/ECemble/temp/$shortFilename[8]\" target=\"_blank\">Download all predictions</a></td></tr>";
print "<tr style=\"color: #fff\" bgcolor=\"#799DD1\"><td align=\"center\"><b>Input Sequence</b></td><td align=\"center\"><b>EC Prediction</b></td></tr>";
while(my $row = <$fh>){
	chomp $row;
	print "<tr bgcolor=\"#F1F1F1\">";
	my @cells= split '\t', $row; 
	foreach my $cell (@cells){
		print "<td align=\"center\">$cell</td>";
	}
	print "</tr>";
}
print "</table><br><br>";

