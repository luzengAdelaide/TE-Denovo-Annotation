#!/bin/bash

for i in *
do
awk '{print $1,"\t",$2,"\t",$3,"\t",$4,"\t",$8"_"$12,"\t",$7}' * > *.bed
done