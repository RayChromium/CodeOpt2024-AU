## Exercise 5  
  
Somehow dione is not available these few days, so I'm building `saxpy.c` and `call_max.c` on my own laptopn. It has an AMD Ryzen 7 5800H and the code is built according to the System V AMD64 ABI.  
And my groupmate Li Qing is building `med3.c` on his macbook, which has an ARM cpu and the commands in the generated assembly code are slightly different.

### 1
#### a  

> How are the parameters passed to the procedure?  
  
In the assembly code for the saxpy function, parameters are passed according to the System V AMD64 ABI, which is standard for x86-64 Unix-like systems:
```asm
	.file	"saxpy.c"
	.text
	.p2align 4
	.globl	saxpy
	.type	saxpy, @function
saxpy:
.LFB0:
	.cfi_startproc
	endbr64
	testl	%edi, %edi
	jle	.L1
	movslq	%edi, %rdi
	xorl	%eax, %eax
	.p2align 4,,10
	.p2align 3
.L3:
	movss	(%rsi,%rax,4), %xmm1
	mulss	%xmm0, %xmm1
	addss	(%rdx,%rax,4), %xmm1
	movss	%xmm1, (%rdx,%rax,4)
	addq	$1, %rax
	cmpq	%rax, %rdi
	jne	.L3
.L1:
	ret
	.cfi_endproc
.LFE0:
	.size	saxpy, .-saxpy
	.ident	"GCC: (Ubuntu 11.4.0-1ubuntu1~22.04) 11.4.0"
	.section	.note.GNU-stack,"",@progbits
	.section	.note.gnu.property,"a"
	.align 8
	.long	1f - 0f
	.long	4f - 1f
	.long	5
0:
	.string	"GNU"
1:
	.align 8
	.long	0xc0000002
	.long	3f - 2f
2:
	.long	0x3
3:
	.align 8
4:

```
`n` is passed in the edi register.
`alpha` is passed in the xmm0 register.
`X` is passed in the rsi register.
`Y` is passed in the rdx register.

> How is the loop implemented?  
  
The `testl %edi, %edi instruction` checks if n is less than or equal to zero. If it is (`jle .L1`), the function exits immediately, jumping to the label .L1 which contains the ret instruction to return from the function.  
If `n` is greater than zero, the loop starts. The `movslq %edi, %rdi` instruction sign-extends the value from 32-bit edi to 64-bit rdi to use it for comparison in the 64-bit mode.
The loop counter is initialized to zero with `xorl %eax, %eax`.
The loop body starts at .L3.  
  
> How are the arithmetic operations done?  
  
`mulss %xmm0, %xmm1` multiplies the single-precision floating-point values in %xmm0 and %xmm1, storing the result in %xmm1.
`addss (%rdx,%rax,4), %xmm1` adds the value in memory at (%rdx,%rax,4) (an element of the Y array) to %xmm1, storing the result back in %xmm1.  
  
> Can you recognize any instructions that have no effect, i.e., that are inserted by the compiler to align branch targets?  
  
I'm not sure, but `.p2align 4,,10 and .p2align 3` before the loop label .L3 are probably used for some sort of alignment to increase performance.  
  
#### b  
The biggest difference is that the whole file is obviously bigger/contains more lines....and also more symbols. That means the whole generated code is using more sophisticated branching and loop criteria evaluations to increase performance.  
  
#### c  
The structure of this one is still similar, the loop is still implemented in the .L3 symbol block:
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
However the commands are totally different, so the assembly code uses x87 FPU instructions (flds, fmul, fadds, fstp, etc.) to handle floating-point operations.  
  
### 2  
The generated assembly code from Li's Macbook looks like this:  
```asm
	.section	__TEXT,__text,regular,pure_instructions
	.build_version macos, 12, 0	sdk_version 13, 1
	.globl	_med3                           ; -- Begin function med3
	.p2align	2
_med3:                                  ; @med3
	.cfi_startproc
; %bb.0:
	cmp	w0, w2
	csel	w8, w0, w2, gt
	cmp	w1, w2
	csel	w8, w1, w8, le
	cmp	w2, w0
	csel	w9, w2, w0, lt
	cmp	w2, w1
	csel	w9, w1, w9, le
	cmp	w0, w1
	csel	w0, w8, w9, le
	ret
	.cfi_endproc
                                        ; -- End function
.subsections_via_symbols
```
1. *Parameters Passing*:
    - The _med3 function takes three parameters, which are passed in registers w0, w1, and w2.  
    - The parameters are compared and manipulated within the function to determine the median value.  
2. *Loop Implementation*:  
    - There is no explicit loop in this code snippet. The function performs a series of conditional comparisons and selections, but there is no looping construct like for or while.  
3. *Arithmetic Operations*:  
    - The arithmetic operations in this code involve conditional selection (csel) based on the comparison results.  
    - The csel instruction selects one of two values based on a condition (greater than or less than).  
    - For example, csel w8, w0, w2, gt means that if w0 is greater than w2, then w8 gets the value of w0, otherwise it gets the value of w2.  
4. *Instructions with No Effect*:  
    - There are no instructions in this code snippet that have no effect or are inserted solely for branch target alignment.    
    
