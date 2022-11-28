#!/bin/bash
### run.sh
### benchmark runner script
### Locate this script at each benchmark directory. e.g, 583simple/run.sh
### usage: ./run.sh ${benchmark_name} ${input} 
### e.g., ./run.sh compress compress.in or ./run.sh simple or ./run.sh wc cccp.c
### Note: Do NOT inlude inputs/ in ${input}, `./run.sh compress inputs/compress.in` will provide different results

PATH_MYPASS=~/Loop_Unrolling/build/feature_extract_pass/LLVMHW2.so ### Action Required: Specify the path to your pass ###
NAME_MYPASS=-feature_extract_pass ### Action Required: Specify the name for your pass ###
BENCH=${1}.cpp
INPUT=${2}

setup(){
if [[ ! -z "${INPUT}" ]]; then
echo "INPUT:${INPUT}"
ln -sf input1/${INPUT} .
fi
}

cleanup(){
rm *.profdata
rm *.bc
rm *.prof
rm *.profraw
if [[ ! -z "${INPUT}" ]]; then
rm *.in
rm *.in.Z
fi
}

# clean up previous runs
cleanup
# Prepare input to run
setup
# Convert source code to bitcode (IR)
# This approach has an issue with -O2, so we are going to stick with default optimization level (-O0)
clang++ -emit-llvm -c ${BENCH} -o ${1}.bc --gcc-toolchain=toolchain
# Instrument profiler
#opt -enable-new-pm=0 -pgo-instr-gen -instrprof ${1}.bc -o ${1}.prof.bc
# Generate binary executable with profiler embedded
#clang++ -fprofile-instr-generate ${1}.prof.bc -o ${1}.prof --gcc-toolchain=toolchain
# Collect profiling data
#./${1}.prof ${INPUT}
# Translate raw profiling data into LLVM data format
#llvm-profdata merge -output=pgo.profdata default.profraw

# Prepare input to run
#setup
echo ${1}
# Apply your pass to bitcode (IR)
opt -enable-new-pm=0 -load ${PATH_MYPASS} ${NAME_MYPASS} < ${1}.bc > /dev/null



# PATH2LIB=~/Loop_Unrolling/build/feature_extract_pass/LLVMHW2.so        # Specify your build directory in the project
# PASS=-feature_extract_pass                   # Choose either -fplicm-correctness or -fplicm-performance

# # Delete outputs from previous run.
# rm -f default.profraw ${1}_prof ${1}_fplicm ${1}_no_fplicm *.bc ${1}.profdata *_output *.ll

# # Convert source code to bitcode (IR)
# clang++ -emit-llvm -c ${1}.cpp -o ${1}.bc --gcc-toolchain=toolchain
# # Canonicalize natural loops
# opt -enable-new-pm=0 -loop-simplify ${1}.bc -o ${1}.ls.bc
# # Instrument profiler
# opt -enable-new-pm=0 -pgo-instr-gen -instrprof ${1}.ls.bc -o ${1}.ls.prof.bc
# # Generate binary executable with profiler embedded
# clang++ -fprofile-instr-generate ${1}.ls.prof.bc -o ${1}_prof --gcc-toolchain=toolchain
# echo "done 1"
# # Generate profiled data
# ./${1}_prof > correct_output
# llvm-profdata merge -o ${1}.profdata default.profraw
# echo "done 2"
# # Apply FPLICM
# opt -enable-new-pm=0 -o ${1}.fplicm.bc -pgo-instr-use -pgo-test-profile-file=${1}.profdata -load ${PATH2LIB} ${PASS} < ${1}.ls.bc > /dev/null
# echo "done 3"
# # Generate binary excutable before FPLICM: Unoptimzied code
# #clang ${1}.ls.bc -o ${1}_no_fplicm
# # Generate binary executable after FPLICM: Optimized code
# clang++ ${1}.fplicm.bc -o ${1}_fplicm --gcc-toolchain=toolchain

# # Produce output from binary to check correctness
# ./${1}_fplicm > fplicm_output

# #echo -e "\n=== Correctness Check ==="
# # if [ "$(diff correct_output fplicm_output)" != "" ]; then
# #     echo -e ">> FAIL\n"
# # else
# #     echo -e ">> PASS\n"
# #     # Measure performance
# #     echo -e "1. Performance of unoptimized code"
# #     time ./${1}_no_fplicm > /dev/null
# #     echo -e "\n\n"
# #     echo -e "2. Performance of optimized code"
# #     time ./${1}_fplicm > /dev/null
# #     echo -e "\n\n"
# # fi

# # # Cleanup
# rm -f default.profraw ${1}_prof ${1}_fplicm ${1}_no_fplicm *.bc ${1}.profdata *_output *.ll
