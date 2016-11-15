#!/usr/bin/perl -w
use strict;

my($file)=@ARGV;
open(IN,"$file");

$/=">";
while(<IN>){
    chomp;   
    my @single = split("\n",$_,2);
    if ($single[1] =~ /AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA/){
#    if ($single[0] =~ /family[\w\_]+\:CR1/){
        print  ">".$single[0]."\n".$single[1];
    }
}
