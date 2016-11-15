#!/usr/bin/perl -w

use strict;
my $dataDir = "./";
my $ECrit = 0.00001;

print "Enter name of file listing libraries to process: ";
my $libs = <STDIN>;

open (INFILE, "$libs") || die "You dope, no input file by that name, try again...";
 
while (<INFILE>) {
  chomp;
#  system ("/usr/local/genome/wublast/blastx /export/genome/data/sprot $dataDir$_  -gspmax=1 -E $ECrit -B 1 -V 1 -cpus=4 > $_.spwb");
 # system ("python /usr/local/genome/bin/wublastx2gff.py $_.spwb > $_.spwb.gff");
 # system ("python /usr/local/genome/bin/gff_pretty.py $_.spwb.gff > $_.spwb.txt");
 # system ("/usr/local/genome/bin/piler -annot $_.gff -rep $_.spwb.gff -out $_.spwbannot.gff");
 # system ("python /usr/local/genome/bin/gff_pretty.py $_.spwbannot.gff > $_.spwbannot.txt");

  system ("/usr/local/genome/wublast/blastx /export/genome/data/BlastDB/GB_TE $dataDir$_ -gspmax=1 -E $ECrit -B 1 -V 1 -cpus=4 > $_.tewb");
  system ("python /usr/local/genome/bin/wublastx2gff.py $_.tewb > $_.tewb.gff");
  system ("python /usr/local/genome/bin/gff_pretty.py $_.tewb.gff > $_.tewb.txt");
  system ("/usr/local/genome/bin/piler -annot $dataDir$_.gff -rep $_.tewb.gff -out $_.tewbannot.gff");
  system ("python /usr/local/genome/bin/gff_pretty.py $_.tewbannot.gff > $_.tewbannot.txt");

  system ("/usr/local/genome/wublast/tblastx /export/genome/data/BlastDB/all_retrovirus.fasta $dataDir$_ -gspmax=1 -E $ECrit -B 1 -V 1 -cpus=4 > $_.ervwb");
  system ("python /usr/local/genome/bin/wublastx2gff.py $_.ervwb > $_.ervwb.gff");
  system ("python /usr/local/genome/bin/gff_pretty.py $_.ervwb.gff > $_.ervwb.txt");
  system ("/usr/local/genome/bin/piler -annot $dataDir$_.gff -rep $_.ervwb.gff -out $_.ervwbannot.gff");
  system ("python /usr/local/genome/bin/gff_pretty.py $_.ervwbannot.gff > $_.ervwbannot.txt");

  chdir ("..");
	}
