
/*
  Single-precision A*X plus Y, Y = alpha*X+Y
 */

void saxpy(int n, float alpha, float *X, float *Y) {
  for (int i=0; i<n; i++)
    Y[i] = alpha*X[i] + Y[i];
}
