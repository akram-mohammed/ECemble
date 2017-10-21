#!/usr/bin/perl -w
use strict;
use warnings;

# Written by Akram Mohammed
# renameFile.pl
# This program renames the file to proteome_testseq

#ARGUEMENTS------------------------------------------
if ($#ARGV != 0){
print STDERR "-----------------------------------------------------
Please provide the input file name\n
Usage: renameFile.pl <input_file>
-----------------------------------------------------\n";
exit;
}

my $cmd;
my $new_file="../test/proteome_testseq";

open (INFILE, $ARGV[0])  || die "cannot open input file $ARGV[0]: $!";
$cmd = "cp ../test/$ARGV[0] $new_file";
if(system($cmd)) { print "rename failed\n"; }

# close the input and output files.
close INFILE;