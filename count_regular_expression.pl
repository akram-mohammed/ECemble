#! /usr/bin/perl
use strict;
use warnings;
my $num1=0;
my $num2=0;
my $num3=0;
# get $input from some place
my $str = "GGGx{5}KNRRx{7}RGGRN";
#my $ft_count = ()= $str =~ m/[a-zA-Z]/g;

my $count = ()= $str =~ m/(\d+)/g;
# while ($str =~ m/(\d+)/g) { 
	$num1 = $1;
	print "Number is $num1\n";
	# $num2=$num1+$num1;
	# print "Add are $num2\n";
	# }
	# print "count $num2\n";

#print "$ft_count\n";
print "$count\n";
#$count++
