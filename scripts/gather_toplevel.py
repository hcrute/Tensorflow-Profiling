#!/usr/bin/env python
import os

def main():
    CURRENT_DIR = os.path.dirname(os.path.abspath(__file__))
    benchmarks = ['alexnet', 'deepq', 'memnet', 'residual', 'seq2seq', 'vgg']
    for benchmark in benchmarks:
	toplev_file = CURRENT_DIR+'/'+benchmark+'/'+benchmark+'_toplev.data'
        with open(toplev_file, 'r') as stats_file:
            for line in stats_file:
                line = line.strip()
                if 'C0' in line:
                    fe_bound_c0 = 
                elif 'C1' in line:
                elif 'C2' in line:
                elif 'C3' in line:

if __name__ == "__main__":
    main()
