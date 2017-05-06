#!/bin/sh
export PYTHONPATH=/home/henry/Projects/fathom
FATHOM_HOME=/home/henry/Projects/fathom/fathom
for benchmark in "alexnet" "autoenc" "deepq" "memnet" "residual" "seq2seq" "speech" "vgg"
do
	run=$FATHOM_HOME/$benchmark/$benchmark.py
	mkdir -p -- "$benchmark"
	perf record -e instructions,cpu-cycles,branch-instructions,branch-misses -o $benchmark/${benchmark}_1.data python $run
	perf record -e cache-misses,cache-references,mem-loads,mem-stores -o $benchmark/${benchmark}_2.data python $run
	perf record -e L1-dcache-load-misses,L1-dcache-loads,L1-dcache-stores,L1-icache-load-misses -o $benchmark/${benchmark}_3.data python $run
done
