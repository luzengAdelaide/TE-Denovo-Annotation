#!/usr/bin/perl -w
use strict;

my($file)=@ARGV;
open(IN,"$file");

$/=">";
while(<IN>){
    chomp;   
    my @single = split("\n",$_,2);
    if ($single[0] =~ /family[\w\_]+\:L2/){
#    if ($single[0] =~ /family[\w\_]+\:CR1/){
        print  ">".$single[0]."\n".$single[1];
    }
    if ($single[0] =~ /family[\w\_]+\:CR1\-L2/) {
#    if ($single[0] =~ /family[\w\_]+\:PlatCR1/) {
	print  ">".$single[0]."\n".$single[1];
    }
}
