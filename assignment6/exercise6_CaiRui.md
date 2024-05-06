## Exercise 6  
In this exercise I'm simply implementing a `void ComputeForceVec(int N, double *X, double *Y, double *mass, double *Fx, double *Fy)` funciton that does the same thing as `void ComputeForce(int N, double *X, double *Y, double *mass, double *Fx, double *Fy)`.    
I'm using the (`version2` repo of the C++ vector class library)[https://github.com/vectorclass/version2].   
Here's how I implemented `ComputeForceVec`:   
```c
void ComputeForceVec(int N, double *X, double *Y, double *mass, double *Fx, double *Fy) {
    const double mindist = 0.0001;
    Vec4d minDistVec = Vec4d(mindist);
    Vec4d GVec = Vec4d(G);
    Vec4d zero = Vec4d(0.0);
    double inf = std::numeric_limits<double>::infinity();

    for (int i = 0; i < N; i += 4) {
        Vec4d xi = Vec4d().load(&X[i]);
        Vec4d yi = Vec4d().load(&Y[i]);
        Vec4d mi = Vec4d().load(&mass[i]);
        Vec4d Fxi = Vec4d(0.0);
        Vec4d Fyi = Vec4d(0.0);

        for (int j = 0; j < N; j++) {
            Vec4d xj = Vec4d().load(&X[j]);
            Vec4d yj = Vec4d().load(&Y[j]);
            Vec4d mj = Vec4d().load(&mass[j]);

            Vec4d dx = xj - xi;
            Vec4d dy = yj - yi;

            Vec4d r2 = dx * dx + dy * dy;
            Vec4d r = sqrt(r2);
            Vec4db mask = r > minDistVec;

            Vec4d r3 = select(mask, r2 * r, Vec4d(inf));

            Vec4d Fxij = select(mask, GVec * mi * mj * dx / r3, zero);
            Vec4d Fyij = select(mask, GVec * mi * mj * dy / r3, zero);

            Fxi += Fxij;
            Fyi += Fyij;
        }

        Fxi.store(&Fx[i]);
        Fyi.store(&Fy[i]);
    }
}
```
I'm using the `Vec4d` class, which computes 4 double data values at 1 iteration of SIMD, therefore compared to the original `ComputeForce` at least the outer for-loop would run 1/4 iterations, which is 250 iterations.     
And also in the vector class library there's a `select` inline function:   
```c
/* @header: vectorf256e.h */

// Select between two operands. Corresponds to this pseudocode:
// for (int i = 0; i < 2; i++) result[i] = s[i] ? a[i] : b[i];
// Each byte in s must be either 0 (false) or 0xFFFFFFFFFFFFFFFF (true).
// No other values are allowed.
static inline Vec4d select (Vec4db const s, Vec4d const a, Vec4d const b) {
    return Vec4d(select(s.get_low(), a.get_low(), b.get_low()), select(s.get_high(), a.get_high(), b.get_high()));
}
```
therefore here I'm doing the same thing as the if statement to check wether the distance between body i and j is too small:  
```c
Vec4db mask = r > minDistVec;
Vec4d r3 = select(mask, r2 * r, Vec4d(inf));
Vec4d Fxij = select(mask, GVec * mi * mj * dx / r3, zero);
Vec4d Fyij = select(mask, GVec * mi * mj * dy / r3, zero);
```
  
