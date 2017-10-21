mkdir PFAM PROSITE SUPERFAMILY WEKA

#::PFAM::
#Execute all the commands from ECemble/bin
wget ftp://ftp.ebi.ac.uk/pub/databases/Pfam/releases/Pfam26.0/Pfam-A.hmm.gz
gunzip Pfam-A.hmm.gz
mv Pfam-A.hmm ../lib/PFAM

#::HAMMER::
wget ftp://selab.janelia.org/pub/software/hmmer3/3.1b1/hmmer-3.1b1-linux-intel-x86_64.tar.gz
tar zxf hmmer-3.1b1-linux-intel-x86_64.tar.gz
rm hmmer-3.1b1-linux-intel-x86_64.tar.gz
mv hmmer-3.1b1-linux-intel-x86_64 ../lib/hmmer
cd ../lib/hmmer
./configure
make 
make check
./src/hmmpress ../PFAM/Pfam-A.hmm

#::PROSITE::
cd ../../bin
wget ftp://ftp.expasy.org/databases/prosite/ps_scan/ps_scan_linux_x86_elf.tar.gz
tar zxf ps_scan_linux_x86_elf.tar.gz
rm ps_scan_linux_x86_elf.tar.gz
mv ps_scan ../lib/ps_scan
#Download prosite.dat database
wget ftp://ftp.expasy.org/databases/prosite/prosite.dat
mv prosite.dat ../lib/PROSITE

#::SCOP:: 
cd ../lib/SUPERFAMILY/
ftp supfam.org
username: license
password: SlithyToves
cd models
get model.tab.gz
get hmmlib_1.75.gz
get self_hits.tab.gz
cd ../sequences
get pdbj95d.gz
cd ../scripts
mget *
bye

wget http://scop.mrc-lmb.cam.ac.uk/scop/parse/dir.des.scop.txt_1.75
wget http://scop.mrc-lmb.cam.ac.uk/scop/parse/dir.cla.scop.txt_1.75
mv dir.des.scop.txt_1.75 dir.des.scop.txt
mv dir.cla.scop.txt_1.75 dir.cla.scop.txt

gunzip pdbj95d.gz
gunzip model.tab.gz
gunzip hmmlib_1.75.gz
mv hmmlib_1.75 hmmlib
gunzip self_hits.tab.gz
chmod u+x *.pl
.././hmmer/src/hmmpress hmmlib

#Change the paths in ass3.pl, line 13-16
my $selfhits = "./../lib/SUPERFAMILY/self_hits.tab";
my $clafile      = "./../lib/SUPERFAMILY/dir.cla.scop.txt";
my $modeltab     = "./../lib/SUPERFAMILY/model.tab";
my $pdbj95d      = "./../lib/SUPERFAMILY/pdbj95d";
#Make changes in superfamily.pl
line 20	system "perl ../lib/SUPERFAMILY/fasta_checker.pl $ARGV[0] >../test/scratch/$file\_torun.fa";
line 24 system "../lib/hmmer/src/hmmscan -o ../test/scratch/$file.res -E 1e-04 -Z 15438 ../lib/SUPERFAMILY/hmmlib ../test/scratch/$file\_torun.fa";
line 28 system "perl ../lib/SUPERFAMILY/ass3.pl -t n -f 40 -e 0.0001 ../test/scratch/$file\_torun.fa ../test/scratch/$file.res ../test/scratch/$file.ass ";
#comment lines
line 31 print "Running ass_to_html\n";
line 32 system "ass_to_html.pl dir.des.scop.txt model.tab $file.ass > $file.html";

#FOR GOLGI
#Change the paths in ass3.pl, line 13-16
my $selfhits = "/usr/local/apache2/htdocs/genome/ECemble/ECemble_Package/lib/SUPERFAMILY/self_hits.tab";
my $clafile      = "/usr/local/apache2/htdocs/genome/ECemble/ECemble_Package/lib/SUPERFAMILY/dir.cla.scop.txt";
my $modeltab     = "/usr/local/apache2/htdocs/genome/ECemble/ECemble_Package/lib/SUPERFAMILY/model.tab";
my $pdbj95d      = "/usr/local/apache2/htdocs/genome/ECemble/ECemble_Package/lib/SUPERFAMILY/pdbj95d";
#Make changes in superfamily.pl
line 20	system "perl ../lib/SUPERFAMILY/fasta_checker.pl $ARGV[0] >../test/scratch/$ARGV[0]\_torun.fa";
line 24 system "../lib/hmmer/src/hmmscan -o ../test/scratch/$ARGV[0].res -E 1e-04 -Z 15438 ../lib/SUPERFAMILY/hmmlib ../test/scratch/$ARGV[0]\_torun.fa";
line 28 system "perl ../lib/SUPERFAMILY/ass3.pl -t n -f 40 -e 0.0001 ../test/scratch/$ARGV[0]\_torun.fa ../test/scratch/$ARGV[0].res ../test/scratch/$ARGV[0].ass ";
#comment lines
line 31 print "Running ass_to_html\n";
line 32 system "ass_to_html.pl dir.des.scop.txt model.tab $file.ass > $file.html";


# WEKA
wget http://prdownloads.sourceforge.net/weka/weka-3-7-6.zip
unzip weka-3-7-6.zip
mv weka-3-7-6 ../lib/
rm weka-3-7-6.zip
cd ../lib/weka-3-7-6
jar -xvf weka.jar
jar -xvf weka-src.jar
#set classpath

# UpdateWeka

1) Acquire weka-src.jar (this should just be in the directory where you install weka).

2) Make a working directory which will house your modified version of weka (dist/ folder)

3) Unzip weka-src.jar into this working directory (simply unzip weka-src.jar)

5) Write your class or make changes to existing weka classes

7) Make the executable jar by running “ant exejar”

8) Check out the dist/ folder for your hot new weka.jar (which should have your new classes in it!)

# .bash_profile
ANT_HOME=/storage_m/akram/akram/ECemble/lib/apache-ant-1.9.4
export ANT_HOME

CLASSPATH=/storage_m/akram/akram/ECemble/lib/apache-ant-1.9.4/lib
export CLASSPATH

PATH=$PATH:$HOME/bin:/storage_m/akram/akram/ECemble/lib/apache-ant-1.9.4/bin
export PATH

#execute at ANT_HOME
export ANT_OPTS=-Dbuild.sysclasspath=ignore
ant -f fetch.xml -Ddest=system
chmod u+x /storage_m/akram/akram/ECemble/lib/apache-ant-1.9.4/bin/ant

mkdir dist 
cp weka-src.jar dist/
cd dist
jar -xf weka-src.jar

#add whatever java classifier in src/main directory
/ECemble/lib/weka-3-7-6/dist/src/main/java/weka/classifiers/evaluation/output/prediction/PlainText.java
Change line 154 to int width = 12 + m_NumDecimals;

ant compile
ant exejar #creates dist/weka.jar
cp -r * ../
cd ../
jar -xf weka.jar






