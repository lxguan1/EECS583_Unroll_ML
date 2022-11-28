#!/bin/bash

# Iterate through each problem in description2code, run generated executable 
PROBLEM_ROOT_DIR="./description2code_subset"
unrollFactors=(1 2 3 4)

# Clean up unroll times from here
rm -f ${PROBLEM_ROOT_DIR}/*/unroll_times.txt

# For each unroll factor, iterate over problems and run
for i in ${unrollFactors[@]}; do
    for PROBLEM_DIR in ${PROBLEM_ROOT_DIR}/*; do 
        echo ${PROBLEM_DIR}
        EXEC_FILE="${PROBLEM_DIR}/solution_unroll_${i}"
        TIME_FILE="${PROBLEM_DIR}/unroll_times.txt"

        # old time format
        # EXEC_TIME="$(TIMEFORMAT='%lR';time ( ./${EXEC_FILE} < ${PROBLEM_DIR}/samples/1_input.txt ) 2>&1 1>/dev/null )"

        # Get time in nanoseconds
        START="$(date +%s%N)"
        ./${EXEC_FILE} < ${PROBLEM_DIR}/samples/1_input.txt 2>&1 1>/dev/null
        NS_TIME=$(($(date +%s%N)-${START}))
        # echo ${EXEC_TIME}
        # echo ${EXEC_TIME} >> "${TIME_FILE}"
        echo ${NS_TIME} >> "${TIME_FILE}"

    done



done 

