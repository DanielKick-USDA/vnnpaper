#!/bin/bash

# find the lenght of the queue so it can be shortened
tmp=($(wc --lines ./queue.txt))
nlines=${tmp[0]}

geno_path=$(head -n 1 queue.txt |awk '{print $1}')
phno_path=$(head -n 1 queue.txt |awk '{print $2}')

# This the pipe runs before tail so we have to use a temp file and then rename it.
tail -n $((nlines -1)) queue.txt > queue.tmp && mv queue.tmp queue.txt

#echo $nlines
#echo $geno_path
#echo $phno_path

# create a new save location
# remove the ./dir/ and .txt 
phno_name=$(echo $phno_path |sed 's|\./.*/||' |sed 's|\.txt||')
geno_name=$(echo $geno_path |sed 's|\./.*/||' |sed 's|\.hmp\.txt||')

save_dir='./output/'$phno_name'__'$geno_name
mkdir $save_dir

# change pwd 
# copy gwas.R to the save dir
cd  './'$save_dir
cp ../../gwas.R ./gwas.R

# modify the paths with a leading '.' to be '../'
# use sed to replace the run settings
sed -i 's|./hmp_phno.txt|../.'$phno_path'|' ./gwas.R
sed -i 's|./geno.hmp.txt|../.'$geno_path'|' ./gwas.R

singularity exec ../../gapit.sif Rscript ./gwas.R > run.out
