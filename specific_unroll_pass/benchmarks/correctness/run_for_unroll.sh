PATH2LIB=~/EECS583_Unroll_ML/specific_unroll_pass/force_unroll_template/build/force_unroll/LLVMHW2.so        # Specify your build directory in the project
PASS=-force-unroll             

# Clean up previous
rm -f *.bc 

# Compile and run llvm pass
clang -emit-llvm -S ${1}.c -c -o ${1}.bc
opt -enable-new-pm=0 -S -o ${1}.unroll.bc -load ${PATH2LIB} ${PASS} < ${1}.bc > /dev/null

# Compile unrolled and execute
# clang ${1}.unroll.bc -o ${1}_unroll
# ./${1}_unroll

