#!/bin/bash

input="/home/a1635743/tuatara/censor_repeat/output_analysis/repeat.map/DNA_type.txt"
while IFS= read -r var
do
  echo "$var"
mv "$var" DNA/
done < "$input"

input="/home/a1635743/tuatara/censor_repeat/output_analysis/repeat.map/ERV_type.txt"
while IFS= read -r var
do
  echo "$var"
mv "$var" ERV/
done < "$input"

input="/home/a1635743/tuatara/censor_repeat/output_analysis/repeat.map/LTR_type.txt"
while IFS= read -r var
do
  echo "$var"
mv "$var" LTR/
done < "$input"

input="/home/a1635743/tuatara/censor_repeat/output_analysis/repeat.map/LINE_type.txt"
while IFS= read -r var
do
  echo "$var"
mv "$var" LINE/
done < "$input"

