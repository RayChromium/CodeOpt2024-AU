	.file	"call_max.c"
	.text
.Ltext0:
	.file 0 "/home/rui/codeopt_as5" "call_max.c"
	.p2align 4
	.globl	max
	.type	max, @function
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
.LFE1:
	.size	select, .-select
.Letext0:
	.section	.debug_info,"",@progbits
.Ldebug_info0:
	.long	0xeb
	.value	0x5
	.byte	0x1
	.byte	0x8
	.long	.Ldebug_abbrev0
	.uleb128 0x4
	.long	.LASF2
	.byte	0x1d
	.long	.LASF0
	.long	.LASF1
	.quad	.Ltext0
	.quad	.Letext0-.Ltext0
	.long	.Ldebug_line0
	.uleb128 0x5
	.long	.LASF3
	.byte	0x1
	.byte	0x6
	.byte	0x6
	.quad	.LFB1
	.quad	.LFE1-.LFB1
	.uleb128 0x1
	.byte	0x9c
	.long	0x99
	.uleb128 0x1
	.string	"a"
	.byte	0x13
	.long	0x99
	.uleb128 0x1
	.byte	0x55
	.uleb128 0x1
	.string	"b"
	.byte	0x1b
	.long	0x99
	.uleb128 0x1
	.byte	0x54
	.uleb128 0x6
	.string	"len"
	.byte	0x1
	.byte	0x6
	.byte	0x22
	.long	0x9f
	.long	.LLST0
	.long	.LVUS0
	.uleb128 0x7
	.quad	.LBB5
	.quad	.LBE5-.LBB5
	.uleb128 0x8
	.string	"i"
	.byte	0x1
	.byte	0x8
	.byte	0xc
	.long	0x9f
	.long	.LLST1
	.long	.LVUS1
	.byte	0
	.byte	0
	.uleb128 0x9
	.byte	0x8
	.long	0x9f
	.uleb128 0xa
	.byte	0x4
	.byte	0x5
	.string	"int"
	.uleb128 0xb
	.string	"max"
	.byte	0x1
	.byte	0x1
	.byte	0x5
	.long	0x9f
	.byte	0x1
	.long	0xc8
	.uleb128 0x2
	.string	"a"
	.byte	0xd
	.long	0x9f
	.uleb128 0x2
	.string	"b"
	.byte	0x14
	.long	0x9f
	.byte	0
	.uleb128 0xc
	.long	0xa6
	.quad	.LFB0
	.quad	.LFE0-.LFB0
	.uleb128 0x1
	.byte	0x9c
	.uleb128 0x3
	.long	0xb7
	.uleb128 0x1
	.byte	0x55
	.uleb128 0x3
	.long	0xbf
	.uleb128 0x1
	.byte	0x54
	.byte	0
	.byte	0
	.section	.debug_abbrev,"",@progbits
