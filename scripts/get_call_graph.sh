#!/bin/sh
export PYTHONPATH=/home/henry/Projects/fathom
FATHOM_HOME=/home/henry/Projects/fathom/fathom
benchmark=$1
run=$FATHOM_HOME/$benchmark/$benchmark.py
mkdir -p -- "$benchmark"

python -m cProfile -o $benchmark/${benchmark}.cprof $run
pyprof2calltree -k -i $benchmark/${benchmark}.cprof &

