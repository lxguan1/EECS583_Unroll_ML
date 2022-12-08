import os 
import argparse
import csv
import pdb
import pandas as pd

import numpy as np

def main(args):
    label_df = pd.read_csv(args.label_csv, header=None)
    feature_df = pd.read_csv(args.feature_csv, header=None)
    csv_writer = csv.writer(open(args.csv_out, 'w'), delimiter=',')

    # pdb.set_trace()
    # Iterate through feature_df - that has limiting number of rows
    for i, feat_row in feature_df.iterrows():
        prob = feat_row[0]
        
        # Find row with same problem name and only take unroll ranks (.iloc[:, 1:])
        label_ranks = label_df.loc[label_df[0] == prob].iloc[:, 1:]
        if len(label_ranks) == 0:
            continue

        # Combine two rows as lists, write to csv
        res_row = list(feat_row.values) + list(label_ranks.values[0])
        csv_writer.writerow(list(res_row))


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
