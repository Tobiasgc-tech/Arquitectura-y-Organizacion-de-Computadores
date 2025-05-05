extern malloc
extern free
extern fprintf

section .data

section .text

global strCmp
global strClone
global strDelete
global strPrint
global strLen

; ** String **

; int32_t strCmp(char* a, char* b)
strCmp:
    ; RDI = a, RSI = b

	.loop:
    	mov r8b, [rdi]       ; al = *a
    	mov r9b, [rsi]       ; bl = *b

    	cmp r8b, 0
    	je .check_end
    	cmp r9b, 0
    	je .check_end

		cmp r8b, r9b
		jne .diferentes

		inc rdi
		inc rsi
		jmp .loop

	.diferentes:
    	cmp r8b, r9b
    	ja .aMasGrande    ; unsigned: r8b > r9b
    	jb .bMasGrande    ; unsigned: r8b < r9b

	.check_end:
    	; si ambos son nulos, son iguales
    	cmp r8b, 0
    	jne .bMasGrande       ; si a no terminó, pero b sí, entonces a > b → return 1
    	cmp r9b, 0
    	jne .aMasGrande       ; si b no terminó, pero a sí, entonces a < b → return -1
    	mov eax, 0
    	ret

	.aMasGrande:
    	mov eax, 1
    	ret

	.bMasGrande:
    	mov eax, -1
    	ret

; char* strClone(char* a)
strClone:

; void strDelete(char* a)
strDelete:
	ret

; void strPrint(char* a, FILE* pFile)
strPrint:
	ret

; uint32_t strLen(char* a)
strLen:
	xor eax, eax
	.loop:
		mov r8b, [rdi]
		cmp r8b, 0
		je .fin
		inc eax
		inc rdi
		jmp .loop
	.fin:
		ret


