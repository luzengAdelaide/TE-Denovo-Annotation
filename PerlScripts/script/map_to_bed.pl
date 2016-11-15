#!/usr/bin/perl -w
use strict;

my ($file)=@ARGV;
open(IN,"$file");

while(<IN>){
    my @data = split(" ",$_);
    if ($data[6] eq 'd') {
	print "$data[0]\t$data[1]\t$data[2]\t$data[3]\t$data[7]\t+\t$data[11]\n";
    }
    if ($data[6] eq 'c') {
	print "$data[0]\t$data[1]\t$data[2]\t$data[3]\t$data[7]\t-\t$data[11]\n";
    }
}
