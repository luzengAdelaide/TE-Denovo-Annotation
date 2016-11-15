#!/usr/bin/perl -w
use strict;

my ($file)=@ARGV;
open(IN,"$file");

while(<IN>){
    my @data = split(" ",$_);
    print "$data[0]\t$data[1]\t$data[2]\t$data[3]\t$data[4]\t$data[5]\t$data[6]\t$data[7]\t$data[8]\t$data[9]\t$data[10]\n";
}
