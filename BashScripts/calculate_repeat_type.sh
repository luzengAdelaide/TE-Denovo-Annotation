#!/bin/bash

for i in *.repeat.map;
do
    echo $i > test.txt
    wc -l $i > count.txt
    awk '{len+=$3-$2+1}{print len}' $i|tail -1 > test2.txt
    awk '{len+=$3-$2+1}{print (len/3605631728)*100}' $i|tail -1 > test3.txt
    paste test.txt count.txt test2.txt test3.txt >> repeat_constitution2.txt
done