### 3  
Now the `call_max.c` is calling the `int max(int a, int b)` inside of a loop in `void select (int *a, int *b, int len)`.   
#### a  
Compiling with `-fno-inline` generated a whole bunch of symbols that seems to be used for debugging, and the functions seems to be implemented like this in the symbols with their names:  
```asm
max:
.LVL0:
.LFB0:
	.file 1 "call_max.c"
	.loc 1 1 23 view -0
	.cfi_startproc
	.loc 1 1 23 is_stmt 0 view .LVU1
	endbr64
	.loc 1 2 3 is_stmt 1 view .LVU2
	.loc 1 4 1 is_stmt 0 view .LVU3
	cmpl	%esi, %edi
	movl	%esi, %eax
	cmovge	%edi, %eax
	ret
	.cfi_endproc
.LFE0:
	.size	max, .-max
	.p2align 4
	.globl	select
	.type	select, @function
select:
.LVL1:
.LFB1:
	.loc 1 6 39 is_stmt 1 view -0
	.cfi_startproc
	.loc 1 6 39 is_stmt 0 view .LVU5
	endbr64
	.loc 1 8 3 is_stmt 1 view .LVU6
.LBB2:
	.loc 1 8 8 view .LVU7
.LVL2:
	.loc 1 8 18 view .LVU8
	testl	%edx, %edx
	jle	.L3
	leal	-1(%rdx), %eax
	movq	%rsi, %rcx
	movq	%rdi, %r8
	leaq	4(%rsi,%rax,4), %rdx
.LVL3:
	.p2align 4,,10
	.p2align 3
.L5:
	.loc 1 9 5 discriminator 3 view .LVU9
	.loc 1 9 12 is_stmt 0 discriminator 3 view .LVU10
	movl	(%rcx), %esi
	movl	(%r8), %edi
	.loc 1 8 18 discriminator 3 view .LVU11
	addq	$4, %rcx
.LVL4:
	.loc 1 8 18 discriminator 3 view .LVU12
	addq	$4, %r8
	.loc 1 9 12 discriminator 3 view .LVU13
	call	max
.LVL5:
	.loc 1 9 10 discriminator 3 view .LVU14
	movl	%eax, -4(%r8)
	.loc 1 8 25 is_stmt 1 discriminator 3 view .LVU15
.LVL6:
	.loc 1 8 18 discriminator 3 view .LVU16
	cmpq	%rdx, %rcx
	jne	.L5
.L3:
.LBE2:
	.loc 1 12 1 is_stmt 0 view .LVU17
	ret
	.cfi_endproc
```
However the `-fno-inline` flag essentially is used to prevent the automatic inlining of functions during the compilation process, that's why we can explicitely see this line:
```asm
call	max
```
in symbol `.LVL4`, if I remembered correctly this would store the current program counter register and other context of the execution and just jump to the function symbol. And at the end of the functions/symbols (for example in `.LFB0` and `.LFB2`) there's always these 2 lines:
```
	ret
	.cfi_endproc
```
This would restore the registered states when the program was executing in the calling function.  

#### b  
This time building without `-fno-inline`, the function bodies snippets look like this:  
```asm
max:
.LVL0:
.LFB0:
	.file 1 "call_max.c"
	.loc 1 1 23 view -0
	.cfi_startproc
	.loc 1 1 23 is_stmt 0 view .LVU1
	endbr64
	.loc 1 2 3 is_stmt 1 view .LVU2
	.loc 1 4 1 is_stmt 0 view .LVU3
	cmpl	%esi, %edi
	movl	%esi, %eax
	cmovge	%edi, %eax
	ret
	.cfi_endproc
.LFE0:
	.size	max, .-max
	.p2align 4
	.globl	select
	.type	select, @function
select:
.LVL1:
.LFB1:
	.loc 1 6 39 is_stmt 1 view -0
	.cfi_startproc
	.loc 1 6 39 is_stmt 0 view .LVU5
	endbr64
	.loc 1 8 3 is_stmt 1 view .LVU6
.LBB5:
	.loc 1 8 8 view .LVU7
.LVL2:
	.loc 1 8 18 view .LVU8
	testl	%edx, %edx
	jle	.L3
	movslq	%edx, %rdx
	.loc 1 8 18 is_stmt 0 view .LVU9
	xorl	%eax, %eax
.LVL3:
	.p2align 4,,10
	.p2align 3
.L5:
	.loc 1 9 5 is_stmt 1 discriminator 3 view .LVU10
	.loc 1 9 10 is_stmt 0 discriminator 3 view .LVU11
	movl	(%rdi,%rax,4), %ecx
	movl	(%rsi,%rax,4), %r8d
	cmpl	%r8d, %ecx
	cmovl	%r8d, %ecx
	movl	%ecx, (%rdi,%rax,4)
	.loc 1 8 25 is_stmt 1 discriminator 3 view .LVU12
.LVL4:
	.loc 1 8 18 discriminator 3 view .LVU13
	addq	$1, %rax
.LVL5:
	.loc 1 8 18 is_stmt 0 discriminator 3 view .LVU14
	cmpq	%rax, %rdx
	jne	.L5
.LVL6:
.L3:
	.loc 1 8 18 discriminator 3 view .LVU15
.LBE5:
	.loc 1 12 1 view .LVU16
	ret
	.cfi_endproc
```
Clearly this time there's no `call` commands, and looks like in `select` function this part:  
```asm
.L5:
	.loc 1 9 5 is_stmt 1 discriminator 3 view .LVU10
	.loc 1 9 10 is_stmt 0 discriminator 3 view .LVU11
	movl	(%rdi,%rax,4), %ecx
	movl	(%rsi,%rax,4), %r8d
	cmpl	%r8d, %ecx
	cmovl	%r8d, %ecx
	movl	%ecx, (%rdi,%rax,4)
	.loc 1 8 25 is_stmt 1 discriminator 3 view .LVU12
```
is doing the same thing as `max`, so the compiler just inlined the `max` function into symbol `.L5`