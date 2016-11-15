#!/usr/bin/perl -w
use strict;

my($file)=@ARGV;
open(IN,"$file");

$/=">";
while(<IN>){
    chomp;   
    @single = split("\n",$_,2);
    if ($single[0] =~ /family[\w\_]+\:L2/){
	print  ">".$single[0]."\n".$single[1];
    }
}
