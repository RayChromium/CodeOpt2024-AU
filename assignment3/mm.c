
#include <stdio.h>
#include <stdlib.h>
#include <time.h>

/*
  - Load the module gcc: module load gcc
  - Compile with:  gcc -O3 -o mm
 */


/* Allocates a 2D matrix of size rows*cols as a contiguous block */
  double ** allocate_matrix(int rows, int cols) {
    /* Allocate row pointers */
    double **M = (double **) malloc(rows*sizeof(double *));
    if (M==NULL) {
      printf("Could not allocate memory for row pointers\n");
      exit(0);
    }
    /* Allocate a contiguous block of rows*cols elements */
    double *Mb = (double *) malloc(rows*cols*sizeof(double));
    if (Mb==NULL) {
      printf("Could not allocate memory for matrix\n");
      exit(0);
    }
    /* Initialize pointers to rows in the matrix */
    for (int i=0; i<rows; i++) {
      M[i] = Mb + i*cols;
    }
    return M;
  }

/* Frees a 2D matrix */
  void free_matrix(double **M) {
    free(M[0]);
    free(M);
  }

/* Writes a matrix M of size r*c to the file fn in readable format.
   Returns zero if the file couldn't be opened, otherwise 1       */
int fwrite_matrix(double **M, const int rows, const int cols, char *fn) {
  FILE *fp;
  /* Open the file */
  if ((fp=fopen(fn, "w")) == NULL) {
    printf("Couldn't open file %s\n", fn);
    return 0;
  }
  /* Write the matrix to the file in ASCII format */
  for (int i=0; i<rows; i++) {
      for (int j=0; j<cols; j++) {
	fprintf(fp, "%.1f ", M[i][j]);
      }
      fprintf(fp, "\n");
  }
  fclose(fp);  /* Close the file */
  return(1);
}

/* Prints out the first limit*limit elements of a 2D matrix */
  void print_matrix(double **M, const int rows, const int cols, const int limit) {
    int r = (rows<limit) ? rows : limit;
    int c = (cols<limit) ? cols : limit;
    for (int i=0; i<r; i++) {
      for (int j=0; j<c; j++) {
	printf("%3.1f ", M[i][j]);
      }
      printf("\n");
    }
  }

/*
  Multiply the matrices A and B and place the result in C.
  The matrices are assumed to be square of size N*N
*/
void matrixmult(double **A, double **B, double **C, const int N) {
  /* Fill in the code here */
  int i, j, k;
  for (i = 0; i < N; i++) {
    for (j = 0; j < N; j++) {
      C[i][j] = 0.0; // Initialize the element to zero
      for (k = 0; k < N; k++) {
        C[i][j] += A[i][k] * B[k][j];
      }
    }
  }
}

void matrixmult_ikj(double **A, double **B, double **C, const int N) {
  /* Fill in the code here */
  int i, j, k;
  for (int i = 0; i < N; i++) {
    for (int k = 0; k < N; k++) {
        double r = A[i][k]; // Loaded once outside the innermost loop
        for (int j = 0; j < N; j++) 
            C[i][j] += r * B[k][j]; // Accesses b[k][j] in the innermost loop
    }
  }
}

void matrixmult_jki(double **A, double **B, double **C, const int N) {
  /* Fill in the code here */
  int i, j, k;
  for (int j = 0; j < N; j++) {
    for (int k = 0; k < N; k++) {
        double r = B[k][j]; // Loaded once outside the innermost loop
        for (int i = 0; i < N; i++) 
            C[i][j] += A[i][k] * r; // Accesses a[i][k] in the innermost loop
    }
  }
}

void matrixmult_blocked(double **a, double **b, double **c, int N, int block_size) {
  for (int i = 0; i < N; i++) {
    for (int j = 0; j < N; j++) {
      c[i][j] = 0.0;
    }
  }


  for (int ii = 0; ii < N; ii += block_size) {
    for (int jj = 0; jj < N; jj += block_size) {
      for (int kk = 0; kk < N; kk += block_size) {
        int i_max = (ii + block_size > N) ? N : ii + block_size;
        int j_max = (jj + block_size > N) ? N : jj + block_size;
        int k_max = (kk + block_size > N) ? N : kk + block_size;
        for (int i = ii; i < i_max; i++) {
          for (int j = jj; j < j_max; j++) {
            c[i][j] = 0.0;
            for (int k = kk; k < k_max; k++) {
              c[i][j] += a[i][k] * b[k][j];
            }
          }
        }
      }
    }
  }
}


int main(int argc, char** argv) {
  
  int size = 1000;          // Default matrix size is 1000*1000
  clock_t start1, end1, start_ikj, start_jki, end_ikj, end_jki, start_block_l1, start_block_l2;

  // Check if a matrix size is given on the command line
  if (argc>1) {
    size = atoi(argv[1]);
  }

  // Allocate the matrices
  double **A = allocate_matrix(size, size);
  double **B = allocate_matrix(size, size);
  double **C = allocate_matrix(size, size);
  
  printf("Allocated matrices of size %d\n\n", size);

  // Initilaize the matrices with some values
  for (int i=0; i<size; i++) {
    for (int j=0; j<size; j++) {
	A[i][j] = (double)i;
	B[i][j] = (double)j;
	C[i][j] = 0.0;
    }
  }

  start1 = clock();    /* Start measuring time */
  // Do the matrix multiplication
  matrixmult(A, B, C, size);
  printf("Time for matrix multiplication %6.2f seconds\n", ((clock()-start1)/1000000.0));

  start_ikj = clock();
  matrixmult_ikj( A, B, C, size );
  printf("Time for matrix multiplication_ikj %6.2f seconds\n", ((clock()-start_ikj)/1000000.0));

  start_jki = clock();
  matrixmult_jki( A, B, C, size );
  printf("Time for matrix multiplication_ikj %6.2f seconds\n", ((clock()-start_jki)/1000000.0));

  // printf("start blocked multi L1 \n");
  // // l1
  // start_block_l1 = clock();
  // matrixmult_blocked( A, B, C, size, 512 );
  // printf("Time for matrix multiplication_blocked with L1 %6.2f seconds\n", ((clock()-start_block_l1)/1000000.0));

  // printf("start blocked multi L2 \n");
  // // l2
  // start_block_l2 = clock();
  // matrixmult_blocked( A, B, C, size, 1024 );
  // printf("Time for matrix multiplication_blocked with L2 %6.2f seconds\n", ((clock()-start_block_l2)/1000000.0));


  /*
  printf("Matrix A:\n");
  print_matrix(A, size, size, 10);

  printf("Matrix B:\n");
  print_matrix(B, size, size, 10);
  */
  end1 = clock();
  printf("Matrix C:\n");
  print_matrix(C, size, size, 10);
  printf("\nTime consumed: %d\n", end1 - start1);


  // Write the result to a file
  fwrite_matrix(C, size, size, "result.txt");

  free_matrix(A); free_matrix(B); free_matrix(C);
  exit(0);
}
