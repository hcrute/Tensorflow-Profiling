#!/bin/sh
export PYTHONPATH=/home/henry/Projects/fathom
FATHOM_HOME=/home/henry/Projects/fathom/fathom
benchmark=$1
run=$FATHOM_HOME/$benchmark/$benchmark.py
mkdir -p -- "$benchmark"
perf stat -a --topdown \
	  -o $benchmark/${benchmark}_toplev.data python $run
