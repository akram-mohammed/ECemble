#!/usr/bin/perl -w

# Written by Akram Mohammed

use CGI::Carp qw(warningsToBrowser fatalsToBrowser);
use Cwd;
use strict;
use warnings;

my $op = $ARGV[0];
my $bin = "/usr/local/apache2/htdocs/genome/ECemble/ECemble_Package/bin";
my $temp = "/usr/local/apache2/htdocs/genome/ECemble/temp";

chdir ("/usr/local/apache2/htdocs/genome/ECemble/temp") or die "cannot change: $!\n";

print "Extracting PFam, Superfamily domains and ProSite motifs ......<br>";

for (my $i=1; $i<=10; $i++){

system("cp $op.$i.fasta $op$i");

#Map Test sequences to Pfam domains
system("../ECemble_Package/lib/hmmer/src/hmmscan -o $op\_$i.stdout --cut_ga --tblout $op\_$i.tblout -Z 13672 ../ECemble_Package/lib/PFAM/Pfam-A.hmm $op.$i.fasta");

#Map Test sequences to prosite domains
system("perl ../ECemble_Package/lib/ps_scan/ps_scan.pl -d ../ECemble_Package/lib/PROSITE/Prosite -r $op.$i.fasta>$op\_$i.ps");

# Map Test sequences to superfamily domains
system("nohup perl /usr/local/apache2/htdocs/genome/ECemble/ECemble_Package/lib/SUPERFAMILY/superfamily.pl $op$i");

#system("sh $bin/pfam_ps_ssfFeature.sh $op &");

}