.Ldebug_abbrev0:
	.uleb128 0x1
	.uleb128 0x5
	.byte	0
	.uleb128 0x3
	.uleb128 0x8
	.uleb128 0x3a
	.uleb128 0x21
	.sleb128 1
	.uleb128 0x3b
	.uleb128 0x21
	.sleb128 6
	.uleb128 0x39
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x2
	.uleb128 0x18
	.byte	0
	.byte	0
	.uleb128 0x2
	.uleb128 0x5
	.byte	0
	.uleb128 0x3
	.uleb128 0x8
	.uleb128 0x3a
	.uleb128 0x21
	.sleb128 1
	.uleb128 0x3b
	.uleb128 0x21
	.sleb128 1
	.uleb128 0x39
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x3
	.uleb128 0x5
	.byte	0
	.uleb128 0x31
	.uleb128 0x13
	.uleb128 0x2
	.uleb128 0x18
	.byte	0
	.byte	0
	.uleb128 0x4
	.uleb128 0x11
	.byte	0x1
	.uleb128 0x25
	.uleb128 0xe
	.uleb128 0x13
	.uleb128 0xb
	.uleb128 0x3
	.uleb128 0x1f
	.uleb128 0x1b
	.uleb128 0x1f
	.uleb128 0x11
	.uleb128 0x1
	.uleb128 0x12
	.uleb128 0x7
	.uleb128 0x10
	.uleb128 0x17
	.byte	0
	.byte	0
	.uleb128 0x5
	.uleb128 0x2e
	.byte	0x1
	.uleb128 0x3f
	.uleb128 0x19
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x39
	.uleb128 0xb
	.uleb128 0x27
	.uleb128 0x19
	.uleb128 0x11
	.uleb128 0x1
	.uleb128 0x12
	.uleb128 0x7
	.uleb128 0x40
	.uleb128 0x18
	.uleb128 0x7a
	.uleb128 0x19
	.uleb128 0x1
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x6
	.uleb128 0x5
	.byte	0
	.uleb128 0x3
	.uleb128 0x8
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x39
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x2
	.uleb128 0x17
	.uleb128 0x2137
	.uleb128 0x17
	.byte	0
	.byte	0
	.uleb128 0x7
	.uleb128 0xb
	.byte	0x1
	.uleb128 0x11
	.uleb128 0x1
	.uleb128 0x12
	.uleb128 0x7
	.byte	0
	.byte	0
	.uleb128 0x8
	.uleb128 0x34
	.byte	0
	.uleb128 0x3
	.uleb128 0x8
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x39
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x2
	.uleb128 0x17
	.uleb128 0x2137
	.uleb128 0x17
	.byte	0
	.byte	0
	.uleb128 0x9
	.uleb128 0xf
	.byte	0
	.uleb128 0xb
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0xa
	.uleb128 0x24
	.byte	0
	.uleb128 0xb
	.uleb128 0xb
	.uleb128 0x3e
	.uleb128 0xb
	.uleb128 0x3
	.uleb128 0x8
	.byte	0
	.byte	0
	.uleb128 0xb
	.uleb128 0x2e
	.byte	0x1
	.uleb128 0x3f
	.uleb128 0x19
	.uleb128 0x3
	.uleb128 0x8
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x39
	.uleb128 0xb
	.uleb128 0x27
	.uleb128 0x19
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x20
	.uleb128 0xb
	.uleb128 0x1
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0xc
	.uleb128 0x2e
	.byte	0x1
	.uleb128 0x31
	.uleb128 0x13
	.uleb128 0x11
	.uleb128 0x1
	.uleb128 0x12
	.uleb128 0x7
	.uleb128 0x40
	.uleb128 0x18
	.uleb128 0x7a
	.uleb128 0x19
	.byte	0
	.byte	0
	.byte	0
	.section	.debug_loclists,"",@progbits
	.long	.Ldebug_loc3-.Ldebug_loc2
.Ldebug_loc2:
	.value	0x5
	.byte	0x8
	.byte	0
	.long	0
.Ldebug_loc0:
.LVUS0:
	.uleb128 0
	.uleb128 .LVU15
	.uleb128 .LVU15
	.uleb128 0
.LLST0:
	.byte	0x4
	.uleb128 .LVL1-.Ltext0
	.uleb128 .LVL6-.Ltext0
	.uleb128 0x1
	.byte	0x51
	.byte	0x4
	.uleb128 .LVL6-.Ltext0
	.uleb128 .LFE1-.Ltext0
	.uleb128 0x4
	.byte	0xa3
	.uleb128 0x1
	.byte	0x51
	.byte	0x9f
	.byte	0
.LVUS1:
	.uleb128 .LVU8
	.uleb128 .LVU10
	.uleb128 .LVU10
	.uleb128 .LVU13
	.uleb128 .LVU13
	.uleb128 .LVU14
.LLST1:
	.byte	0x4
	.uleb128 .LVL2-.Ltext0
	.uleb128 .LVL3-.Ltext0
	.uleb128 0x2
	.byte	0x30
	.byte	0x9f
	.byte	0x4
	.uleb128 .LVL3-.Ltext0
	.uleb128 .LVL4-.Ltext0
	.uleb128 0x1
	.byte	0x50
	.byte	0x4
	.uleb128 .LVL4-.Ltext0
	.uleb128 .LVL5-.Ltext0
	.uleb128 0x3
	.byte	0x70
	.sleb128 1
	.byte	0x9f
	.byte	0
.Ldebug_loc3:
	.section	.debug_aranges,"",@progbits
	.long	0x2c
	.value	0x2
	.long	.Ldebug_info0
	.byte	0x8
	.byte	0
	.value	0
	.value	0
	.quad	.Ltext0
	.quad	.Letext0-.Ltext0
	.quad	0
	.quad	0
	.section	.debug_line,"",@progbits
.Ldebug_line0:
	.section	.debug_str,"MS",@progbits,1
.LASF2:
	.string	"GNU C17 11.4.0 -mtune=generic -march=x86-64 -g -O2 -fasynchronous-unwind-tables -fstack-protector-strong -fstack-clash-protection -fcf-protection"
.LASF3:
	.string	"select"
	.section	.debug_line_str,"MS",@progbits,1
.LASF0:
	.string	"call_max.c"
.LASF1:
	.string	"/home/rui/codeopt_as5"
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
