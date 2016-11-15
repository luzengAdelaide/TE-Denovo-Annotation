#!/usr/bin/perl -w
use strict;

my ($file)=@ARGV;
open(IN,"$file");
my $i=0;
my ($begin, $end);

while (<IN>){
    chomp;
    s/\"//g;
    s/\;/\t/g;
    my @data  = split("\t",$_);
    if ($data[6] eq '+'){
        $begin = $data[3]-1000;
        $end = $data[3]-1;
        print "$data[0]\tproximal_pro\t$begin\t$end\t$data[6]\t$data[9]\n";
    }
    if ($data[6] eq '-'){
        $begin = $data[4]+1000;
        $end = $data[4]+1;
        print "$data[0]\tproximal_pro\t$end\t$begin\t$data[6]\t$data[9]\n";
    }
}
close IN;
