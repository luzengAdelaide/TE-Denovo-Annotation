#!/usr/bin/perl -w
use strict;

my ($file)=@ARGV;
open(IN,"$file");

while(<IN>){
    my @data = split(" ",$_);
    print "$data[0]\t$data[3]\t$data[4]\t$data[2] $data[8]\t0\t$data[6]\n";    
}
