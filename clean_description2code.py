import argparse
import os 
import random
import shutil

def main(args):
    # Make destination folder if it doesn't exist
    if not os.path.exists(args.out_dir):
        os.makedirs(args.out_dir)

    # Iterate through each problem and copy over necessary info
    problem_folders = os.listdir(args.problem_root_dir)
    for i, problem in enumerate(problem_folders):
        print(i, problem)

        # Choose random solution 
        soln_path = os.path.join(args.problem_root_dir, problem, 'solutions_c++')
        if not os.path.exists(soln_path):
            continue
        soln_files = os.listdir(soln_path)
        if len(soln_files) == 0:
            continue
        soln = random.choice(soln_files)

        # Prepare save folder
        dst_folder = os.path.join(args.out_dir, problem)
        if not os.path.exists(dst_folder):
            os.mkdir(dst_folder)

        # Copy problem description 
        shutil.copyfile(os.path.join(args.problem_root_dir, problem, 'description', 'description.txt'),
                        os.path.join(dst_folder, 'description.txt'))
        # Copy random solution file (convert from txt to cpp)
        shutil.copyfile(os.path.join(soln_path, soln),
                        os.path.join(dst_folder, soln.replace('.txt', '.cpp')))
        # Copy folder containing sample input
        shutil.copytree(os.path.join(args.problem_root_dir, problem, 'samples'),
                        os.path.join(dst_folder, 'samples'))

if __name__ == "__main__":
    parser = argparse.ArgumentParser(description='ZZX TRAIN SEGMENTATION')
    parser.add_argument('--problem-root-dir', type=str,
                        help='folder with problems inside')
    parser.add_argument('--out-dir', type=str,
                        help='locaton for problem folder with description, sample inputs, and random solution')
    parser.add_argument('--mode', type=str,
                        help='codeforces or ')
    args = parser.parse_args()
    main(args)
