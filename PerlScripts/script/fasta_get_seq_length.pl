#!/usr/bin/perl -w
use strict;

my (%seqs, $id, $dna);
while (my $line = <>) {
    chomp $line;
    if ($line =~ / ^ > (.+) /x) {
        $seqs{$id} = $dna if defined $id;
        $id = $1;
        $dna = '';
    }
    else {
        $dna .= $line;
    }
}
$seqs{$id} = $dna if defined $id;

for my $key(keys %seqs){
    printf ">%s:%d\n", $key, length $seqs{$key};
#    printf ">%s:%d\n%s\n", $key, length $seqs{$key}, $seqs{$key};
}

#for my $key (sort { length $seqs{$a} <=>length $seqs{$b} } keys %seqs) {
#    printf ">%s:%d\n%s\n", $key, length $seqs{$key}, $seqs{$key};
#}
