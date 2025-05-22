extern malloc

section .rodata
; Acá se pueden poner todas las máscaras y datos que necesiten para el ejercicio

section .text
; Marca un ejercicio como aún no completado (esto hace que no corran sus tests)
FALSE EQU 0
; Marca un ejercicio como hecho
TRUE  EQU 1

; Marca el ejercicio 1A como hecho (`true`) o pendiente (`false`).
;
; Funciones a implementar:
;   - es_indice_ordenado
global EJERCICIO_1A_HECHO
EJERCICIO_1A_HECHO: db TRUE ; Cambiar por `TRUE` para correr los tests.

; Marca el ejercicio 1B como hecho (`true`) o pendiente (`false`).
;
; Funciones a implementar:
;   - indice_a_inventario
global EJERCICIO_1B_HECHO
EJERCICIO_1B_HECHO: db TRUE ; Cambiar por `TRUE` para correr los tests.

;########### ESTOS SON LOS OFFSETS Y TAMAÑO DE LOS STRUCTS
; Completar las definiciones (serán revisadas por ABI enforcer):
ITEM_NOMBRE EQU 0
ITEM_FUERZA EQU 20
ITEM_DURABILIDAD EQU 24
ITEM_SIZE EQU 28

;; La funcion debe verificar si una vista del inventario está correctamente 
;; ordenada de acuerdo a un criterio (comparador)

;; bool es_indice_ordenado(item_t** inventario, uint16_t* indice, uint16_t tamanio, comparador_t comparador);

;; Dónde:
;; - `inventario`: Un array de punteros a ítems que representa el inventario a
;;   procesar.
;; - `indice`: El arreglo de índices en el inventario que representa la vista.
;; - `tamanio`: El tamaño del inventario (y de la vista).
;; - `comparador`: La función de comparación que a utilizar para verificar el
;;   orden.
;; 
;; Tenga en consideración:
;; - `tamanio` es un valor de 16 bits. La parte alta del registro en dónde viene
;;   como parámetro podría tener basura.
;; - `comparador` es una dirección de memoria a la que se debe saltar (vía `jmp` o
;;   `call`) para comenzar la ejecución de la subrutina en cuestión.
;; - Los tamaños de los arrays `inventario` e `indice` son ambos `tamanio`.
;; - `false` es el valor `0` y `true` es todo valor distinto de `0`.
;; - Importa que los ítems estén ordenados según el comparador. No hay necesidad
;;   de verificar que el orden sea estable.

global es_indice_ordenado
es_indice_ordenado:
	; Te recomendamos llenar una tablita acá con cada parámetro y su
	; ubicación según la convención de llamada. Prestá atención a qué
	; valores son de 64 bits y qué valores son de 32 bits o 8 bits.
	;
	; rdi = item_t**     inventario
	; rsi = uint16_t*    indice
	; dx = uint16_t     tamanio
	; rcx = comparador_t comparador

	push rbp
	mov rbp, rsp
	push r12
	push r13
	push r14
	push r15
	push rbx
	sub rbp, 8

	; Guardamos argumentos
	mov r12, rdi        ; r12 = inventario
	mov r13, rsi        ; r13 = indice
	movzx r14, dx       ; r14 = tamanio (zero-extend porque es uint16_t)
	mov r15, rcx        ; r15 = comparador

	mov rbx, 1          ; repuesta = true

	cmp r14, 1
	jbe .fin            ; Si tamanio <= 1, ya está ordenado

	xor r8, r8          ; r8 = i
	dec r14
.loop
	cmp r8, r14        ; Si i+1 >= tamanio, salir
	je .fin

	; r9 = indice[i]
	movzx r9, word [r13 + r8*2]
	; r10 = indice[i+1]
	mov r11, r8
	inc r11
	movzx r10, word [r13 + r11*2]

	; rdi = inventario[indice[i]]
	mov rdi, [r12 + r9*8]
	; rsi = inventario[indice[i+1]]
	mov rsi, [r12 + r10*8]

	call r15            ; comparador(item1, item2)

	cmp rax, 0
	je .desordenado

	inc r8
	jmp .loop

.desordenado:
	mov rbx, 0

.fin:
	mov rax, rbx

	add rbp, 8
	pop rbx
	pop r15
	pop r14
	pop r13
	pop r12
	pop rbp
ret
;; Dado un inventario y una vista, crear un nuevo inventario que mantenga el
;; orden descrito por la misma.

;; La memoria a solicitar para el nuevo inventario debe poder ser liberada
;; utilizando `free(ptr)`.

;; item_t** indice_a_inventario(item_t** inventario, uint16_t* indice, uint16_t tamanio);

;; Donde:
;; - `inventario` un array de punteros a ítems que representa el inventario a
;;   procesar.
;; - `indice` es el arreglo de índices en el inventario que representa la vista
;;   que vamos a usar para reorganizar el inventario.
;; - `tamanio` es el tamaño del inventario.
;; 
;; Tenga en consideración:
;; - Tanto los elementos de `inventario` como los del resultado son punteros a
;;   `ítems`. Se pide *copiar* estos punteros, **no se deben crear ni clonar
;;   ítems**

global indice_a_inventario
indice_a_inventario:
	; Te recomendamos llenar una tablita acá con cada parámetro y su
	; ubicación según la convención de llamada. Prestá atención a qué
	; valores son de 64 bits y qué valores son de 32 bits o 8 bits.
	;
	; rdi = item_t**  inventario
	; rsi = uint16_t* indice
	; dx = uint16_t  tamanio
	push rbp
	mov rbp, rsp
	push r12
	push r13
	push r14
	sub rbp, 8

	mov r12, rdi
	mov r13, rsi
	xor r14, r14
	mov r14w, dx

	mov rdi, r14
	imul rdi, 8
	call malloc
	mov r10, rax
	xor r8, r8
	.loop:
		cmp r8, r14
		je .fin
		movzx r9, word [r13 + r8*2]
		mov r10, [r12 + r9*8]      ; r10 = inventario[indice[i]]
		mov [rax + r8*8], r10      ; resultado[i] = r10 
		inc r8
		jmp .loop

	.fin:
	add rbp, 8
	pop r14
	pop r13
	pop r12
	pop rbp
	ret
