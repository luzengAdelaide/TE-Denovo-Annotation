#!/usr/bin/perl -w
use strict;

# Change fasta sequences with same headers with an extrac number

my ($file)=@ARGV;
open(IN,"$file");
my (@single);
my $i=0;

$/=">";
while(<IN>){
    chomp;   
    $_=~s/>//;
    next if ($_ eq "");
    $i++;   
    @single = split("\n",$_,2);
    print ">".$single[0]."\_".$i."\n".$single[1];
}
