	.intel_syntax noprefix
	.text					#Начало секции.
	.globl	sign
	.type	sign, @function
sign:						# Функция "sign" - модификация числа по правилу задания.
	push	rbp
	mov	rbp, rsp
	mov	DWORD PTR -4[rbp], edi		# rbp[-4] = edi - лежит переданная переменная а
	cmp	DWORD PTR -4[rbp], 0		# Сравнение 0 с переменной а
	setne	al
	movzx	edx, al				# edx = 0 or 1
	mov	eax, DWORD PTR -4[rbp]		# a >> 31
	sar	eax, 31
	or	eax, edx			# Возварщаем одно из двух (eax ir edx) как результат '|'
	pop	rbp
	ret					# Функция отработала
	.size	sign, .-sign
	.globl	mod_arr
	.type	mod_arr, @function
mod_arr:					# Функция "mod_arr"- модификация массива с использованием ф-ии "sign"
	push	rbp
	mov	rbp, rsp
	push	rbx
	sub	rsp, 40
	mov	QWORD PTR -40[rbp], rdi		# Записали на стек переданный массив а
	mov	DWORD PTR -44[rbp], esi		# -//- переменную n
	mov	eax, DWORD PTR -44[rbp]
	cdqe					# sign-extend - (PS не убирать! Может привести к exception)
	sal	rax, 2
	mov	rdi, rax
	call	malloc@PLT			# malloc(n * sizeof(*a))
	mov	QWORD PTR -32[rbp], rax		# в локальный массив *b записали рузельтат от malloc
	mov	DWORD PTR -20[rbp], 0		# Счетчик i
	jmp	.L4
.L5:
	mov	eax, DWORD PTR -20[rbp]		# eax = i
	cdqe					# sign-extend
	lea	rdx, 0[0+rax*4]			# Вычисление смещения для индексации в массиве - rdx = rax  *4
	mov	rax, QWORD PTR -40[rbp]		# rax = rbp[-40] - # Аргумент *arr из mod_arr
	add	rax, rdx			#/
	mov	eax, DWORD PTR [rax]		# eax = результат sign (который на стеке в rax)
	mov	edx, DWORD PTR -20[rbp]		#|
	movsx	rdx, edx			#| b[i] = sign(arr[i]) - результат sign идет в b[i]
	lea	rcx, 0[0+rdx*4]			#|
	mov	rdx, QWORD PTR -32[rbp]		#|
	lea	rbx, [rcx+rdx]			#|
	mov	edi, eax			#|
	call	sign				# int sign(int a)
	mov	DWORD PTR [rbx], eax
	add	DWORD PTR -20[rbp], 1		# i++
.L4:
	mov	eax, DWORD PTR -20[rbp]		# i < n
	cmp	eax, DWORD PTR -44[rbp]
	jl	.L5
	mov	rax, QWORD PTR -32[rbp]		# return b - модиф массива
	mov	rbx, QWORD PTR -8[rbp]
	leave					#/Функция отработала
	ret					#\
	.size	mod_arr, .-mod_arr
	.section	.rodata
.LC0:
	.string	"%d "				#.LC0:  "%d"
	.text
	.globl	main
	.type	main, @function
main:
	push	rbp				# /Сохраняем rbp на стек
	mov	rbp, rsp			# |rbp := rsp
	sub	rsp, 48				# \rsp -= 48
	mov	DWORD PTR -36[rbp], edi		# edi - 1й - argc - 32bit
	mov	QWORD PTR -48[rbp], rsi		# rsi - 2й - argv - 64bit
	mov	eax, DWORD PTR -36[rbp]		# eax = argc
	sub	eax, 1				# eax - argc минус 1
	mov	DWORD PTR -12[rbp], eax		# rbp[-12] = eax - переменная n
	mov	eax, DWORD PTR -12[rbp]		# eax = n (Можно убрать)
	cdqe					# sign-extend
	sal	rax, 2
	mov	rdi, rax			# rdi = rax
	call	malloc@PLT			# malloc(n * sizeof(*a))
	mov	QWORD PTR -24[rbp], rax		# rbp[-24] - массив a*
	mov	DWORD PTR -4[rbp], 0		#rbp[-4] = 0
	jmp	.L8				# => L8
.L9:
	mov	eax, DWORD PTR -4[rbp]		# eax = rbp[-4] - i
	cdqe					# sign-extend
	add	rax, 1				# i + 1
	lea	rdx, 0[0+rax*8]			# rdx = rax * 8
	mov	rax, QWORD PTR -48[rbp]		# rax = rbp[-48] - argv
	add	rax, rdx			# strtol и далее...
	mov	rax, QWORD PTR [rax]
	mov	edx, 10
	mov	esi, 0
	mov	rdi, rax
	call	strtol@PLT			# strtol(argv[i + 1], NULL, 10)
	mov	edx, DWORD PTR -4[rbp]
	movsx	rdx, edx
	lea	rcx, 0[0+rdx*4]			# rcx = rdx * 4 
	mov	rdx, QWORD PTR -24[rbp]		# rdx = rbp[-24] (масс а)
	add	rdx, rcx
	mov	DWORD PTR [rdx], eax		# Сохранили результат
	add	DWORD PTR -4[rbp], 1		# i++
.L8:
	mov	eax, DWORD PTR -4[rbp]		# i = 0
	cmp	eax, DWORD PTR -12[rbp]		# i < n
	jl	.L9
	mov	edx, DWORD PTR -12[rbp]		# n
	mov	rax, QWORD PTR -24[rbp]		# a
	mov	esi, edx
	mov	rdi, rax
	call	mod_arr				# int * mod_arr(int *arr, int n)
	mov	QWORD PTR -32[rbp], rax		# в *b положили результат ф-ии
	mov	DWORD PTR -8[rbp], 0		# rbp[-8] = 0 - i
	jmp	.L10
.L11:						# Вывод ответа	
	mov	eax, DWORD PTR -8[rbp]		
	cdqe
	lea	rdx, 0[0+rax*4]			# Вычисление смещения для индексации в массиве
	mov	rax, QWORD PTR -32[rbp]
	add	rax, rdx
	mov	eax, DWORD PTR [rax]
	mov	esi, eax
	lea	rax, .LC0[rip]
	mov	rdi, rax
	mov	eax, 0
	call	printf@PLT
	add	DWORD PTR -8[rbp], 1
.L10:						# вывод "\n" и очистка массивов.
	mov	eax, DWORD PTR -8[rbp] 		# i < n
	cmp	eax, DWORD PTR -12[rbp]
	jl	.L11
	mov	edi, 10
	call	putchar@PLT
	mov	rax, QWORD PTR -24[rbp]
	mov	rdi, rax
	call	free@PLT
	mov	rax, QWORD PTR -32[rbp]
	mov	rdi, rax
	call	free@PLT
	mov	eax, 0
	leave					# /Выход из функции.
	ret					# \
	.size	main, .-main
