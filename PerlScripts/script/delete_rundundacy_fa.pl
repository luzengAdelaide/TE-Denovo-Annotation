#!/usr/bin/perl
use strict;
use warnings;

################################################################
# used for delete rundancy fasta sequence in file (same title) #
################################################################

my ($file)=@ARGV;
open(IN,"$file");
my (%id2seq, %seen);
my ($key, $duplicate);
while(<IN>) {
    chomp;
    if($_ =~ /^>(.+)/){
        $key = $1;
        if (exists $seen{$key}) {
            print STDERR "Attention: header $key duplicated.\n";
            $duplicate  = 1;
        } else {
            $seen{$key} = 1;
            $duplicate  = 0;
        }
    } else {
        ($duplicate == 1) ? (next) : ($id2seq{$key} .= $_);
    }
}

foreach(keys %id2seq) {
    print join("\n",">".$_,$id2seq{$_}),"\n";
}
