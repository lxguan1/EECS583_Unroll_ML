#include <stdio.h>

int main(){
	int A[10] = {0, 1, 2, 3, 4, 5, 6, 7, 8, 9};
	int B[10] = {0, 0, 0, 0, 0, 0, 0, 0, 0, 0};
	int i, j;
	j = 0;

	#pragma clang loop unroll_count(2)
	for(i = 0; i < 10; i++) {
  		B[i] = A[j];
        j++;
	}
	return 0;
}
