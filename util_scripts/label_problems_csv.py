import os 
import argparse
import csv
import numpy as np
import pdb

def main(args):
    problems = os.listdir(args.problem_root_dir)
    csv_writer = csv.writer(open(args.csv_out, 'w'), delimiter=',')

    for problem in problems:
        unroll_times_path = os.path.join(args.problem_root_dir, problem, "unroll_times.txt")
        if not os.path.exists(unroll_times_path):
            continue # No input file, did not run
        else:
            # pdb.set_trace()
            with open(unroll_times_path, 'r') as unroll_times_fptr:
                unroll_times_fptr = open(unroll_times_path)
                unroll_times = unroll_times_fptr.readlines()
                unroll_times = [int(time.strip()) for time in unroll_times]
                ranks = np.argsort(unroll_times) + 1
                sorted_times = np.sort(unroll_times)
                label = ranks[0]

                csv_line = [problem] + [label] + list(ranks) + list(sorted_times)
                csv_writer.writerow(csv_line)






if __name__ == "__main__":
    parser = argparse.ArgumentParser(description='Script for determining unroll label')
    parser.add_argument('--problem-root-dir', type=str,
                        help='folder with problems inside')
    parser.add_argument('--garbage-dir', type=str,
                        help='where to move problems that we do not have results for')
    parser.add_argument('--csv-out', type=str,
                        help='locaton for problem folder with description, sample inputs, and random solution')
    args = parser.parse_args()
    main(args)

