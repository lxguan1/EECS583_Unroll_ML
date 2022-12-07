import os 
import argparse
import csv
import pdb
import pandas as pd

import numpy as np

def main(args):
    csv_reader = csv.reader(open(args.label_csv, 'r'), delimiter=',')
    csv_writer = csv.writer(open(args.csv_out, 'w'), delimiter=',')

    for line in csv_reader:
        feat_vec = list(np.round(np.random.normal(size=8), 2))
        line_w_feat = (line[0:1] + feat_vec) + line[1:]

        csv_writer.writerow(line_w_feat)


if __name__ == "__main__":
    parser = argparse.ArgumentParser(description='Script for determining unroll label')
    parser.add_argument('--label-csv', type=str,
                        help='folder with problems inside')
    parser.add_argument('--feature-csv', type=str,
                        help='locaton for problem folder with description, sample inputs, and random solution')
    parser.add_argument('--csv-out', type=str,
                        help='locaton for problem folder with description, sample inputs, and random solution')
    args = parser.parse_args()
    main(args)
