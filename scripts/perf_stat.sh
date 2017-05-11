#!/bin/sh
export PYTHONPATH=/home/henry/Projects/fathom
FATHOM_HOME=/home/henry/Projects/fathom/fathom
benchmark=$1
run=$FATHOM_HOME/$benchmark/$benchmark.py
mkdir -p -- "$benchmark"
perf stat -e instructions,cpu-cycles,branch-instructions,branch-misses -o $benchmark/${benchmark}_1.stat python $run
perf stat -e L1-dcache-load-misses,L1-dcache-loads -o $benchmark/${benchmark}_2.stat python $run
perf stat -e L1-dcache-stores,L1-icache-load-misses -o $benchmark/${benchmark}_3.stat python $run
perf stat -e rFF24,r3F24,LLC-load-misses,LLC-store-misses -o $benchmark/${benchmark}_4.stat python $run
perf stat -e dTLB-load-misses,iTLB-load-misses -o $benchmark/${benchmark}_5.stat python $run
