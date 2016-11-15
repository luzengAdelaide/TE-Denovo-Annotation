#! /usr/bin/perl -w
use strict; 
my $pad = 0;  

# delete the sequence that is less than 1kb from consensus sequences *_opossum.fa, before running uclust
### for LINEs, no more sequence lower than 1kb, for sines, no more sequence lower than 50bp

my ($file) = @ARGV;
open(IN, $file) or die "can't open file $file:$!\n";
my $ch = '';
my $seq;
my $seq_name;
my %gs;
my $bin =0; 
my %hash;
my $head;
my $seq2;
my $head2;
my ($chr,$start,$end,$sym,$gid);
my $out1 = "short.".$file;
my $out2 = "1000bp.".$file;
my $out3 = "2000bp.".$file;
my $out4 = "3000bp.".$file;
my $out5 = "4000bp.".$file;
my $out6 = "5000bp.".$file;
open(OUTA,">$out1");
open(OUTB,">$out2");
open(OUTC,">$out3");
open(OUTD,">$out4");
open(OUTE,">$out5");
open(OUTF,">$out6");

$/=">";
while (<IN>){
    chomp;
    next if ($_ eq "");
    my @tmp = split("\n",$_,2);
    $head = $tmp[0];
    $head =~s/\>//;
    $seq2 = $tmp[1];
#    $seq2 =~s/\n//g;
    print OUTA "\>$_", if length($seq2) < 1000;
    print OUTB "\>$_", if length($seq2) >1000 && length($seq2) < 2000;
    print OUTC "\>$_", if length($seq2) >2000 && length($seq2) < 3000;
    print OUTD "\>$_", if length($seq2) >3000 && length($seq2) < 4000;
    print OUTE "\>$_", if length($seq2) >4000 && length($seq2) < 5000;
    print OUTF "\>$_", if length($seq2) > 5000;
}

close IN;
