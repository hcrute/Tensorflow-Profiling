#!/bin/sh
cd /home/henry/Projects/fathom

python -m cProfile -o alexnet.cprof ./fathom/alexnet/alexnet.py
python -m cProfile -o deepq.cprof ./fathom/deepq/deepq.py
python -m cProfile -o memnet.cprof ./fathom/memnet/memnet.py
python -m cProfile -o residual.cprof ./fathom/residual/residual.py
python -m cProfile -o seq2seq.cprof ./fathom/seq2seq/seq2seq.py
python -m cProfile -o vgg.cprof ./fathom/vgg/vgg.py
