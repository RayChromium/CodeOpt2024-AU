	.file	"saxpy.c"
	.text
	.p2align 4
	.globl	saxpy
	.type	saxpy, @function
saxpy:
.LFB0:
	.cfi_startproc
	endbr64
	movq	%rsi, %rcx
	testl	%edi, %edi
	jle	.L1
	leaq	4(%rsi), %rsi
	movq	%rdx, %rax
	subq	%rsi, %rax
	cmpq	$8, %rax
	jbe	.L3
	cmpl	$1, %edi
	je	.L3
	leal	-1(%rdi), %eax
	movl	%edi, %r8d
	cmpl	$2, %eax
	jbe	.L11
	movl	%edi, %esi
	movaps	%xmm0, %xmm2
	xorl	%eax, %eax
	shrl	$2, %esi
	shufps	$0, %xmm2, %xmm2
	salq	$4, %rsi
	.p2align 4,,10
	.p2align 3
.L5:
	movups	(%rcx,%rax), %xmm1
	movups	(%rdx,%rax), %xmm3
	mulps	%xmm2, %xmm1
	addps	%xmm3, %xmm1
	movups	%xmm1, (%rdx,%rax)
	addq	$16, %rax
	cmpq	%rsi, %rax
	jne	.L5
	movl	%edi, %esi
	andl	$-4, %esi
	movl	%esi, %eax
	cmpl	%esi, %edi
	je	.L1
	subl	%esi, %edi
	movl	%edi, %r8d
	cmpl	$1, %edi
	je	.L7
.L4:
	movq	(%rcx,%rsi,4), %xmm1
	movaps	%xmm0, %xmm2
	leaq	(%rdx,%rsi,4), %rdi
	movl	%r8d, %esi
	shufps	$0xe0, %xmm2, %xmm2
	andl	$-2, %esi
	mulps	%xmm2, %xmm1
	movq	(%rdi), %xmm2
	addl	%esi, %eax
	addps	%xmm2, %xmm1
	movlps	%xmm1, (%rdi)
	cmpl	%esi, %r8d
	je	.L1
.L7:
	cltq
	mulss	(%rcx,%rax,4), %xmm0
	leaq	(%rdx,%rax,4), %rdx
	addss	(%rdx), %xmm0
	movss	%xmm0, (%rdx)
	ret
	.p2align 4,,10
	.p2align 3
.L3:
	movslq	%edi, %rdi
	xorl	%eax, %eax
	.p2align 4,,10
	.p2align 3
.L9:
	movss	(%rcx,%rax,4), %xmm1
	mulss	%xmm0, %xmm1
	addss	(%rdx,%rax,4), %xmm1
	movss	%xmm1, (%rdx,%rax,4)
	addq	$1, %rax
	cmpq	%rdi, %rax
	jne	.L9
.L1:
	ret
.L11:
	xorl	%esi, %esi
	xorl	%eax, %eax
	jmp	.L4
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
