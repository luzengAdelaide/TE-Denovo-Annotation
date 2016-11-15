#!/usr/bin/bash

cd /data/rc003/lu/opossum/censor_repeat/output_analysis/DNA
cat *.repeat.map > DNA.total.map
echo 'DNA.total.map' > name.txt
wc -l DNA.total.map > count.txt
awk '{len+=$3-$2+1}{print len}' DNA.total.map |tail -1 > len.txt
awk '{len+=$3-$2+1}{print (len/3605631728)*100}' DNA.total.map |tail -1 > total.len.txt
paste name.txt count.txt len.txt total.len.txt >> summary_DNA.txt
mv summary_DNA.txt ../

cd /data/rc003/lu/opossum/censor_repeat/output_analysis/RETRO
cat *.repeat.map > RETRO.total.map 
echo 'RETRO.total.map' >name.txt
wc -l LINE.total.map > count.txt
awk '{len+=$3-$2+1}{print len}' RETRO.total.map |tail -1 > len.txt
awk '{len+=$3-$2+1}{print (len/3605631728)*100}' RETRO.total.map |tail -1 > total.len.txt
paste name.txt count.txt len.txt total.len.txt >> summary_RETRO.txt
mv summary_RETRO.txt ../

cd /data/rc003/lu/opossum/censor_repeat/output_analysis/LTR
cat *.repeat.map > LTR.total.map 
echo 'LTR.total.map' >name.txt
wc -l LTR.total.map > count.txt
awk '{len+=$3-$2+1}{print len}' LTR.total.map |tail -1 > len.txt
awk '{len+=$3-$2+1}{print (len/3605631728)*100}' LTR.total.map |tail -1 > total.len.txt
paste name.txt count.txt len.txt total.len.txt >> summary_LTR.txt
mv summary_LTR.txt ../

cd /data/rc003/lu/opossum/censor_repeat/output_analysis/ERV
cat *.repeat.map > ERV.total.map
echo 'ERV.total.map' > name.txt
wc -l ERV.total.map > count.txt
awk '{len+=$3-$2+1}{print len}' ERV.total.map |tail -1 > len.txt
awk '{len+=$3-$2+1}{print (len/3605631728)*100}' ERV.total.map |tail -1 > total.len.txt
paste name.txt count.txt len.txt total.len.txt >> summary_ERV.txt
mv summary_ERV.txt ../

cd /data/rc003/lu/opossum/censor_repeat/output_analysis/other
cat *.repeat.map > other.total.map
echo 'other.total.map' > name.txt
wc -l other.total.map > count.txt
awk '{len+=$3-$2+1}{print len}' other.total.map |tail -1 > len.txt
awk '{len+=$3-$2+1}{print (len/3605631728)*100}' other.total.map |tail -1 > total.len.txt
paste name.txt count.txt len.txt total.len.txt >> summary_other.txt
mv summary_other.txt ../
