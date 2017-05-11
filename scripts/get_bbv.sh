#!/bin/sh
export PYTHONPATH=/home/henry/Projects/fathom
FATHOM_HOME=/home/henry/Projects/fathom/fathom
benchmark=$1
run=$FATHOM_HOME/$benchmark/$benchmark.py
mkdir -p -- "$benchmark"

valgrind --tool=exp-bbv --bb-out-file=$benchmark/${benchmark}_bbv.txt --interval-size=100000000 python $run
for file in `ls $benchmark/${benchmark}_bbv.txt*`
do
	processed_file=$(echo $file | sed 's/_bbv/_proc_bbv/g')
	echo $processed_file
	cat $file | grep T: | sed 's/T://g' | sed 's/   :/,/g' > $processed_file
	./similarity_matrix.py -f $processed_file
done
