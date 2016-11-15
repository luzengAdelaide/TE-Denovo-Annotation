#!/usr/bin/perl 


# delete space in Library, as censor will delete everything after space

my ($file)=@ARGV;
open(IN,$file);
my ($tmp,@single);

$/=">";
while(<IN>){
    chomp;
    @single = split("\n",$_,2);
    $single[0] =~ s/\s/\_/g;
#    print $single[0],"\n";
    print ">".$single[0]."\n".$single[1];
}
