#include <stdio.h>
#include <cuda.h>
#include <string>
//using namespace std;
__global__ void myKernel(int* c,int N ) 
{ if(threadIdx.x <N){
  c[threadIdx.x] = 2;
	printf("Hello, world from the device! \n"); 
//__syncthreads();
}
} 

int main() 
{ 
//int dayName[] = {1, 1,1,1,1,1,1,1,2,2};
int* dayName = (int*)malloc(10*sizeof(int));
for(int i=0; i<10; i++){
//printf("dayName spot %d , %d \n", i, dayName[i]);
 dayName[i]= 1;
}
int* d_c;
cudaMalloc((void **)&d_c,10*sizeof(int));
cudaMemcpy(d_c, dayName, 10*sizeof(int), cudaMemcpyHostToDevice);
//printf("first is %s \n", d_c[1]);

//cudaPrintfInit();   
myKernel<<<1,10>>>(d_c, 10); 
//cudaPrintfDisplay(stdout, true); 
//cudaPrintfEnd();
cudaDeviceSynchronize();
cudaMemcpy(dayName, &d_c, 10*sizeof(int), cudaMemcpyDeviceToHost );
cudaFree(d_c);
for(int i=0; i<10; i++){
printf("dayName spot %d , %d  \n", i, dayName[i]);
}
printf("I am saine \n");
} 
