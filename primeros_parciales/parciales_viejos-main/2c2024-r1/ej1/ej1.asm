extern malloc
extern free

section .rodata
; Acá se pueden poner todas las máscaras y datos que necesiten para el ejercicio

section .text
; Marca un ejercicio como aún no completado (esto hace que no corran sus tests)
FALSE EQU 0
; Marca un ejercicio como hecho
TRUE  EQU 1

FILAS EQU 255
COLUMNAS EQU 255

; Marca el ejercicio 1A como hecho (`true`) o pendiente (`false`).
;
; Funciones a implementar:
;   - optimizar
global EJERCICIO_1A_HECHO
EJERCICIO_1A_HECHO: db TRUE ; Cambiar por `TRUE` para correr los tests.

; Marca el ejercicio 1B como hecho (`true`) o pendiente (`false`).
;
; Funciones a implementar:
;   - contarCombustibleAsignado
global EJERCICIO_1B_HECHO
EJERCICIO_1B_HECHO: db TRUE ; Cambiar por `TRUE` para correr los tests.

; Marca el ejercicio 1C como hecho (`true`) o pendiente (`false`).
;
; Funciones a implementar:
;   - modificarUnidad
global EJERCICIO_1C_HECHO
EJERCICIO_1C_HECHO: db TRUE ; Cambiar por `TRUE` para correr los tests.

;########### ESTOS SON LOS OFFSETS Y TAMAÑO DE LOS STRUCTS
; Completar las definiciones (serán revisadas por ABI enforcer):
ATTACKUNIT_CLASE EQU 0
ATTACKUNIT_COMBUSTIBLE EQU 12
ATTACKUNIT_REFERENCES EQU 14
ATTACKUNIT_SIZE EQU 16

global optimizar
optimizar:
	; Te recomendamos llenar una tablita acá con cada parámetro y su
	; ubicación según la convención de llamada. Prestá atención a qué
	; valores son de 64 bits y qué valores son de 32 bits o 8 bits.
	;
	; r/m64 = mapa_t           mapa
	; r/m64 = attackunit_t*    compartida
	; r/m64 = uint32_t*        fun_hash(attackunit_t*)
	push rbp
	mov rbp, rsp
	push r12
	push r13
	push r14
	push r15
	push rbx
	sub rsp, 8 ; pila alineada

	mov r12, rdi ; mapa
	mov r13, rsi ; compartida
	mov r14, rdx ; fun_hash
	xor r15, r15 ; iterador

	; calculo en hash de la unidad compartida
	mov rdi, r13
	call r14
	mov ebx, eax ; hash compartida

	.loop:
		mov rdi, [r12 + 8 * r15] ; unidad actual
		cmp rdi, 0 ; ¿Es un null pointer?
		je .nextIteration

		cmp rdi, r13 ; ¿Es compartida == actual?
		je .nextIteration

		call r14 ; la unidad actual ya está en rdi
		cmp eax, ebx ; ¿Es hash_compartida == hash_actual?
		jne .nextIteration

		; actualizo los contadores de referencias
		inc BYTE [r13 + ATTACKUNIT_REFERENCES] ; compartida->references++
		mov rdi, [r12 + 8 * r15] ; unidad actual
		dec BYTE [rdi + ATTACKUNIT_REFERENCES] ; actual->references--
		mov [r12 + 8 * r15], r13 ; mapa[i][j] = compartida

		; ¿tengo que borrar la unidad que acabo de reemplazar?
		cmp BYTE [rdi + ATTACKUNIT_REFERENCES], 0
		jne .nextIteration
		call free ; la unidad actual ya está en rdi

	.nextIteration:
		inc r15
		cmp r15, FILAS * COLUMNAS
		jl .loop

		add rsp, 8
		pop rbx
		pop r15
		pop r14
		pop r13
		pop r12
		pop rbp
		ret

