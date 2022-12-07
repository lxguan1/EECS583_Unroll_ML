import os 
import argparse
import csv
import numpy as np
import pdb

def main(args):
    csv_writer = csv.writer(open(args.csv_out, 'w'), delimiter=',')
    # open the two files to merge
    with open(args.csv1, 'r') as file1, open(args.csv2, 'r') as file2:
        csvreader1 = csv.reader(file1)
        csvreader2 = csv.reader(file2)
        for row1, row2 in zip(csvreader1, csvreader2):
            # obtain list of unroll times and matching labels
            # unroll_times[0] matches with unroll_labels[0]
            unroll_times = row1[6:] + row2[6:]
            unroll_labels = row1[2:6] + row2[2:6]
            problem = row1[0]

            # sorted_idx[0] is the optimal unroll factor
            # the factor number is stored in unroll_labels[sorted_idx[0]]
            sorted_idx = np.argsort(unroll_times)
            ranks = []
            for idx in sorted_idx:
                ranks.append(unroll_labels[idx])
            csv_writer.writerow([problem] + ranks)

if __name__ == "__main__":
    parser = argparse.ArgumentParser(description='Script for determining unroll label')
    parser.add_argument('--problem-root-dir', type=str,
                        help='folder with problems inside')
    parser.add_argument('--garbage-dir', type=str,
                        help='where to move problems that we do not have results for')
    parser.add_argument('--csv-out', type=str,
                        help='locaton for problem folder with description, sample inputs, and random solution')
    parser.add_argument('--csv1', type=str,
                        help='csvs to merge')
    parser.add_argument('--csv2', type=str,
                        help='csvs to merge')
    args = parser.parse_args()
    main(args)

