global templosClasicos
global cuantosTemplosClasicos

extern malloc
OFFSET_LARGO EQU 0
OFFSET_NOMBRE EQU 8
OFFSET_CORTO EQU 16
SIZE_OF_TEMPLO EQU 24

%define OFFSET_LARGO 0
%define OFFSET_NOMBRE 8
%define OFFSET_CORTO 16
%define SIZE_OF_TEMPLO 24

;########### SECCION DE TEXTO (PROGRAMA)
section .text

;rdi = temploArr
;rsi = temploArr_len
cuantosTemplosClasicos:
    push rbp
    mov rbp, rsp
    push r12
    push r13

    mov r12, rdi
    mov r13, rsi

    xor rax, rax ; repuesta = 0
    .loop:
        xor r8, r8
        mov r8b, byte[r12 + OFFSET_LARGO] ;columLargo
        xor r9, r9
        mov r9b, byte[r12 + OFFSET_CORTO] ;columCorto
        shl r9, 1
        add r9, 1

        cmp r9, r8
        jne .siguienteIteracion
        
        add rax, 1

        .siguienteIteracion:
        add r12, SIZE_OF_TEMPLO
        dec r13
        cmp r13, 0
        jne .loop
    
    pop r13
    pop r12
    pop rbp
    ret



;rdi = temploArr
;rsi = temploArr_len

templosClasicos:
    push rbp
    mov rbp, rsp
    push r12
    push r13
    push r14
    sub rsp, 8

    mov r12, rdi ;r12 = temploArr
    mov r13, rsi ;r13 = temploArr_len

    call cuantosTemplosClasicos ;rax = cantidadDeTemplos

    mov rdi, rax
    imul rdi, SIZE_OF_TEMPLO

    call malloc 

    mov r14, rax ; r14 = puntero al comienzo de repuesta

    .ciclo:
        xor r8, r8
        mov r8b, byte[r12 + OFFSET_LARGO] ;columLargo
        xor r9, r9
        mov r9b, byte[r12 + OFFSET_CORTO] ;columCorto
        shl r9, 1
        add r9, 1
        cmp r9, r8
        jne .siguienteTemplo

        xor r10, r10

        mov r10b, byte[r12 + OFFSET_LARGO]
        mov byte [r14 + OFFSET_LARGO] , r10b
        
        mov r10b, [r12 + OFFSET_NOMBRE]
        mov  [r14 + OFFSET_NOMBRE] , r10

        mov r10b, byte[r12 + OFFSET_CORTO]
        mov byte [r14 + OFFSET_CORTO] , r10b

        add r14, SIZE_OF_TEMPLO

        .siguienteTemplo:
            add r12, SIZE_OF_TEMPLO
            dec r13
            cmp r13, 0
            jne .ciclo

    add rsp, 8
    pop r14
    pop r13
    pop r12
    pop rbp
    ret