global contarCombustibleAsignado
contarCombustibleAsignado:
	; r/m64 = mapa_t           mapa
	; r/m64 = uint16_t*        fun_combustible(char*)
	push rbp
	mov rbp, rsp
	push r12
	push r13
	push r14
	push r15
	push rbx
	sub rsp, 8 ; pila alineada

	mov r15, rdi ; mapa
	mov r14, rsi ; fun_combustible
	xor r13, r13 ; total_combustible_utilizado
	xor r12, r12 ; iterador

	.loop:
		mov rsi, [r15 + 8 * r12] ; unidad actual
		cmp rsi, 0 ; ¿Es un null pointer?
		je .nextIteration

		movzx ebx, WORD [rsi + ATTACKUNIT_COMBUSTIBLE] ; actual->combustible

		add rsi, ATTACKUNIT_CLASE ; este add no es realmente necesario, el offset de clase es 0
		mov rdi, rsi; el puntero a donde comienza el string actual->clase (la función toma un char*)
		call r14
		movzx eax, ax ; combustible_base

		sub ebx, eax ; combustible_utilizado = actual->combustible - combustible_base
		add r13d, ebx ; total_combustible_utilizado += combustible_utilizado

	.nextIteration:
		inc r12
		cmp r12, FILAS * COLUMNAS
		jl .loop

		mov rax, r13

		add rsp, 8
		pop rbx
		pop r15
		pop r14
		pop r13
		pop r12
		pop rbp
		ret


global modificarUnidad
modificarUnidad:
	; r/m64 = mapa_t           mapa
	; r/m8  = uint8_t          x
	; r/m8  = uint8_t          y
	; r/m64 = void*            fun_modificar(attackunit_t*)
	push rbp
	mov rbp, rsp
	push r13
	push r14
	push r15
	sub rsp, 8 ; pila alineada

	; me muevo a la posición del mapa que quiero modificar
	movzx rsi, sil ; extiendo x a 8 bytes
	movzx rdx, dl ; extiendo y a 8 bytes

	; acá puedo usar una multiplicación con signo porque en el fondo
	; estoy multiplicando dos uint8_t. Nunca voy a tener overflow.
	; La instrucción imul es un poco más cómoda de usar que mul.
	; También se podría multiplicar por 256 shifteando a izquierda y restando 1 :)
	imul rsi, COLUMNAS ; x * COLUMNAS -> rsi
	add rdx, rsi ; y + x * 255 -> rdx
	shl rdx, 3 ; multiplico rdx por 8 (2^3) para obtener (y + 255 * x) * 8 -> rdx
	add rdi, rdx ; offset en el mapa donde tengo que moidificar

	mov r15, rdi ; posición a modificar en el mapa. Esto es efectivamente attackunit_t**
	mov r14, rcx ; fun_modificar

	mov r13, [r15] ; r13 es la unidad a modificar
	cmp r13, 0 ; ¿Es un puntero NULL?
	je .end

	mov r9b, [r13 + ATTACKUNIT_REFERENCES]
	cmp r9b, 1
	jle .skipCopy
	; si la untidad que tengo en el mapa tiene más de una referencia, la tengo que copiar.
	; Solo quiero modificar esta posición en el tablero del juego.

	; decremento las referencias de esta unidad (esta posición será reemplazada con una copia)
	dec BYTE [r13 + ATTACKUNIT_REFERENCES]

	; reservo memoria en el heap para la nueva unidad
	mov rdi, ATTACKUNIT_SIZE
	call malloc ; rax contiene un puntero a la nueva attackunit_t
	mov rdi, [r13] ; copio bytes 0 a 8
	mov [rax], rdi
	mov rdi, [r13 + 8] ; copio bytes 8 a 16
	mov [rax + 8], rdi

	mov [rax + ATTACKUNIT_REFERENCES], BYTE 1 ; esta unidad se referencia solo en esta posición
	mov [r15], rax ; escribo en el mapa el puntero a la nueva unidad

	.skipCopy:
		; modifico la unidad que está en la posición actual del tablero
		mov rdi, [r15]
		call r14

	.end:
		add rsp, 8
		pop r15
		pop r14
		pop r13
		pop rbp
		ret