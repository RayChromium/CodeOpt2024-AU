## Exercise 3  
  
### Step 1  
#### a. calculate the cache miss  
For the (i, k, j) loop: it accesses `a[i][k]` once per iteration of the `k` loop, and it is stored in a register. Since we access this matrix row-wise, we have a cache miss every 8 iterations (one cache miss per cache line). It accesses `b[k][j]` sequentially within the innermost loop `j`. Therefore, we get a cache miss every 8 iterations as we're accessing it row-wise, which is cache-friendly in a row-major layout.