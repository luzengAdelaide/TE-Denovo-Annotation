#!/usr/bin/perl 


my ($file1,$file2) = @ARGV;
open(INA,"$file1");
open(INB,"$file2");
my (%hash1,%hash2,%merge);
my ($gid,$gid2,@data,@tmp);


while (<INA>) {
    @data = split("\t",$_);
    $gid = $data[0];
    $hash1{$gid} = $hash1{$gid}.$_;
#    print "$gid", "\n";
#    print $hash1{$gid};
}

while(<INB>) {
#    chomp;
    @tmp = split("\t",$_);
    $gid2 = $tmp[0];
    $hash2{$gid2} = $hash2{$gid2}.$_;
#    print $hash2{$gid2},"\n";
}

foreach my $var (keys %hash2){
    print "$hash2{$var}\n$hash1{$var}";
}


close INA;
close INB;
