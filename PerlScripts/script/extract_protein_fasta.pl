#!/usr/bin/perl -w
use strict;

my ($file1,$file2) = @ARGV;
open(INA,"$file1");
open(INB,"$file2");
my (%hash);
my ($gid,$gid2,@data,$tmp,@single,$id,$seq);


# read protein.txt file, extract the first column
while (<INA>) {
    @data = split(" ",$_);
    $gid = $data[0];
    $hash{$gid} = $_;
#    print "$gid", "\n";
}

# Read consensus sequences fasta file, delete the > in title
$/=">";
while(<INB>) {
    chomp;
    $_=~s/>//;
    next if ($_ eq "");
    $tmp=$_;
    @single=split("\n",$tmp,2);
    $single[0]=~/^([\w\_]+) \(/;
    $id=$1;
    print ">".$_ if exists $hash{"$id"};
#   $seq=$single[1];
#    $seq=~s/\n//g;
#    $hash_gene{$id}=$hash_gene{$id}.$seq;
#    print $hash2{$gid2},"\n";
}



close INA;
close INB;
