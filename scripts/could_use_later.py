#!/usr/bin/env python
import os
import argparse

def main():
    desc = 'Parse perf stat results to get top down analysis'
    parser = argparse.ArgumentParser(description=desc)   
    parser.add_argument('-b', '--benchmark', required=True, help='benchmark name')
    args = parser.parse_args()
    BENCHMARK = args.benchmark

    CURRENT_DIR = os.path.dirname(os.path.abspath(__file__))
    TOPLEV_DIR = CURRENT_DIR+'/'+BENCHMARK
    toplev_file_1 = TOPLEV_DIR+'/'+BENCHMARK+'_toplev_1.data'
    toplev_file_2 = TOPLEV_DIR+'/'+BENCHMARK+'_toplev_2.data'

    with open(toplev_file_1) as f:
        for line in f:
	    line = line.strip().replace(',','')
            if 'r19C' in line:
                idq_uops_not_delivered_core = float(line.split(' ')[0])
            elif 'r10E' in line:
                uops_issued_any = float(line.split(' ')[0])
            elif 'r2C2' in line:
                uops_retired_retire_slots = float(line.split(' ')[0])
            elif 'r30D' in line:
                int_misc_recovery_cycles = float(line.split(' ')[0])

    with open(toplev_file_2) as f:
        for line in f:
	    line = line.strip().replace(',','')
            if 'cycles' in line:
                cycles = float(line.split(' ')[0])

    n = 4*cycles
    fe_bound = 100*(idq_uops_not_delivered_core/n)
    bad_speculation = 100*((uops_issued_any - uops_retired_retire_slots+ \
                            4*int_misc_recovery_cycles)/n)
    retiring = 100*(uops_retired_retire_slots/n)
    be_bound = 100 - (fe_bound+retiring+bad_speculation)

    sm = 'FE_Bound: %.2f, Bad_Speculation: %.2f, Retiring: %.2f, BE_Bound: %.2f'
    print(sm%(fe_bound,bad_speculation,retiring,be_bound))

if __name__ == "__main__":
    main()
