# Rename fasta file that has same header (add suffix number after duplicated header), usually happened in Repbase library
awk 'BEGIN {    OFS="\n";    ORS=RS=">";} {    name = $1;    $1 = "";    suffix = names[name] ? "-" names[name] : "";    print name suffix $0, "\n";    names[name]++;}' $file.fa > uniq.$file.fa

# Delete black lines
sed -i '/^$/d' uniq.$file.fa

# Delete extra '>' in the last line
sed -i '$d' uniq.$file.fa
