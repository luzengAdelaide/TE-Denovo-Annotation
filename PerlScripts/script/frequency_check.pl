#!/usr/bin/perl -w
use strict;

my($file)=@ARGV;
open(IN,"$file");
my %wordCount;
my @words;

my %count_of;
while (<IN>) { #read from file or STDIN
    my @data = split(" ",$_);   
 foreach my $word ($data[3]) {
	$count_of{$word}++;
    }
}
#print "All words and their counts: \n";
for my $word (sort keys %count_of) {
    print "$word\t$count_of{$word}\n";
}
