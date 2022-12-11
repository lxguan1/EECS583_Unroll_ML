import os 
import numpy as np
import pandas as pd 
import csv
import argparse
import pdb

# NOTE ORIGINAL TRAIN / VAL WERE NORMALIZED INDEPENDENTLY WHEN THEY PROBABLY SHOULD HAVE BEEN NORMALIZED AS ONE BIG FILE

def main(args):
    # pdb.set_trace()
    data = pd.read_csv(args.csv_in, header=None).to_numpy()
    # 5, 13.0, 1.0, 0.0, 1.0, 1.0, 2.0, 1.0, 1000005.0
    max_vals = np.max(data[:, 1:10], axis=0, keepdims=True)
    data[:, 1:10] = data[:, 1:10] / max_vals

    np.savetxt(args.csv_out, data, delimiter=',', fmt='%s')

if __name__ == "__main__":
    parser = argparse.ArgumentParser(description='')
    parser.add_argument('--csv-in', type=str,
                        help='data csv to normalize')
    parser.add_argument('--csv-out', type=str,
                        help='csv to save normalized data to')
    args = parser.parse_args()
    main(args)