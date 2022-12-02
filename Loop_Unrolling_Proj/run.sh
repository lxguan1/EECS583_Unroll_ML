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
clang++ -emit-llvm -c -S ${BENCH} -o ${1}.bc --gcc-toolchain=toolchain

opt -enable-new-pm=0 -loop-simplify ${1}.bc -o ${1}.ls.bc
# Instrument profiler
opt -enable-new-pm=0 -pgo-instr-gen -instrprof ${1}.ls.bc -o ${1}.ls.prof.bc
# Generate binary executable with profiler embedded
clang++ -fprofile-instr-generate ${1}.ls.prof.bc -o ${1}.prof --gcc-toolchain=toolchain
# Collect profiling data
echo "1"
./${1}.prof < ${INPUT} > correct_output
echo "2"
# Translate raw profiling data into LLVM data format
llvm-profdata merge -output=pgo.profdata default.profraw

# Prepare input to run
#setup
echo ${1}
# Apply your pass to bitcode (IR)
opt -enable-new-pm=0 -load ${PATH_MYPASS} ${NAME_MYPASS} < ${1}.ls.bc > /dev/null


