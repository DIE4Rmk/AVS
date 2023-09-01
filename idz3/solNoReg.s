	.file	"solution.c"
	.intel_syntax noprefix
	.text
	.globl	get_laplas_plus
	.type	get_laplas_plus, @function
get_laplas_plus:
.LFB6:
	.cfi_startproc
	endbr64
	push	rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	mov	rbp, rsp
	.cfi_def_cfa_register 6
	sub	rsp, 48
	movsd	QWORD PTR -40[rbp], xmm0
	mov	DWORD PTR -28[rbp], 2
	movsd	xmm0, QWORD PTR .LC0[rip]
	movsd	QWORD PTR -24[rbp], xmm0
	movsd	xmm1, QWORD PTR -40[rbp]
	movsd	xmm0, QWORD PTR .LC1[rip]
	addsd	xmm0, xmm1
	movsd	QWORD PTR -16[rbp], xmm0
.L5:
	pxor	xmm0, xmm0
	cvtsi2sd	xmm0, DWORD PTR -28[rbp]
	mov	rax, QWORD PTR -40[rbp]
	movapd	xmm1, xmm0
	movq	xmm0, rax
	call	pow@PLT
	movq	rax, xmm0
	movq	xmm0, rax
	divsd	xmm0, QWORD PTR -24[rbp]
	movsd	QWORD PTR -8[rbp], xmm0
	movsd	xmm0, QWORD PTR -16[rbp]
	addsd	xmm0, QWORD PTR -8[rbp]
	movsd	QWORD PTR -16[rbp], xmm0
	movsd	xmm0, QWORD PTR -8[rbp]
	cvttsd2si	eax, xmm0
	mov	edx, eax
	neg	edx
	cmovns	eax, edx
	pxor	xmm1, xmm1
	cvtsi2sd	xmm1, eax
	movsd	xmm2, QWORD PTR -16[rbp]
	movsd	xmm0, QWORD PTR .LC2[rip]
	mulsd	xmm0, xmm2
	comisd	xmm0, xmm1
	jb	.L7
	movsd	xmm0, QWORD PTR -16[rbp]
	jmp	.L8
.L7:
	add	DWORD PTR -28[rbp], 1
	pxor	xmm0, xmm0
	cvtsi2sd	xmm0, DWORD PTR -28[rbp]
	movsd	xmm1, QWORD PTR -24[rbp]
	mulsd	xmm0, xmm1
	movsd	QWORD PTR -24[rbp], xmm0
	jmp	.L5
.L8:
	movq	rax, xmm0
	movq	xmm0, rax
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE6:
	.size	get_laplas_plus, .-get_laplas_plus
	.section	.rodata
.LC3:
	.string	"%lf"
	.text
	.globl	main
	.type	main, @function
main:
.LFB7:
	.cfi_startproc
	endbr64
	push	rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	mov	rbp, rsp
	.cfi_def_cfa_register 6
	sub	rsp, 48
	mov	DWORD PTR -36[rbp], edi
	mov	QWORD PTR -48[rbp], rsi
	mov	rax, QWORD PTR fs:40
	mov	QWORD PTR -8[rbp], rax
	xor	eax, eax
	lea	rax, -32[rbp]
	mov	rsi, rax
	lea	rax, .LC3[rip]
	mov	rdi, rax
	mov	eax, 0
	call	__isoc99_scanf@PLT
	mov	rax, QWORD PTR -32[rbp]
	movq	xmm0, rax
	call	get_laplas_plus
	movq	rax, xmm0
	mov	QWORD PTR -24[rbp], rax
	movsd	xmm0, QWORD PTR .LC1[rip]
	divsd	xmm0, QWORD PTR -24[rbp]
	movsd	QWORD PTR -16[rbp], xmm0
	movsd	xmm0, QWORD PTR -24[rbp]
	subsd	xmm0, QWORD PTR -16[rbp]
	movsd	xmm1, QWORD PTR -24[rbp]
	addsd	xmm1, QWORD PTR -16[rbp]
	divsd	xmm0, xmm1
	movq	rax, xmm0
	movq	xmm0, rax
	lea	rax, .LC3[rip]
	mov	rdi, rax
	mov	eax, 1
	call	printf@PLT
	mov	eax, 0
	mov	rdx, QWORD PTR -8[rbp]
	sub	rdx, QWORD PTR fs:40
	je	.L11
	call	__stack_chk_fail@PLT
.L11:
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE7:
	.size	main, .-main
	.section	.rodata
	.align 8
.LC0:
	.long	0
	.long	1073741824
	.align 8
.LC1:
	.long	0
	.long	1072693248
	.align 8
.LC2:
	.long	-755914244
	.long	1061184077
	.ident	"GCC: (Ubuntu 11.2.0-19ubuntu1) 11.2.0"
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
