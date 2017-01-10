#!/bin/bash

for i in *.map;
do
    echo $i > test.txt
    wc -l $i > line.txt
    awk '{len+=$3-$2+1}{print len}' $i|tail -1 > test2.txt
    awk '{len+=$3-$2+1}{print (len/1816116151)*100}' $i|tail -1 > test3.txt
    paste test.txt line.txt test2.txt test3.txt >> repeat_constitution2.txt
done

rm test.txt
rm line.txt
rm test2.txt
rm test3.txt
