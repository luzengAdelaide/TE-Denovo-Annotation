#!/bin/bash
#mkdir test

# this is used to change the opossum krishna output sequences names

arr=( 'part1' 'part2' 'part3' 'part4' 'part5' )
arr1=( 'chr1' 'chr2' 'chr3' 'chr4' 'chr5' 'chr6' 'chr8' )
arr2=( 'part1.chr1' 'part1.chr2' 'part1.chr3' 'part1.chr4' 'part1.chr5' 'part1.chr6' 'part1.chr8' 'part2.chr1' 'part2.chr2' 'part2.chr3' 'part2.chr4' 'part2.chr5' 'part2.chr6' 'part2.chr8' 'part3.chr1' 'part3.chr2' 'part3.chr3' 'part3.chr4' 'part3.chr8' 'part4.chr1' 'part4.chr2' 'part4.chr3' 'part5.chr1' )

#for j in "${arr[@]}"
#do
#    for i in "${arr1[@]}"
#    do 
#	echo $j.$i
#	sed 's/'$i'/'$j.$i'/g' chr7_$j.$i.gff > correct/chr7_$j.$i.gff  
#	sed 's/'$i'/'$j.$i'/g' chrMT_$j.$i.gff > correct/chrMT_$j.$i.gff  
#	sed 's/'$i'/'$j.$i'/g' chrUn_$j.$i.gff > correct/chrUn_$j.$i.gff  
#	sed 's/'$i'/'$j.$i'/g' chrX_$j.$i.gff > correct/chrX_$j.$i.gff  
#	sed 's/'$i'/'$j.$i'/g' $j.$i.gff > correct/$j.$i.gff
#    done
#done
#
#for j in "${arr[@]}"
#do
#    for i in "${arr1[@]}"
#    do
#	for m in "${arr2[@]}"
#	do
#	    echo $i $j
##	    sed 's/'$i'/'$j.$i'/g' $m\_$j.$i.gff > test/$m\_$j.$i.gff
#	    cd test/
#	    sed 's/'$i'/'$j.$i'/g' $j.$i\_$m.gff > test3/$j.$i\_$m.gff
#	done
#    done
#done
#    

sed 's/Target part2.chr1/Target part1.chr1/g' part1.chr1_part2.chr1.gff > test3/part1.chr1_part2.chr1.gff
sed 's/Target part3.chr1/Target part1.chr1/g' part1.chr1_part3.chr1.gff > test3/part1.chr1_part3.chr1.gff
sed 's/Target part4.chr1/Target part1.chr1/g' part1.chr1_part4.chr1.gff > test3/part1.chr1_part4.chr1.gff
sed 's/Target part5.chr1/Target part1.chr1/g' part1.chr1_part5.chr1.gff > test3/part1.chr1_part5.chr1.gff
sed 's/Target part2.chr2/Target part1.chr2/g' part1.chr2_part2.chr2.gff > test3/part1.chr2_part2.chr2.gff
sed 's/Target part3.chr2/Target part1.chr2/g' part1.chr2_part3.chr2.gff > test3/part1.chr2_part3.chr2.gff
sed 's/Target part4.chr2/Target part1.chr2/g' part1.chr2_part4.chr2.gff > test3/part1.chr2_part4.chr2.gff
sed 's/Target part2.chr3/Target part1.chr3/g' part1.chr3_part2.chr3.gff > test3/part1.chr3_part2.chr3.gff
sed 's/Target part3.chr3/Target part1.chr3/g' part1.chr3_part3.chr3.gff > test3/part1.chr3_part3.chr3.gff
sed 's/Target part4.chr3/Target part1.chr3/g' part1.chr3_part4.chr3.gff > test3/part1.chr3_part4.chr3.gff
sed 's/Target part2.chr4/Target part1.chr4/g' part1.chr4_part2.chr4.gff > test3/part1.chr4_part2.chr4.gff
sed 's/Target part3.chr4/Target part1.chr4/g' part1.chr4_part3.chr4.gff > test3/part1.chr4_part3.chr4.gff
sed 's/Target part2.chr5/Target part1.chr5/g' part1.chr5_part2.chr5.gff > test3/part1.chr5_part2.chr5.gff
sed 's/Target part2.chr6/Target part1.chr6/g' part1.chr6_part2.chr6.gff > test3/part1.chr6_part2.chr6.gff
sed 's/Target part2.chr8/Target part1.chr8/g' part1.chr8_part2.chr8.gff > test3/part1.chr8_part2.chr8.gff
sed 's/Target part3.chr8/Target part1.chr8/g' part1.chr8_part3.chr8.gff > test3/part1.chr8_part3.chr8.gff
sed 's/Target part3.chr1/Target part2.chr1/g' part2.chr1_part3.chr1.gff > test3/part2.chr1_part3.chr1.gff
sed 's/Target part4.chr1/Target part2.chr1/g' part2.chr1_part4.chr1.gff > test3/part2.chr1_part4.chr1.gff
sed 's/Target part5.chr1/Target part2.chr1/g' part2.chr1_part5.chr1.gff > test3/part2.chr1_part5.chr1.gff
sed 's/Target part3.chr2/Target part2.chr2/g' part2.chr2_part3.chr2.gff > test3/part2.chr2_part3.chr2.gff
sed 's/Target part4.chr2/Target part2.chr2/g' part2.chr2_part4.chr2.gff > test3/part2.chr2_part4.chr2.gff
sed 's/Target part3.chr3/Target part2.chr3/g' part2.chr3_part3.chr3.gff > test3/part2.chr3_part3.chr3.gff
sed 's/Target part4.chr3/Target part2.chr3/g' part2.chr3_part4.chr3.gff > test3/part2.chr3_part4.chr3.gff
sed 's/Target part3.chr4/Target part2.chr4/g' part2.chr4_part3.chr4.gff > test3/part2.chr4_part3.chr4.gff
sed 's/Target part3.chr8/Target part2.chr8/g' part2.chr8_part3.chr8.gff > test3/part2.chr8_part3.chr8.gff
sed 's/Target part4.chr1/Target part3.chr1/g' part3.chr1_part4.chr1.gff > test3/part3.chr1_part4.chr1.gff
sed 's/Target part5.chr1/Target part3.chr1/g' part3.chr1_part5.chr1.gff > test3/part3.chr1_part5.chr1.gff
sed 's/Target part4.chr2/Target part3.chr2/g' part3.chr2_part4.chr2.gff > test3/part3.chr2_part4.chr2.gff
sed 's/Target part4.chr3/Target part3.chr3/g' part3.chr3_part4.chr3.gff > test3/part3.chr3_part4.chr3.gff
sed 's/Target part5.chr1/Target part4.chr1/g' part4.chr1_part5.chr1.gff > test3/part4.chr1_part5.chr1.gff
