#! /usr/bin/perl                                                                                                             
## merge exons from same gene name
                                              
open(IN,$ARGV[0]);
#open(OUT,">".$ARGV[1]);

$/=">";
while(<IN>){
#    chomp;
    $_=~s/>//;
    next if ($_ eq "");
    $tmp=$_;
    @single=split("\n",$tmp,2);
#    $id = $single[0];
    $single[0] =~ s/\s+/\*/g;
    print ">".$single[0]."\n".$single[1];
}

close IN;
close OUT;
