section .text

global contar_pagos_aprobados_asm
global contar_pagos_rechazados_asm

global split_pagos_usuario_asm

extern malloc
extern free
extern strcmp


;########### SECCION DE TEXTO (PROGRAMA)

; uint8_t contar_pagos_aprobados_asm(list_t* pList, char* usuario);
contar_pagos_aprobados_asm:
push rbp
    mov rbp, rsp
    push r12
    push r13
    push r14
    push r15

    mov r12, rdi        ; r12 = pList
    mov r13, rsi        ; r13 = usuario
    xor r14, r14        ; r14 = contador = 0
    mov r15, [r12]      ; r15 = actual = pList->first

.loop:
    cmp r15, 0
    je .fin

    mov rdi, [r15]          ; rdi = actual->data (pago_t*)
    test rdi, rdi
    je .next

    cmp byte [rdi + 1], 1   ; pago->aprobado == 1 ?
    jne .next

    ; comparar pagador
    mov rax, [rdi + 8]      ; rax = pago->pagador
    test rax, rax
    je .check_cobrador
    mov rdi, rax
    mov rsi, r13
    call strcmp
    cmp rax, 0
    je .inc

.check_cobrador:
    mov rax, [rdi + 16]     ; rax = pago->cobrador
    test rax, rax
    je .next
    mov rdi, rax
    mov rsi, r13
    call strcmp
    cmp rax, 0
    jne .next

.inc:
    inc r14

.next:
    mov r15, [r15 + 16]     ; avanzar actual = actual->next
    jmp .loop

.fin:
    movzx rax, r14b          ; resultado en rax
    pop r15
    pop r14
    pop r13
    pop r12
    pop rbp
    ret

; uint8_t contar_pagos_rechazados_asm(list_t* pList, char* usuario);
contar_pagos_rechazados_asm:

; pagoSplitted_t* split_pagos_usuario_asm(list_t* pList, char* usuario);
split_pagos_usuario_asm:

