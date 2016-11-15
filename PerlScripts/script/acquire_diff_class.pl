#!/usr/bin/perl -w
use strict;

# grep ">" tuatara > title_tuatara
# use 1step, then get _no/underscore
# use 2 step, then get two files, cat them into diff_class

my($gtf)=@ARGV;
open(IN,"$gtf");
my %hash;
my $class;

#2 step: use hash to get different repeat class
while(<IN>){
#    if (/^\>family[\w\_]+\:(\w+)\-/) {
    if (/^\>family[\w\_]+\:(\w+)\_/) {
	$class = $1;
	print $_ unless exists $hash{"$class"};
	$hash{$class}=1;
    }
}

#1 step: separate title_repeat into \- or not \-
#my ($out1) = $gtf."_underscore";
#my ($out2) = $gtf."_no";
#open(OUTA, ">$out1");
#open(OUTB, ">$out2");

=cut;
while(<IN>){
#    if (/\>family[\w\_]+\:[\w+]\-/) {
    if (/\>family[\w\_]+\:\w+\-/) {
	print OUTA $_;   
    }
    else {
	print OUTB $_;
    }
}
close IN;
=cut;
