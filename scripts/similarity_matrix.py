#!/usr/bin/env python
import os
import argparse
import numpy as np
import pandas as pd
import seaborn as sns
import matplotlib.pyplot as plt
from sklearn.metrics.pairwise import cosine_similarity

def main():
    desc = 'Parse bbv results to get interval similarity matrix'
    parser = argparse.ArgumentParser(description=desc)   
    parser.add_argument('-f', '--file', required=True, help='filename')
    args = parser.parse_args()
    bbv_file = args.file

    bbv_dict = {}
    count = 0
    with open(bbv_file, 'r') as f:
        for line in f:
            count += 1
            bbs = line.split(',')
            bbv_dict[count] = {}
            for bb_info in bbs:
                bb, freq = bb_info.split(':')
                bbv_dict[count][bb] = float(freq)

    data = pd.DataFrame(bbv_dict).T.fillna(0)

    similarity_matrix = cosine_similarity(data)
    mask = np.ones_like(similarity_matrix)
    mask[np.triu_indices_from(mask)] = False
    np.fill_diagonal(mask, False)
    with sns.axes_style("white"):
        ax = sns.heatmap(similarity_matrix, mask=mask)
	
    ax.xaxis.tick_top()
    ax.set_xlabel('100 million instructions')    
    ax.xaxis.set_label_position('top') 
    
    for i, xlabel_i in enumerate(ax.get_xticklabels()):
        if (i % 4):
            xlabel_i.set_visible(False)
            xlabel_i.set_fontsize(0.0)
    
    for i, xlabel_i in enumerate(ax.get_yticklabels()):
        #if (i % 4):
        xlabel_i.set_fontsize(0.0)
        xlabel_i.set_visible(False)

    png_name = bbv_file.replace('proc_bbv.txt.', '')
    plt.savefig(png_name + '_similarity.png')

if __name__ == "__main__":
    main()
