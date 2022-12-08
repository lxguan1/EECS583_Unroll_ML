import csv 
import argparse
import numpy as np
import pandas as pd
import matplotlib.pyplot as plt
import pdb

def main(args):
    # pdb.set_trace()
    data = pd.read_csv(args.csv_in, header=None)
    data = data.to_numpy()
    data = data[:, -8].astype(np.uint8)

    counts = []
    for i in range(1, 9):
        counts.append(len(data[data == i]))
    counts = np.array(counts)

    n = len(data)
    n_classes = 8
    proportions = counts / n
    class_weights = np.array([n]*8) / (n_classes * counts)
    print("Class proportions:", np.round(proportions, 4))
    print("Class weights:", np.round(class_weights, 4))


    plt.bar(list(range(1, 9)), height=counts)
    plt.show()

if __name__ == "__main__":
    parser = argparse.ArgumentParser(description='Script for determining unroll label')
    parser.add_argument('--csv-in', type=str,
                        help='folder with problems inside')
    args = parser.parse_args()
    main(args)