PATH2LIB=~/EECS583_Unroll_ML/specific_unroll_pass/force_unroll_template/build/force_unroll/LLVMHW2.so        # Specify your build directory in the project
PASS=-force-unroll             

rm -f *.bc 

# clang ${1}.c -o ${1}
clang -emit-llvm -S ${1}.c -c -o ${1}.bc
opt -enable-new-pm=0 -S -o ${1}.unroll.bc -load ${PATH2LIB} ${PASS} < ${1}.bc > /dev/null

