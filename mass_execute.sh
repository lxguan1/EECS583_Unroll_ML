#!/bin/bash

# Iterate through each problem in description2code, run generated executable 
PROBLEM_ROOT_DIR="./specific_unroll_pass"

for PROBLEM in "${PROBLEM_ROOT_DIR}/*"; do 
    PROBLEM_DIR="${PROBLEM_ROOT_DIR}/${PROBLEM}"
    SOURCE_FILE_NO_EXT="${PROBLEM_DIR}/solution"

    clang -emit-llvm -S ${SOURCE_FILE_NO_EXT}.cpp -c -o ${SOURCE_FILE_NO_EXT}.bc
    opt -enable-new-pm=0 -S -o ${SOURCE_FILE_NO_EXT}.unroll.bc -load ${PATH2LIB} ${PASS} < ${SOURCE_FILE_NO_EXT}.bc > /dev/null
    clang ${SOURCE_FILE_NO_EXT}.unroll.bc -o ${SOURCE_FILE_NO_EXT}_unroll

done
