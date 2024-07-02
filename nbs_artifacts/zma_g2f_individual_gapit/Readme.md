First run `01_mkqueue.sh` to build a queue of file combinations to be run

Then use `run_gwas.sbatch` to load apptainer and run the next set of params with `02_next.sh`

This design allows for one script to be called repeatedly so that scheduling jobs is easy (wc queue and run that many calls) and asynchronously (not one job looping over params).

Here's a short script to run all 

```bash
bash 01_mkqueue.sh
n_runs=$(wc --lines ./queue.txt |awk '{print $1}')
for i in $(seq 1 $n_runs); 
do  
	echo $i
	sbatch run_gwas.sbatch 
	sleep 1 
done
```