The running results looks like the implementation with vectorization is almost 30 times faster:  
```
Time:  61.20 seconds
Time with vectorization:   1.99 seconds
```  
To verify wether the results are correct or not, I simply went through the whole result array `Fx`, `Fy` and `FxVec`, `FyVec` to check the values one by one. I wanted to see how different they are so I set the difference threshold to `1e-8`:  
```c
// Verify the results
   double diffTolerance = 1e-8;
   bool allMatch = true;
   for( int i = 0; i < N; ++i ) {
    if (fabs(Fx[i] - FxVec[i]) > diffTolerance || fabs(Fy[i] - FyVec[i]) > diffTolerance) {
            printf("Mismatch found at index %d: Fx = %f, FxVec = %f, Fy = %f, FyVec = %f\n",
                   i, Fx[i], FxVec[i], Fy[i], FyVec[i]);
            allMatch = false;
        }
   }
   if (allMatch) {
    printf("All results match within tolerance.\n");
   } else {
    printf("There were discrepancies in the results.\n");
   }
```  
And some printed mismatch results looks like this:  
```
Mismatch found at index 965: Fx = 0.008724, FxVec = 0.008724, Fy = -0.041874, FyVec = -0.041874
Mismatch found at index 966: Fx = 0.000008, FxVec = 0.000008, Fy = 0.000019, FyVec = 0.000019
Mismatch found at index 967: Fx = -0.000224, FxVec = -0.000220, Fy = -0.000035, FyVec = -0.000037
Mismatch found at index 969: Fx = -0.012657, FxVec = -0.012656, Fy = -0.000935, FyVec = -0.000935
Mismatch found at index 970: Fx = -0.024894, FxVec = -0.024524, Fy = 0.012786, FyVec = 0.012781
Mismatch found at index 971: Fx = -0.000491, FxVec = -0.000492, Fy = 0.002732, FyVec = 0.002727
Mismatch found at index 973: Fx = -0.000191, FxVec = -0.000191, Fy = 0.001945, FyVec = 0.001945
Mismatch found at index 974: Fx = -0.200502, FxVec = -0.200613, Fy = -0.082690, FyVec = -0.082691
Mismatch found at index 975: Fx = -0.000031, FxVec = -0.000031, Fy = 0.000774, FyVec = 0.000773
Mismatch found at index 977: Fx = 0.049459, FxVec = 0.049460, Fy = -0.011423, FyVec = -0.011423
Mismatch found at index 978: Fx = 0.050727, FxVec = 0.050660, Fy = -0.017287, FyVec = -0.017262
Mismatch found at index 979: Fx = 0.005456, FxVec = 0.005447, Fy = 0.002174, FyVec = 0.002165
Mismatch found at index 981: Fx = 0.191014, FxVec = 0.191015, Fy = -0.129199, FyVec = -0.129199
Mismatch found at index 982: Fx = -0.191893, FxVec = -0.192058, Fy = 0.088351, FyVec = 0.088505
Mismatch found at index 983: Fx = -0.017220, FxVec = -0.017118, Fy = 0.026279, FyVec = 0.026542
Mismatch found at index 985: Fx = -0.068056, FxVec = -0.068056, Fy = 0.100384, FyVec = 0.100384
Mismatch found at index 986: Fx = 0.000071, FxVec = 0.000071, Fy = 0.000081, FyVec = 0.000081
Mismatch found at index 987: Fx = 0.008063, FxVec = 0.006506, Fy = -0.092842, FyVec = -0.093951
Mismatch found at index 989: Fx = -0.015843, FxVec = -0.015843, Fy = -0.004454, FyVec = -0.004454
Mismatch found at index 990: Fx = -0.001056, FxVec = -0.001069, Fy = 0.000946, FyVec = 0.000943
Mismatch found at index 991: Fx = 0.052391, FxVec = 0.052247, Fy = 0.004495, FyVec = 0.004490
Mismatch found at index 994: Fx = 0.000038, FxVec = 0.000038, Fy = -0.000166, FyVec = -0.000165
Mismatch found at index 995: Fx = 0.011556, FxVec = 0.011444, Fy = 0.013609, FyVec = 0.013565
Mismatch found at index 997: Fx = -0.006328, FxVec = -0.006327, Fy = -0.026079, FyVec = -0.026079
Mismatch found at index 998: Fx = 0.001157, FxVec = 0.001156, Fy = -0.001529, FyVec = -0.001528
Mismatch found at index 999: Fx = 0.014336, FxVec = 0.014209, Fy = 0.018819, FyVec = 0.018921
```
So at least the difference between the 2 methods' results are smaller than $10^{-5}$ (`1e-5`).