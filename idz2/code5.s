	.file	"code5.c"
	.intel_syntax noprefix
	.text
	.globl	arr
	.bss
	.align 32
	.type	arr, @object
	.size	arr, 10000
arr:
	.zero	10000
	.section	.rodata
.LC0:
	.string	"0x%x"
	.text
	.globl	mod_arr
	.type	mod_arr, @function
mod_arr:
.LFB6:
	.cfi_startproc
	endbr64
	push	rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	mov	rbp, rsp
	.cfi_def_cfa_register 6
	sub	rsp, 32
	mov	QWORD PTR -24[rbp], rdi
	mov	DWORD PTR -28[rbp], esi
	mov	DWORD PTR -4[rbp], 0
	jmp	.L2
.L6:
	mov	eax, DWORD PTR -4[rbp]
	movsx	rdx, eax
	mov	rax, QWORD PTR -24[rbp]
	add	rax, rdx
	movzx	eax, BYTE PTR [rax]
	mov	BYTE PTR -5[rbp], al
	cmp	BYTE PTR -5[rbp], 97
	je	.L3
	cmp	BYTE PTR -5[rbp], 101
	je	.L3
	cmp	BYTE PTR -5[rbp], 105
	je	.L3
	cmp	BYTE PTR -5[rbp], 111
	je	.L3
	cmp	BYTE PTR -5[rbp], 117
	je	.L3
	cmp	BYTE PTR -5[rbp], 121
	jne	.L4
.L3:
	mov	eax, DWORD PTR -4[rbp]
	movsx	rdx, eax
	mov	rax, QWORD PTR -24[rbp]
	add	rax, rdx
	movzx	eax, BYTE PTR [rax]
	movsx	eax, al
	mov	esi, eax
	lea	rax, .LC0[rip]
	mov	rdi, rax
	mov	eax, 0
	call	printf@PLT
	jmp	.L5
.L4:
	mov	eax, DWORD PTR -4[rbp]
	movsx	rdx, eax
	mov	rax, QWORD PTR -24[rbp]
	add	rax, rdx
	movzx	eax, BYTE PTR [rax]
	movsx	eax, al
	mov	edi, eax
	call	putchar@PLT
.L5:
	add	DWORD PTR -4[rbp], 1
.L2:
	mov	eax, DWORD PTR -4[rbp]
	cmp	eax, DWORD PTR -28[rbp]
	jl	.L6
	nop
	nop
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE6:
	.size	mod_arr, .-mod_arr
	.section	.rodata
.LC1:
	.string	"ERROR. INPUT TOO BIG-UWU"
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
	sub	rsp, 32
	mov	DWORD PTR -20[rbp], edi
	mov	QWORD PTR -32[rbp], rsi
	mov	DWORD PTR -4[rbp], 0
.L9:
	mov	rax, QWORD PTR stdin[rip]
	mov	rdi, rax
	call	fgetc@PLT
	mov	BYTE PTR -5[rbp], al
	mov	eax, DWORD PTR -4[rbp]
	lea	edx, 1[rax]
	mov	DWORD PTR -4[rbp], edx
	cdqe
	lea	rcx, arr[rip]
	movzx	edx, BYTE PTR -5[rbp]
	mov	BYTE PTR [rax+rcx], dl
	cmp	BYTE PTR -5[rbp], -1
	je	.L8
	cmp	DWORD PTR -4[rbp], 9999
	jle	.L9
.L8:
	sub	DWORD PTR -4[rbp], 1
	cmp	BYTE PTR -5[rbp], -1
	je	.L10
	cmp	DWORD PTR -4[rbp], 9999
	jle	.L10
	lea	rax, .LC1[rip]
	mov	rdi, rax
	mov	eax, 0
	call	printf@PLT
	mov	eax, 0
	jmp	.L11
.L10:
	mov	edi, 10
	call	putchar@PLT
	mov	eax, DWORD PTR -4[rbp]
	mov	esi, eax
	lea	rax, arr[rip]
	mov	rdi, rax
	call	mod_arr
	mov	eax, 0
.L11:
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE7:
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
