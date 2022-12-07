# EECS583_Unroll_ML
`clean_description2code.py` transforms description2code into a more workable format and randomly selects one solution per problem to be our example code.

*After running script dataset looks like:*

bash
```
description2code_clean
├── problem_1
├── problem_2
│   ├── deccription.txt
│   ├── solution.cpp
│   ├── samples
│   │   ├── 1_input.txt
│   │   ├── 1_output.txt
│   │   ├── ...
├── ...
```
Please Note: CSV is in form: Name,Operations,Operands,MemoryOps,FPOps,Branch,resMII,frequentBBs,nestDepth,tripcount
