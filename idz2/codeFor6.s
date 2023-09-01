	.file	"codeFor6.c"
	.intel_syntax noprefix
	.text
	.globl	arr
	.bss
	.align 32
	.type	arr, @object
	.size	arr, 10000
arr:
	.zero	10000			#Массив чаров при вводе.
	.section	.rodata
.LC0:
	.string	"0x%x"
	.text
	.globl	mod_arr
	.type	mod_arr, @function
mod_arr:				#Функция перевода гласных в 0xDD, тип - void.
	push	rbp
	mov	rbp, rsp
	push	r12			#Используем регистр r12 для i, до этого было для lenght
	sub	rsp, 40
	mov	QWORD PTR -40[rbp], rdi #rbp[-40] = rdi - передали переменные arr и lenght
	mov	DWORD PTR -44[rbp], esi #rbp[-44] = esi
	mov	r12d, 0			#i = 0 - теперь используем r12 для i, lenght так и так на стеке
	jmp	.L2
.L6:
	mov	eax, r12d		#char k = arr[i]
	movsx	rdx, eax
	mov	rax, QWORD PTR -40[rbp]
	add	rax, rdx
	movzx	eax, BYTE PTR [rax]
	mov	BYTE PTR -17[rbp], al	#Тут сравнения текущего символа со всеми гласными.
	cmp	BYTE PTR -17[rbp], 97
	je	.L3
	cmp	BYTE PTR -17[rbp], 101
	je	.L3
	cmp	BYTE PTR -17[rbp], 105
	je	.L3
	cmp	BYTE PTR -17[rbp], 111
	je	.L3
	cmp	BYTE PTR -17[rbp], 117
	je	.L3
	cmp	BYTE PTR -17[rbp], 121
	jne	.L4
.L3:					      #Преобразует гласную в 0xDD
	mov	eax, r12d
	movsx	rdx, eax
	mov	rax, QWORD PTR -40[rbp]
	add	rax, rdx
	movzx	eax, BYTE PTR [rax]
	movsx	eax, al
	mov	esi, eax
	lea	rax, .LC0[rip]
	mov	rdi, rax
	mov	eax, 0
	call	printf@PLT
	jmp	.L5
.L4:						#putchar(arr[i])
	mov	eax, r12d
	movsx	rdx, eax
	mov	rax, QWORD PTR -40[rbp]
	add	rax, rdx
	movzx	eax, BYTE PTR [rax]
	movsx	eax, al
	mov	edi, eax
	call	putchar@PLT
.L5:						#i++
	mov	eax, r12d
	add	eax, 1
	mov	r12d, eax
.L2:
	mov	eax, r12d
	cmp	DWORD PTR -44[rbp], eax	         # i < lenght
	jg	.L6
	nop
	nop
	mov	r12, QWORD PTR -8[rbp]		 #чистим r12
	leave
	ret
	.size	mod_arr, .-mod_arr
	.section	.rodata
.LC1:
	.string	"ERROR. INPUT TOO BIG-UWU"
	.text
	.globl	main
	.type	main, @function
main:	
	push	rbp
	mov	rbp, rsp
	push	r12				#наш регистр r12 - lenght
	sub	rsp, 24
	mov	DWORD PTR -20[rbp], edi 	#argc-argv
	mov	QWORD PTR -32[rbp], rsi
	mov	r12d, 0				#lenght = 0
.L9:
	mov	rax, QWORD PTR stdin[rip] 	#Приколюхи от fgetc - arr[lenght++] = ch
	mov	rdi, rax
	call	fgetc@PLT
	mov	r11d, eax		  	#наш регистр r11 для chr
	mov	eax, r12d
	lea	edx, 1[rax]		  	#lengh++
	mov	r12d, edx
	mov	ecx, r11d
	cdqe
	lea	rdx, arr[rip]
	mov	BYTE PTR [rax+rdx], cl
	mov	eax, r11d
	cmp	al, -1				#ch != -1 && lenght < 10000
	je	.L8
	mov	eax, r12d
	cmp	eax, 9999
	jle	.L9
.L8:						#if на проверку input данных
	mov	eax, r12d
	sub	eax, 1				#lenght--
	mov	r12d, eax
	mov	eax, r11d
	cmp	al, -1				
	je	.L10
	mov	eax, r12d
	cmp	eax, 9999
	jle	.L10
	lea	rax, .LC1[rip]
	mov	rdi, rax
	mov	eax, 0
	call	printf@PLT
	mov	eax, 0
	jmp	.L11
.L10:
	mov	edi, 10				#\n
	call	putchar@PLT
	mov	eax, r12d
	mov	esi, eax
	lea	rax, arr[rip]
	mov	rdi, rax
	call	mod_arr				#вызов ф-ии с агрументами *arr и lenght
	mov	eax, 0
.L11:
	mov	r12, QWORD PTR -8[rbp]		#чистим r12
	leave					#Выход из ф-ии
	ret
	.size	main, .-main
