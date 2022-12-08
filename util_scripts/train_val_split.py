import csv 
import argparse
import random

def main(args):
    csv_reader = csv.reader(open(args.csv_in, 'r'))
    train_writer = csv.writer(open(args.train_out, 'w'))
    val_writer = csv.writer(open(args.val_out, 'w'))

    for row in csv_reader:
        if random.random() < args.val_split:
            val_writer.writerow(row)
        else:
            train_writer.writerow(row)

# Are similar problems close to each other in the dataset?
# We may want to look at splitting as [       train       | val ] rather than [ t t v t v t t t t v ...]


if __name__ == "__main__":
    parser = argparse.ArgumentParser(description='Script for determining unroll label')
    parser.add_argument('--csv-in', type=str,
                        help='folder with problems inside')
    parser.add_argument('--train-out', type=str, default='../data/train.csv',
                        help='where to move problems that we do not have results for')
    parser.add_argument('--val-out', type=str, default='../data/val.csv',
                        help='locaton for problem folder with description, sample inputs, and random solution')
    parser.add_argument('--val-split', type=float, default=0.2,
                        help='proportion of data that is moved to the validation split')                 
    args = parser.parse_args()
    main(args)