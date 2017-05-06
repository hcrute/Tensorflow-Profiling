#!/bin/sh
cd /home/henry/Projects/fathom

time python ./fathom/alexnet/alexnet.py > dev/null
time python ./fathom/deepq/deepq.py > dev/null
time python ./fathom/memnet/memnet.py > dev/null
time python ./fathom/residual/residual.py > dev/null
time python ./fathom/seq2seq/seq2seq.py > dev/null
time python ./fathom/vgg/vgg.py > dev/null

