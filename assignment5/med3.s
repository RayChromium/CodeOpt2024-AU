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
