%macro escribir 2
    mov eax, 4
    mov ebx, 1
    mov ecx, %1
    mov edx, %2
    int 80h
%endmacro

%macro leer 2
    mov eax, 3
    mov ebx, 0
    mov ecx, %1
    mov edx, %2
    int 80h
%endmacro

section .data
    msj db 'Ingrese un numero: ',
    len equ $-msj

    msjP db 'es par',10
    lenP equ $-msjP

    msjI db 'es impar',10
    lenI equ $-msjI

    newLine db '',10

    espace db ' '

section .bss
    numero resb 2
section .text
    global _start
_start:

    mov ecx, 7
pedirNumero:
    push ecx
    escribir msj, len
    leer numero, 2
    pop ecx

    mov eax, [numero]
    sub eax, '0'
    push eax

    loop pedirNumero
    escribir newLine,1
    mov ecx, 7
verTipo:
    pop eax
    push ecx

    push eax
    call printNum
    pop ebx

    mov al, bl
    mov bl, 2
    div bl

    call comparar

    pop ecx
    loop verTipo
    jmp salir

printNum:
    add eax, '0'
    mov [numero], eax
    escribir numero, 1
    ret 

comparar:
    cmp ah, 0
    je printPar
    jmp printImpar

printPar:
    escribir espace,1
    escribir msjP, lenP
    ret

printImpar:
    escribir espace,1
    escribir msjI, lenI
    ret

salir:
    escribir newLine,1
    mov eax, 1
    int 80h