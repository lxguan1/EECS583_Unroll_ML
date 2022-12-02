import os 
import argparse
import json
import numpy as np
import pdb

def main(args):
    problems = os.listdir(args.problem_root_dir)
    dataset = []

    for problem in problems: 
        unroll_times_path = os.path.join(args.problem_root_dir, problem, "unroll_times.txt")
        if not os.path.exists(unroll_times_path):
            with open("garbage_problems.txt", "a") as garb:
                garb.write(problem+'\n')
            continue # No input file, did not run
        else:
            # pdb.set_trace()
            problem_object = {}
            with open(unroll_times_path, 'r') as unroll_times_fptr:
                unroll_times_fptr = open(unroll_times_path)
                unroll_times = unroll_times_fptr.readlines()
                unroll_times = [int(time.strip()) for time in unroll_times]
                ranks = np.argsort(unroll_times) + 1
                sorted_times = np.sort(unroll_times)
                label = ranks[0]

                problem_object['label'] = int(label)
                problem_object['ranks'] = [int(rank) for rank in ranks]
                problem_object['times'] = [int(time) for time in sorted_times]
            
                dataset.append({problem: problem_object})
    
    with open(args.json_out, 'w') as json_ptr:
        json.dump(dataset, json_ptr)









if __name__ == "__main__":
    parser = argparse.ArgumentParser(description='Script for determining unroll label')
    parser.add_argument('--problem-root-dir', type=str,
                        help='folder with problems inside')
    # parser.add_argument('--garbage-dir', type=str,
    #                     help='where to move problems that we do not have results for')
    parser.add_argument('--json-out', type=str,
                        help='locaton for problem folder with description, sample inputs, and random solution')
    args = parser.parse_args()
    main(args)