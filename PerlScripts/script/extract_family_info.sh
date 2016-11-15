#!/usr/bin/perl -w
use strict;

# This script is to separate library into repeats and partial annotated
# or change the partial to \# 

my ($file)=@ARGV;
open(IN,"$file");
my (@single);

$/=">";
while(<IN>){
    chomp;   
    $_=~s/>//;
    next if ($_ eq "");
    @single = split("\n",$_,2);
    if ($single[0] =~ /(family[\w]+)\_/){
	print $1.".mfa", "\n";
    }
}
