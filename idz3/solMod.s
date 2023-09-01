	.text
	.globl	get_laplas_plus			#Начало секции
	.type	get_laplas_plus, @function
get_laplas_plus:				#Ф-ия степенного ряда для тангенса
	push	rbp
	mov	rbp, rsp
	push	r12				#Используем свой регистр r12 для i
	sub	rsp, 56				#rsp -= 56
	movsd	QWORD PTR -56[rbp], xmm0	# передан x
	mov	r12d, 2				#i = 2
	movsd	xmm0, QWORD PTR .LC0[rip]	#переменная factor = 2
	movsd	QWORD PTR -24[rbp], xmm0     	
	movsd	xmm1, QWORD PTR -56[rbp]	#переменная rez1 = x+1
	movsd	xmm0, QWORD PTR .LC1[rip]	#|
	addsd	xmm0, xmm1			#|
	movsd	QWORD PTR -32[rbp], xmm0	#\
.L5:
	mov	eax, r12d			#(pow(x, i) / factor);
	pxor	xmm0, xmm0
	cvtsi2sd	xmm0, eax
	mov	rax, QWORD PTR -56[rbp]
	movapd	xmm1, xmm0
	movq	xmm0, rax
	call	pow@PLT
	movq	rax, xmm0
	movq	xmm0, rax
	divsd	xmm0, QWORD PTR -24[rbp]
	movsd	QWORD PTR -40[rbp], xmm0	#lambda1 = ...
	movsd	xmm0, QWORD PTR -32[rbp]	#rez1 += lamda1
	addsd	xmm0, QWORD PTR -40[rbp]
	movsd	QWORD PTR -32[rbp], xmm0
	movsd	xmm0, QWORD PTR -40[rbp]	
	cvttsd2si	eax, xmm0		#abs(lambda1)
	mov	edx, eax
	neg	edx
	cmovns	eax, edx
	pxor	xmm1, xmm1
	cvtsi2sd	xmm1, eax
	movsd	xmm2, QWORD PTR -32[rbp]	
	movsd	xmm0, QWORD PTR .LC2[rip]
	mulsd	xmm0, xmm2
	comisd	xmm0, xmm1			#abs(lambda1) <= (0.0005 * rez1)
	jb	.L7
	movsd	xmm0, QWORD PTR -32[rbp]
	jmp	.L8
.L7:
	mov	eax, r12d
	add	eax, 1				#i += 1
	mov	r12d, eax
	mov	eax, r12d
	pxor	xmm0, xmm0
	cvtsi2sd	xmm0, eax		#factor *= i;
	movsd	xmm1, QWORD PTR -24[rbp]
	mulsd	xmm0, xmm1
	movsd	QWORD PTR -24[rbp], xmm0
	jmp	.L5
.L8:
	movq	rax, xmm0
	movq	xmm0, rax
	mov	r12, QWORD PTR -8[rbp]
	leave
	ret
	.size	get_laplas_plus, .-get_laplas_plus
	.section	.rodata
.LC3:
	.string	"%lf"
	.text
	.globl	main
	.type	main, @function
main:
	push	rbp					# /Сохраняем rbp на стек
	mov	rbp, rsp				# |rbp := rsp
	sub	rsp, 48					# \rsp -= 48
	mov	DWORD PTR -36[rbp], edi			# edi - 1й - argc - 32bit
	mov	QWORD PTR -48[rbp], rsi			# rsi - 2й - argv - 64bit
	lea	rax, -24[rbp]				# Вводим перееменную double x
	mov	rsi, rax
	lea	rax, .LC3[rip]
	mov	rdi, rax
	mov	eax, 0
	call	__isoc99_scanf@PLT
	mov	rax, QWORD PTR -24[rbp]
	movq	xmm0, rax
	call	get_laplas_plus
	movq	rax, xmm0
	mov	QWORD PTR -8[rbp], rax			#Вызываем ф-ию, рез-тат в rez1
	movsd	xmm0, QWORD PTR .LC1[rip]		
	divsd	xmm0, QWORD PTR -8[rbp]
	movsd	QWORD PTR -16[rbp], xmm0		#Обратная к rez1 - rez2 (1/rez1)
	movsd	xmm0, QWORD PTR -8[rbp]
	subsd	xmm0, QWORD PTR -16[rbp]
	movsd	xmm1, QWORD PTR -8[rbp]			#printf("%lf",(rez1-rez2)/(rez1+rez2));
	addsd	xmm1, QWORD PTR -16[rbp]
	divsd	xmm0, xmm1
	movq	rax, xmm0
	movq	xmm0, rax
	lea	rax, .LC3[rip]
	mov	rdi, rax
	mov	eax, 1
	call	printf@PLT
	mov	eax, 0
	leave						#Выход из ф-ии
	ret
	.size	main, .-main
	.section	.rodata
	.align 8
.LC0:							#все для double
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
