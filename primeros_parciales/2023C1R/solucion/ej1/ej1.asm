global acumuladoPorCliente_asm
global en_blacklist_asm
global blacklistComercios_asm

extern calloc

%define CANTIDAD_DE_CLIENTES 10
%define SIZE_OF_INT32 4
%define OFFSET_monto 0
%define OFFSET_comercio 8
%define OFFSET_cliente 16
%define OFFSET_aprobado 17

;########### SECCION DE TEXTO (PROGRAMA)
section .text

;cantidadDePagos = dil, arr_pagos = rsi
acumuladoPorCliente_asm:
	push rbp
	mov rbp, rsp
	push r12
	push r13
	xor r12, r12
	mov r12b, dl
	mov r13, rsi

	mov rdi, CANTIDAD_DE_CLIENTES
	mov rsi, SIZE_OF_INT32
	call calloc

	xor r8, r8 ; i = 0
	xor r9, r9
	xor r10, r10
	.loop:
		cmp r8b, r12b
		jl .fin
		mov r10b, byte [r13 + OFFSET_aprobado]
		cmp r10, 1
		jne .siguenteIteracion
		mov r9b, byte [r13 + OFFSET_cliente]
		mov cl, byte [r13 + OFFSET_monto]
		add dword [rax + r9 * 4] , ecx
		.siguenteIteracion:
		inc r8b
		jmp .loop
	.fin:
	pop r13
	pop r12
	pop rbp
	ret

en_blacklist_asm:
	ret

blacklistComercios_asm:
	ret
