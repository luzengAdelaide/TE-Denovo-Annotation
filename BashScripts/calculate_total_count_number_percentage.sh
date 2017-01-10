#!/usr/bin/bash

cd /home/a1635743/tuatara/censor_repeat/output_analysis/repeat.map/DNA
#cat *.repeat.map > DNA.total.map
#echo 'DNA.total.map' > name.txt
#wc -l DNA.total.map > count.txt
#awk '{len+=$3-$2+1}{print (len/4271823035)*100}' DNA.total.map |tail -1 > total.len.txt
#paste name.txt count.txt total.len.txt >> summary_DNA.txt
mv summary_DNA.txt ../

cd /home/a1635743/tuatara/censor_repeat/output_analysis/repeat.map/LINE
#cat *.repeat.map > LINE.total.map 
#echo 'LINE.total.map' >name.txt
#wc -l LINE.total.map > count.txt
#awk '{len+=$3-$2+1}{print (len/4271823035)*100}' LINE.total.map |tail -1 > total.len.txt
#paste name.txt count.txt total.len.txt >> summary_LINE.txt
mv summary_LINE.txt ../

cd /home/a1635743/tuatara/censor_repeat/output_analysis/repeat.map/LTR
#cat *.repeat.map > LTR.total.map 
#echo 'LTR.total.map' >name.txt
#wc -l LTR.total.map > count.txt
#awk '{len+=$3-$2+1}{print (len/4271823035)*100}' LTR.total.map |tail -1 > total.len.txt
#paste name.txt count.txt total.len.txt >> summary_LTR.txt
mv summary_LTR.txt ../

cd /home/a1635743/tuatara/censor_repeat/output_analysis/repeat.map/ERV
#cat *.repeat.map > ERV.total.map
#echo 'ERV.total.map' > name.txt
#wc -l ERV.total.map > count.txt
#awk '{len+=$3-$2+1}{print (len/4271823035)*100}' ERV.total.map |tail -1 > total.len.txt
#paste name.txt count.txt total.len.txt >> summary_ERV.txt
mv summary_ERV.txt ../
