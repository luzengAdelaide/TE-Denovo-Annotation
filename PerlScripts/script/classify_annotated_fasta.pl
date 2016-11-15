#!/usr/bin/perl -w
use strict;

# This script is to separate library into repeats and partial annotated
# or change the partial to \# 

my ($file)=@ARGV;
open(IN,"$file");
my $out1 = $file."_repeat";
my $out2 = $file."_notsure";
open(OUTA,">$out1");
open(OUTB,">$out2");
my (@single);

$/=">";
while(<IN>){
    chomp;   
    $_=~s/>//;
    next if ($_ eq "");
    @single = split("\n",$_,2);
    if ($single[0] =~ /family[\w\_]+\:/){
	print OUTA ">".$single[0]."\n".$single[1];
    }
    if ($single[0] =~ /family[\w\_]+\#/){
	print OUTB ">".$single[0]."\n".$single[1];
    }
}
