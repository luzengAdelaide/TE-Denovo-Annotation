#!/bin/bash

# calculate the length of fasta files, and report a summarised output in the last line in each file

for i in part*.fa;

do
    awk '/^>/ {if (seqlen){print seqlen};print;seqtotal+=seqlen;seqlen=0;seq+=1;next;}{seqlen=seqlen+length($0)}END{print seqlen;print seq" sequences, total length " seqtotal+seqlen}' $i > length_$i

# Different output format, seqlen and seqid were separated by space
#awk '/^>/ {if (seqs_id){print seqs_id, seqlen}; seqs_id=substr($1,2); seqlen=0}/^[^>]/{ seqlen += length($0)}END{print seqs_id, seqlen}' $i
done
# sort the second column 
sort -nk2,2 files > sorted_files

# grep the last line from length files, and acquire the total gene length

for i in length_*;

do 
    echo $i    
    echo -n "last line: "
    grep -v '^\s*$' "$i" | tail -n1  > $i\_num
#    grep PATHRN $i | tail -1 > test    
done

# acquire the totla bp 
cat *_num > pogona_gene_length
awk '{total += $5} END {print "Total:", total, "bp"}' pogona_gene_length
rm *_num

