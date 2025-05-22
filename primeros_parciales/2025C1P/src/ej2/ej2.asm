extern strcmp
global invocar_habilidad

; Completar las definiciones o borrarlas (en este ejercicio NO serán revisadas por el ABI enforcer)
DIRENTRY_NAME_OFFSET EQU 0
DIRENTRY_PTR_OFFSET EQU 16
DIRENTRY_SIZE EQU 24

FANTASTRUCO_DIR_OFFSET EQU 0
FANTASTRUCO_ENTRIES_OFFSET EQU 8
FANTASTRUCO_ARCHETYPE_OFFSET EQU 16
FANTASTRUCO_FACEUP_OFFSET EQU 24
FANTASTRUCO_SIZE EQU 32

section .rodata
; Acá se pueden poner todas las máscaras y datos que necesiten para el ejercicio

section .text

; void invocar_habilidad(void* carta, char* habilidad);
invocar_habilidad:
	; Te recomendamos llenar una tablita acá con cada parámetro y su
	; ubicación según la convención de llamada. Prestá atención a qué
	; valores son de 64 bits y qué valores son de 32 bits o 8 bits.
	;
	; rdi = void*    card ; Vale asumir que card siempre es al menos un card_t*
	; rsi = char*    habilidad
	push rbp
	mov rbp, rsp
	push r12
	push r13
	push r14
	push r15


	mov r12, rdi
	mov r13, rsi
	
	mov r14, [r12 + FANTASTRUCO_DIR_OFFSET]
	xor r15, r15
	mov r15w, WORD[r12 + FANTASTRUCO_ENTRIES_OFFSET]

	.loop:
		cmp r15, 0
		je .no_hay_mas_entradas

		mov rdi, r13
		mov rsi, [r14]
		call strcmp
		cmp rax, 0
		jz .encontrada

		dec r15
		add r14, 8
		jmp .loop


	.encontrada:
		mov r8, [r14]
		mov r9, [r8 + DIRENTRY_PTR_OFFSET]
		mov rdi, r12
		call r9
		jmp .fin

	.no_hay_mas_entradas:
		mov r10, [r12 + FANTASTRUCO_ARCHETYPE_OFFSET]
		cmp r10, 0
		jz .fin
		mov rdi, r10
		mov rsi, r13
		call invocar_habilidad

	.fin:
	pop r15
	pop r14
	pop r13
	pop r12
	pop rbp
	ret ;No te olvides el ret!
