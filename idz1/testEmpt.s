	.file	"test.c"
	.intel_syntax noprefix
	.text
	.globl	sign
	.type	sign, @function
sign:
.LFB6:
	.cfi_startproc
	endbr64
	push	rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	mov	rbp, rsp
	.cfi_def_cfa_register 6
	mov	DWORD PTR -4[rbp], edi
	cmp	DWORD PTR -4[rbp], 0
	setne	al
	movzx	edx, al
	mov	eax, DWORD PTR -4[rbp]
	sar	eax, 31
	or	eax, edx
	pop	rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE6:
	.size	sign, .-sign
	.globl	mod_arr
	.type	mod_arr, @function
mod_arr:
.LFB7:
	.cfi_startproc
	endbr64
	push	rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	mov	rbp, rsp
	.cfi_def_cfa_register 6
	push	rbx
	sub	rsp, 40
	.cfi_offset 3, -24
	mov	QWORD PTR -40[rbp], rdi
	mov	DWORD PTR -44[rbp], esi
	mov	eax, DWORD PTR -44[rbp]
	cdqe
	sal	rax, 2
	mov	rdi, rax
	call	malloc@PLT
	mov	QWORD PTR -24[rbp], rax
	mov	DWORD PTR -28[rbp], 0
	jmp	.L4
.L5:
	mov	eax, DWORD PTR -28[rbp]
	cdqe
	lea	rdx, 0[0+rax*4]
	mov	rax, QWORD PTR -40[rbp]
	add	rax, rdx
	mov	eax, DWORD PTR [rax]
	mov	edx, DWORD PTR -28[rbp]
	movsx	rdx, edx
	lea	rcx, 0[0+rdx*4]
	mov	rdx, QWORD PTR -24[rbp]
	lea	rbx, [rcx+rdx]
	mov	edi, eax
	call	sign
	mov	DWORD PTR [rbx], eax
	add	DWORD PTR -28[rbp], 1
.L4:
	mov	eax, DWORD PTR -28[rbp]
	cmp	eax, DWORD PTR -44[rbp]
	jl	.L5
	mov	rax, QWORD PTR -24[rbp]
	mov	rbx, QWORD PTR -8[rbp]
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE7:
	.size	mod_arr, .-mod_arr
	.section	.rodata
.LC0:
	.string	"%d "
	.text
	.globl	main
	.type	main, @function
main:
.LFB8:
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
	mov	eax, DWORD PTR -36[rbp]
	sub	eax, 1
	mov	DWORD PTR -20[rbp], eax
	mov	eax, DWORD PTR -20[rbp]
	cdqe
	sal	rax, 2
	mov	rdi, rax
	call	malloc@PLT
	mov	QWORD PTR -16[rbp], rax
	mov	DWORD PTR -28[rbp], 0
	jmp	.L8
.L9:
	mov	eax, DWORD PTR -28[rbp]
	cdqe
	add	rax, 1
	lea	rdx, 0[0+rax*8]
	mov	rax, QWORD PTR -48[rbp]
	add	rax, rdx
	mov	rax, QWORD PTR [rax]
	mov	edx, 10
	mov	esi, 0
	mov	rdi, rax
	call	strtol@PLT
	mov	edx, DWORD PTR -28[rbp]
	movsx	rdx, edx
	lea	rcx, 0[0+rdx*4]
	mov	rdx, QWORD PTR -16[rbp]
	add	rdx, rcx
	mov	DWORD PTR [rdx], eax
	add	DWORD PTR -28[rbp], 1
.L8:
	mov	eax, DWORD PTR -28[rbp]
	cmp	eax, DWORD PTR -20[rbp]
	jl	.L9
	mov	edx, DWORD PTR -20[rbp]
	mov	rax, QWORD PTR -16[rbp]
	mov	esi, edx
	mov	rdi, rax
	call	mod_arr
	mov	QWORD PTR -8[rbp], rax
	mov	DWORD PTR -24[rbp], 0
	jmp	.L10
.L11:
	mov	eax, DWORD PTR -24[rbp]
	cdqe
	lea	rdx, 0[0+rax*4]
	mov	rax, QWORD PTR -8[rbp]
	add	rax, rdx
	mov	eax, DWORD PTR [rax]
	mov	esi, eax
	lea	rax, .LC0[rip]
	mov	rdi, rax
	mov	eax, 0
	call	printf@PLT
	add	DWORD PTR -24[rbp], 1
.L10:
	mov	eax, DWORD PTR -24[rbp]
	cmp	eax, DWORD PTR -20[rbp]
	jl	.L11
	mov	edi, 10
	call	putchar@PLT
	mov	rax, QWORD PTR -16[rbp]
	mov	rdi, rax
	call	free@PLT
	mov	rax, QWORD PTR -8[rbp]
	mov	rdi, rax
	call	free@PLT
	mov	eax, 0
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE8:
	.size	main, .-main
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
