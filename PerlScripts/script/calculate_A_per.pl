#!/usr/bin/perl -w
use strict;
use warnings;

local $/ = '>';

while (<>) {
    chomp;
    /\S/ or next;
    my ( $id, $seq ) = /(.+?)\n(.+)/s;
    $seq =~ s/\n//g;

    my $Acount = $seq =~ tr/A//;
    printf "%s\t%.2f%%\n", ">$id", ( $Acount / length $seq ) * 100;
}
