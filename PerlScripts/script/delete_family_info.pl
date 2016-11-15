#!/usr/bin/perl -w
use strict;

my ($file)=@ARGV;
open(IN,"$file");
my $n=0;
#my $out1 = $file."_known";
#my $out2 = $file."_unknown";
#my $out3 = $file."_censor";
#open(OUTA, ">$out1");
#open(OUTB, ">$out2");
#open(OUTC, ">$out3");

while(<IN>){
    chomp;
    my @data = split("\t",$_);
    if ($data[2] =~ /family[\w\-\_]+\:([\w\-\_]+)/){
	print "$data[0]\t$data[1]\t$1\t$data[3]\t$data[4]\t$data[5]\t$data[6]\t$data[7]\t$data[8]\n";
    }
    if ($data[2] =~ /family[\w\_\-]+\#([\w\-\_]+)/){
	print "$data[0]\t$data[1]\t$1\t$data[3]\t$data[4]\t$data[5]\t$data[6]\t$data[7]\t$data[8]\n";
    }
    unless ($data[2] =~ /family[\w\:\#\-\_]+/) {
	print  $_,"\n";
#	print OUTA $_,"\n";
    }
}
