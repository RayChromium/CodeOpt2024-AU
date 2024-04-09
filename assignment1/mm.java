import java.io.*;
import java.util.Scanner;
import java.lang.System;

public class mm {

    /* Multiply the square matrices A and B and return the result */
    public static double [][] matrixmult(double [][]A, double [][]B) {
	  /* Fill in the code here */
	  int N=A.length;
	  double [][]C = new double[N][N];
  
	  for (int i = 0; i < N; i++) {
          for (int j = 0; j < N; j++) {
              for (int k = 0; k < N; k++) {
                  C[i][j] += A[i][k] * B[k][j];
              }
          }
      }
	  
	  return C;
    }
    
    /* Print out the first limit*limit elements of a 2D matrix */
  public static void print_matrix(double [][]M, int limit) {
      int rows = M.length;
      int cols = M[0].length;

      int r = (rows<limit) ? rows : limit;    // Set the limiits
      int c = (cols<limit) ? cols : limit;

      for (int i=0; i<r; i++) {
	  for (int j=0; j<c; j++) {
	      System.out.print(M[i][j] + " ");
	  }
	  System.out.println();
      }
  }
    
    public static void main (String[] args) {
	System.out.println("Matrix multiplication");
	Scanner sc = new Scanner(System.in);

	int size = 1000;    // Default matrix size is 1000*1000

	// Check if matrix size is given as an argument
	if (args.length > 0) {
	    try {
		size = Integer.parseInt(args[0]);  // Matrix size
	    } catch (NumberFormatException e) {
		System.err.println("Argument " + args[0] + " should be an integer");
		System.exit(-1);
	    }
	}
	
	System.out.println("Size is " + size);

	// Create matrices of double values
	double [][]A = new double[size][size];
	double [][]B = new double[size][size];
	double [][]C = new double[size][size];

	  // Initilaize the matrices
	for (int i=0; i<size; i++) {
	    for (int j=0; j<size; j++) {
		A[i][j] = (double)i;
		B[i][j] = (double)j;
		C[i][j] = 0.0;
	    }
	}

	long startTime = System.currentTimeMillis();
	C = matrixmult(A, B);
	System.out.println("Time: " + (System.currentTimeMillis()-startTime)/1000.0 + " seconds" );

	// Print some values from the result
	print_matrix(C, 20);
	System.out.println();
    }

}
