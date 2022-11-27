#!/bin/bash

# Iterate through each problem in description2code, generate bitcode, run llvm pass on bitcode, compile new bitcode to executable
PROBLEM_ROOT_DIR="./description2code_clean"
PATH2LIB=~/EECS583_Unroll_ML/specific_unroll_pass/force_unroll_template/build/force_unroll/LLVMHW2.so        # Specify your build directory in the project
PASS=-force-unroll
UNROLL_COUNT="2" # DECIDED IN LLVM PASS, NEED TO CHECK AND MATCH

for PROBLEM_DIR in ${PROBLEM_ROOT_DIR}/*; do 
    # PROBLEM_DIR="./description2code_clean/zrzr"
    # echo ${PROBLEM_DIR}
    SOURCE_FILE_NO_EXT="${PROBLEM_DIR}/solution"
    # echo ${SOURCE_FILE_NO_EXT}

    clang++ --gcc-toolchain=my_toolchain -emit-llvm -S ${SOURCE_FILE_NO_EXT}.cpp -c -o ${SOURCE_FILE_NO_EXT}.bc
    # TODO: If no solution.bc generated, probably couldn't compile, so just skip, write PROBLEM_DIR to file? 

    opt -enable-new-pm=0 -S -o ${SOURCE_FILE_NO_EXT}.unroll.bc -load ${PATH2LIB} ${PASS} < ${SOURCE_FILE_NO_EXT}.bc > /dev/null
    clang++ --gcc-toolchain=my_toolchain ${SOURCE_FILE_NO_EXT}.unroll.bc -o ${SOURCE_FILE_NO_EXT}_unroll_${UNROLL_COUNT}

    rm -f ${PROBLEM_DIR}/*.bc # Remove .bc files after , uncomment for actual run through, keep bc files for debugging

done
