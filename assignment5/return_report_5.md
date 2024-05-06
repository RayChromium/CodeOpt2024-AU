## Weekly report 5  
This week's task was understanding some generated assembly code, including how are loops handled, how are the parameters passed to the procedures, and also some other features of assembly code including lines with no effect as well as the operation commands related to optimization.  
  
During the week when we were doing the exercise 5 together, Dione somehow was always not available because it was going through some maintenance, so we built and generated the assembly code on our own computers, for `saxpy.c` amd `call_max.c` I built on my laptop that has AMD Ryzen 7 5800H and the code is built according to the System V AMD64 ABI, whereas `med3.c` was built on Li Qing's macbook, which has an ARM cpu and the commands in the generated assembly code are slightly different.  
  
On my laptop the `saxpy.c` built result is more or less the same as the model solution, parrameters are passed in through:
- `n` : the edi register.  
- `alpha` : the xmm0 register.  
- `X` : in the rsi register.  
- `Y` : in the rdx register.  
  
And the loop is also initialized as follows:  
```asm
.LFB0:
	.cfi_startproc
	endbr64
	testl	%edi, %edi          ; testing n
	jle	.L1                     ; return
	movslq	%edi, %rdi
	xorl	%eax, %eax          ; i init to 0
	.p2align 4,,10
	.p2align 3
```
When it's compiled with full optimization flag `-O3`, it's 113 lines long ( almost 3 times as long as the `-O2` one in a ). I only noticed that there's more jump symbols, but seems like this has something to do with vectorization applied in the code.  
Compiling `saxpy.c` with `-O2` and `-mfpmath=387` gave me:
```asm
.L3:
	flds	(%rsi,%rax,4)
	fmul	%st(1), %st
	fadds	(%rdx,%rax,4)
	fstps	(%rdx,%rax,4)
	addq	$1, %rax
	cmpq	%rax, %rdi
	jne	.L3
	fstp	%st(0)
	jmp	.L1
	.p2align 4,,10
	.p2align 3
```
which is also similar to the model solution the assembly code uses x87 FPU instructions (flds, fmul, fadds, fstp, etc.) to handle floating-point operations.  

For  `med3.c`, it was built on a different platform (the Macbook with arm chips), which generated almost completely different assembly code with Macbook's operation commands. On the Macbook the parameters were passed in through registers called `w0`, `w1`, and `w2`, loops are implemented quite differently and there's no commands that has no effects.   
  
Then for the `call_max.c` basically the major difference is that by compiling with `-fno-inline` there would be a function call and jumping to the starting line of max function explicitly instead of inlining the whole max function. The generated assembly code on my own machine is very similar to the model solution.