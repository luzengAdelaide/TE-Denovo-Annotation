#!/usr/bin/perl 
# This script is to extract the sequences with copy number < 50 in de novo unknown library

my ($file1,$file2) = @ARGV;
open(INA,"$file1");
open(INB,"$file2");
my (%hash1,%hash2,%merge);
my ($gid,$gid2,@data,@tmp);


while (<INA>) {
    @data = split(" ",$_);
    $gid = $data[0];
    $hash1{$gid} = 1;
#    print "$gid", "\n";
#    print $hash1{$gid};
}

$/=">";
while(<INB>) {
    chomp;
    $_=~s/>//;
    next if ($_ eq "");
    $tmp=$_;
    @tmp=split("\n",$tmp,2);
    $tmp[0]=~/([\w\_]+\#Unclassified)/;
    $gid2 = $1;
    print ">".$_ if exists $hash1{"$gid2"};
}

close INA;
close INB;
