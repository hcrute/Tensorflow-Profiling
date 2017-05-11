#!/bin/sh
export PYTHONPATH=/home/henry/Projects/fathom
FATHOM_HOME=/home/henry/Projects/fathom/fathom
for benchmark in "alexnet" "deepq" "memnet" "residual" "seq2seq" "vgg"
do
	./$1 $benchmark
done
