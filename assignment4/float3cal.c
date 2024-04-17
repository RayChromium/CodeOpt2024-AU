#include <stdio.h>
int main() {
 float f = 0.1f;
 float sum1 = 0.0f;
 
 // Calculate the result by adding
 for (int i = 0; i < 10; ++i)
 sum1 += f;
 // Calculate the result by multiplying
 float sum2 = f * 10.0f;
 // Print results, with a third calculation of the value
 printf("sum1 = %1.15f, sum2 = %1.15f, sum3 = %1.15f\n",
 sum1, sum2, f*10.0);
 return 0;
}
