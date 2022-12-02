import os

problem_dir = "./description2code_clean" # CHANGE IF NECESSARY
garbage_dir = "./description2code_garbage"

should_be_in_garbage = open('garbage_problems.txt', 'r').readlines()
should_be_in_garbage = [x.strip() for x in should_be_in_garbage]

for problem in os.listdir(problem_dir):
    if problem in should_be_in_garbage:
        # print(os.path.join(problem_dir, problem), os.path.join(garbage_dir, problem))
        os.rename(os.path.join(problem_dir, problem), os.path.join(garbage_dir, problem)) # Uncomment if it looks right
        print(f"Moved {problem} to garbage you're welcome")
