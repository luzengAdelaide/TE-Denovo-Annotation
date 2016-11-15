#!/usr/bin/perl -w
use strict;

my $partsize = 203 * 1024 * 1024;

my $file = shift or die 'no file';

open my $in, '<', $file or die "Can't open '$file' for reading: $!";

my $part = 1;
my $size = 0;
open my $out, '>', "part$part.$file" 
    or die "Can't open 'part$part.$file' for writing: $!";
$/=">";
while (<$in>) {
    print $out $_;
    $size += length $_;
    if ( $size >= $partsize ) {
        close $out;
        $part++;
        open $out, '>', "part$part.$file" 
	    or die "Can't open 'part$part.$file' for writing: $!";
        $size = 0;
    }
}


