	.file	"saxpy.c"
	.text
	.p2align 4
	.globl	saxpy
	.type	saxpy, @function
saxpy:
.LFB0:
	.cfi_startproc
	endbr64
	movss	%xmm0, -4(%rsp)
	flds	-4(%rsp)
	testl	%edi, %edi
	jle	.L6
	movslq	%edi, %rdi
	xorl	%eax, %eax
	.p2align 4,,10
	.p2align 3
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
.L6:
	fstp	%st(0)
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
