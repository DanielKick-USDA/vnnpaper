#!/bin/bash
for i in ./genotypes/*.hmp.txt; 
do 
	for j in ./phenotypes/phno*.txt; 
	do  
		echo $i $j >> ./queue.txt; 
	done; 
done

