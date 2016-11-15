#!/usr/bin/perl -w
use strict;

my ($file) = @ARGV;
open(IN,"$file");
my $n=0;

while(<IN>){
    chomp;
    $n++;
#    if (/^[\w+]\t[\w+]\t[\w+]\t[0-9]+\t[0-9]+\t[\.]\t[+-]\t[\.]\t/) {
    if (/^([\w]+\t[\w]+\t[\w]+\t[\w]+\t[\w]+\t[\.]\t[+-]\t[\.])\t[\w\=]+(Pvit\_[\w]+)\;/) {
	print "$1\tgene\_id \"$2\"; transcript\_id \"$2\"\;\n";
    }
    else {
	die ("do not match at line $n\n");
    }
}
